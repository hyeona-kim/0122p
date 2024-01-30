package com.ict.project.control;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.BoardService;
import com.ict.project.service.CourseService;
import com.ict.project.util.FileRenameUtil;
import com.ict.project.util.Paging;
import com.ict.project.vo.BoardVO;
import com.ict.project.vo.CourseVO;

@Controller
public class BoardController {
    @Autowired
    HttpServletRequest request;
    @Autowired
    HttpSession session;
    @Autowired
    ServletContext application;
	@Autowired
	BoardService b_Service;
	@Autowired
	CourseService c_Service;
	
	private List<BoardVO> bd_r_list;
	int reply_key = 0;

	// 처음 게시판 클릭했을 때 시작하는 곳
	@RequestMapping("boardMainList")
	public ModelAndView boardMainList(String cPage, String c_idx) {
		ModelAndView mv = new ModelAndView();
		/* if((c_idx != null && c_idx.equals("undefined")) && reply_key == 1){
			mv.addObject("c_idx", c_idx);
			mv.addObject("reply_key", reply_key);
		} */
		
		mv.addObject("c_idx", c_idx);
		mv.addObject("cPage", cPage);
		mv.setViewName("/jsp/admin/schoolRecord/boardMain");
		return mv;
	}

	// boardMainList로 들어왔을 때
	// ajax통신으로 처음 목록 뽑아서 출력하는 곳
	// 이때 cPage를 가지고 Paging기법을 계속 반복한다.
	@RequestMapping("boardCourseAjax")
	public ModelAndView boardCourseAjax(String cPage) {
		ModelAndView mv = new ModelAndView();
		Paging page = new Paging();
		page.setTotalRecord(c_Service.getCount());

		if(cPage == null || cPage.equalsIgnoreCase("undefined")){
			page.setNowPage(1);
		}else {
			page.setNowPage(Integer.parseInt(cPage));
		}
		
		CourseVO[] ar = c_Service.getCourseList(String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
	
		mv.addObject("ar", ar);
		mv.addObject("page", page);
		mv.setViewName("/jsp/admin/schoolRecord/boardCourse_Ajax");
		
		return mv;
	}
	
    @RequestMapping("boardList")
    public ModelAndView boardList(String c_idx, String cPage) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("c_idx", c_idx);
		mv.addObject("cPage", cPage);
		mv.setViewName("/jsp/admin/schoolRecord/boardList");
        return mv;
    }

	@RequestMapping("boardListAjax")
	public ModelAndView boardListAjax(String c_idx, String cPage) {
		ModelAndView mv = new ModelAndView();
		BoardVO[] ar = null;
		Paging page = null;
		boolean viewList_flag = true;
		Object obj_ar = request.getAttribute("ar");
		Object obj_p = request.getAttribute("page");
		
		if(obj_p == null) {
			page = new Paging();
			page.setTotalRecord(b_Service.cntBoardList(c_idx));
		}else {
			page = (Paging)obj_p;
		}
		
		if(cPage == null || cPage.equalsIgnoreCase("undefined"))
			page.setNowPage(1);
		else {
			page.setNowPage(Integer.parseInt(cPage));
		}
		
		if(obj_ar == null) {
			ar = b_Service.viewBoardList(c_idx, String.valueOf(page.getBegin()) ,String.valueOf(page.getEnd()));
		}else {
			ar = (BoardVO[])obj_ar;
			
		}
		mv.addObject("viewList_flag", viewList_flag);
		mv.addObject("c_idx", c_idx);
		mv.addObject("ar", ar);
		mv.addObject("page", page);
		
		mv.setViewName("/jsp/admin/schoolRecord/boardList_ajax");
		return mv;
	}
	
    @RequestMapping("addBoard")
    public ModelAndView addBoard(BoardVO bvo) {
		ModelAndView mv = new ModelAndView();
		String encType = request.getContentType();
		if(encType.startsWith("application")) {
			b_Service.addBoard(bvo);
		}else if(encType.startsWith("multipart")) {
			MultipartFile mf = bvo.getFile();
			String fname = null;

			if(mf != null && mf.getSize() > 0) {
				String realPath = application.getRealPath("upload_boardFile");

				String oname = mf.getOriginalFilename();

				fname = FileRenameUtil.checkSameFileName(oname, realPath);

				try {
					mf.transferTo(new File(realPath, fname));
				} catch (Exception e) {
					e.printStackTrace();
				}
				/* bvo.setBd_fname(fname);
				bvo.setBd_oname(oname); */
			}
			b_Service.addBoard(bvo);
		}

		mv.setViewName("redirect:boardList");
		return mv;
    }

	@RequestMapping("addBoardAjax")
	public String addBoard_ajax() {
		return "/jsp/admin/schoolRecord/addBoard_ajax";
	}

    @RequestMapping("boardAddReply")
    public String boardAddReply(BoardVO bvo) {		
		b_Service.addReply(bvo);
		return "redirect:boardList";
    }

	@RequestMapping("boardReplyAjax")
	public ModelAndView boardReplyAjax(String bd_idx) {
		ModelAndView mv = new ModelAndView();
		BoardVO bvo = b_Service.getBoard(bd_idx);
		mv.addObject("bvo", bvo);
		mv.setViewName("/jsp/admin/schoolRecord/boardReply_ajax");
		return mv;
	}
	

	@RequestMapping("boardViewAjax")
	public ModelAndView boardViewAjax(String bd_idx, String cPage){
		ModelAndView mv = new ModelAndView();
		BoardVO vo = b_Service.getBoard(bd_idx);

		Object obj = session.getAttribute("bd_r_list");
		if(obj == null) {
			bd_r_list = new ArrayList<BoardVO>();
			session.setAttribute("bd_r_list", bd_r_list);
		}else {
			bd_r_list = (ArrayList<BoardVO>) obj;
		}

		boolean read = CheckRead(vo);
		if(!read) {
			bd_r_list.add(vo);
			b_Service.addHit(bd_idx);
		}

		mv.addObject("bvo", vo);
		mv.setViewName("/jsp/admin/schoolRecord/boardView_ajax");

		return mv;
	}

	public boolean CheckRead(BoardVO vo) {
		boolean flag = false;

		for(int i=0; i<bd_r_list.size(); i++) {
			BoardVO bvo = bd_r_list.get(i);

			if(vo.getBd_idx().equals(bvo.getBd_idx())) {
				flag = true;
				break;
			}
		}
		return flag;
	}
    
    @RequestMapping("searchBoard")
    public ModelAndView searchBoard(String cPage,String value,String c_idx) {
		ModelAndView mv = new ModelAndView();
        BoardVO[] ar = null;
        Paging page = null;
        boolean search_flag = true;
        
        int cnt = b_Service.reGetTotalRecord(c_idx, value);
        
        if(cnt > 0) {
            page = new Paging();
            page.setTotalRecord(cnt);
            if(cPage == null || cPage.equals("undefined")) {
                page.setNowPage(1);				
            }else {
                page.setNowPage(Integer.parseInt(cPage));								
            }
            ar = b_Service.searchBoard(value, String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
        }
        
        mv.addObject("search_flag", search_flag);
        mv.addObject("ar", ar);
        mv.addObject("page", page);
		if(value.trim().length() > 0) {
			mv.setViewName("/jsp/admin/schoolRecord/boardList_ajax");
		}else {
			mv.setViewName("redirect:boardMain");
		}
		
        return mv;
    }
    @RequestMapping("boardMain")
    public String boardMain() {
        BoardVO[] ar = null;
		Paging page = null;
		
		Object obj_ar = request.getAttribute("ar");
		Object obj_p = request.getAttribute("page");
		
		if(obj_p == null) {
			page = new Paging();
			page.setTotalRecord(b_Service.getTotalRecord());
		}else {
			page = (Paging)obj_p;
		}
		
		String cPage = request.getParameter("cPage");
		
		if(cPage == null || cPage.equals("undefined"))
			page.setNowPage(1);
		else {
			int nowPage = Integer.parseInt(cPage);
			page.setNowPage(nowPage);
		}
		
		if(obj_ar == null) {
			ar = b_Service.list(String.valueOf(page.getBegin()),String.valueOf(page.getEnd()));
		}else {
			ar = (BoardVO[])obj_ar;
		}		
		
		request.setAttribute("ar", ar);
		request.setAttribute("page", page);
		
		return "/jsp/admin/schoolRecord/boardList_ajax";
    }
    
    @RequestMapping("checkNotice_board")
	public ModelAndView checkNotice(String cPage, String c_idx) {
		ModelAndView mv = new ModelAndView();
		BoardVO[] ar = null;
		Paging page = new Paging();
		boolean notice_flag = true;
		page.setTotalRecord(b_Service.cntNonNotice(c_idx));

		if(cPage == null || cPage.equals("undefined")) {
			page.setNowPage(1);
		}else {
			page.setNowPage(Integer.parseInt(cPage));
		}

		ar = b_Service.checkNotice(c_idx, String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));

		mv.addObject("ar", ar);
		mv.addObject("page", page);
		mv.addObject("notice_flag", notice_flag);
		mv.setViewName("/jsp/admin/schoolRecord/boardList_ajax");

		return mv;
	}

	@RequestMapping("viewBoardList")
	public ModelAndView getBoardList(String c_idx, String cPage) {
		ModelAndView mv = new ModelAndView();
		BoardVO[] ar = null;
		Paging page = new Paging();
		boolean viewList_flag = true;

		page.setTotalRecord(b_Service.cntBoardList(c_idx));

		if(cPage == null || cPage.equals("undefined")) {
			page.setNowPage(1);
		}else {
			page.setNowPage(Integer.parseInt(cPage));
		}

		ar = b_Service.viewBoardList(c_idx, String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));

		mv.addObject("cPage", cPage);
		mv.addObject("c_idx", c_idx);
		mv.addObject("viewList_flag", viewList_flag);
		mv.addObject("ar", ar);
		mv.addObject("page", page);
		mv.setViewName("/jsp/admin/schoolRecord/boardList_ajax");

		return mv;
	}

	// ======================= 이 밑으로는 test 중입니다 =======================
	@RequestMapping("test_viewBoardList")
	public ModelAndView test_viewBoardList(String c_idx, String cPage){
		ModelAndView mv = new ModelAndView();
		mv.addObject("cPage", cPage);
		mv.addObject("c_idx", c_idx);
		mv.setViewName("/jsp/admin/schoolRecord/test_viewBoardList");
		return mv;
	}

	@RequestMapping("test_boardListAjax")
	public ModelAndView test_boardListAjax(String cPage, String c_idx) {
		ModelAndView mv = new ModelAndView();
		BoardVO[] ar = null;
		Paging page = null;
		Object obj_p = request.getAttribute("page");
		if(obj_p == null) {
			page = new Paging();
			page.setNowPage(1);
		}else {
			page = (Paging) obj_p;
		}
		boolean viewList_flag = true;

		page.setTotalRecord(b_Service.cntBoardList(c_idx));

		if(cPage == null || cPage.equals("undefined") || cPage.trim().length() == 0){
			page.setNowPage(1);
		}else {
			page.setNowPage(Integer.parseInt(cPage));
		}
		ar = b_Service.viewBoardList(c_idx, String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));

		mv.addObject("ar", ar);
		mv.addObject("viewList_flag", viewList_flag);
		mv.addObject("c_idx", c_idx);
		mv.addObject("cPage", cPage);
		mv.addObject("page", page);
		mv.setViewName("/jsp/admin/schoolRecord/test_boardList_ajax");
		return mv;
	}

	// 게시글 [제목] 클릭해서 내용 보기할때 수행하는 곳
	@RequestMapping("test_viewContentAjax")
	public ModelAndView test_viewContentAjax(String bd_idx, String cPage, String c_idx) {
		ModelAndView mv = new ModelAndView();

		BoardVO bvo = b_Service.getBoard(bd_idx);

		mv.addObject("bvo", bvo);
		mv.addObject("cPage", cPage);
		mv.addObject("c_idx", c_idx);
		mv.setViewName("/jsp/admin/schoolRecord/test_viewContent_ajax");
		return mv;
	}

	// [글쓰기] 버튼을 클릭했을 때
	// 게시글 등록 테이블을 ajax로 가져오는 곳
	@RequestMapping("test_addBoardAjax")
	public ModelAndView test_addBoardAjax(String c_idx) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("c_idx", c_idx);
		mv.setViewName("/jsp/admin/schoolRecord/test_addBoard_ajax");
		return mv;
	}

	// 게시글 등록 테이블에서 [등록] 버튼을 클릭했을 때 수행하는 곳
	// [수정필요] 등록 후 과정목록 게시판이 아니라 과정별 게시판으로 가게 해야됨
    @RequestMapping("test_addBoard")
    public String test_addBoard(BoardVO bvo, String cPage) {
		b_Service.addBoard(bvo);
		return "redirect:test_viewBoardList?c_idx="+bvo.getC_idx();
    }

	// 게시글 목록에서 [숨김] 체크박스를 클릭했을 때 수행하는 곳
	@RequestMapping("test_checkNotice_board")
	public ModelAndView test_checkNotice_board(String cPage, String c_idx) {
		ModelAndView mv = new ModelAndView();
		BoardVO[] ar = null;
		Paging page = new Paging();
		boolean notice_flag = true;
		page.setTotalRecord(b_Service.cntNonNotice(c_idx));

		if(cPage == null || cPage.equals("undefined")) {
			page.setNowPage(1);
		}else {
			page.setNowPage(Integer.parseInt(cPage));
		}
		ar = b_Service.checkNotice(c_idx, String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));

		mv.addObject("ar", ar);
		mv.addObject("c_idx", c_idx);
		mv.addObject("page", page);
		mv.addObject("notice_flag", notice_flag);
		mv.setViewName("/jsp/admin/schoolRecord/test_boardList_ajax");

		return mv;
	}
	
	@RequestMapping("test_searchBoard")
	public ModelAndView test_searchBoard(String cPage, String c_idx, String bd_subject) {
		ModelAndView mv = new ModelAndView();
		BoardVO[] ar = null;
		Paging page = new Paging();
		boolean search_flag = true;

		int cnt = b_Service.reGetTotalRecord(c_idx, bd_subject);

		if(cnt > 0) {
			page.setTotalRecord(cnt);
			if(cPage == null || cPage.equals("undefined")) {
				page.setNowPage(1);
			}else {
				page.setNowPage(Integer.parseInt(cPage));
			}
			ar = b_Service.searchBoard(bd_subject, String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
		}

		mv.addObject("cPage", cPage);
		mv.addObject("c_idx", c_idx);
		mv.addObject("page", page);
		mv.addObject("ar", ar);
		mv.addObject("search_flag", search_flag);
		if(bd_subject.trim().length() > 0) {
			mv.setViewName("/jsp/admin/schoolRecord/test_boardList_ajax");
		}else {
			mv.setViewName("redirect:test_viewBoardList?c_idx="+c_idx);
		}
		
		return mv;
	}

	@RequestMapping("test_replyBoardAjax")
	public ModelAndView test_replyBoardAjax(String bd_idx, String cPage, String c_idx){
		ModelAndView mv = new ModelAndView();

		BoardVO bvo = b_Service.getBoard(bd_idx);
		mv.addObject("bvo", bvo);
		mv.addObject("cPage", cPage);

		mv.setViewName("/jsp/admin/schoolRecord/test_replyBoard_ajax");
		return mv;
	}

	@RequestMapping("test_replyBoard")
	public String test_boardAddReply(BoardVO bvo, String cPage) {
		b_Service.addReply(bvo);
		return "redirect:test_viewBoardList?c_idx="+bvo.getC_idx();
	}

	@RequestMapping("searchBoth")
	public ModelAndView searchBoth(String cPage, String tag, String value, String year) {
		ModelAndView mv = new ModelAndView();
		Paging page = new Paging();
		CourseVO[] ar = null;
		boolean searchBoth_flag = true;

		page.setTotalRecord(b_Service.search_both_count(tag, value, year));

		if(cPage == null || cPage.equalsIgnoreCase("undefined")){
			page.setNowPage(1);
		}else {
			page.setNowPage(Integer.parseInt(cPage));
		}

		ar = b_Service.searchBoth(year, tag, value, String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));

		mv.addObject("ar", ar);
		mv.addObject("page", page);
		mv.addObject("searchBoth_flag", searchBoth_flag);
		mv.setViewName("/jsp/admin/schoolRecord/searchBoth_ajax");

		return mv;
	}
}
