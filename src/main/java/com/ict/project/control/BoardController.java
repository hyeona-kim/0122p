package com.ict.project.control;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.BoardService;
import com.ict.project.service.CourseService;
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

	@RequestMapping("boardMainList")
	public ModelAndView boardMainList(String cPage) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("cPage", cPage);
		mv.setViewName("/jsp/admin/schoolRecord/boardMain");
		return mv;
	}

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
    public String boardList() {
        return "/jsp/admin/schoolRecord/boardList";
    }

    @RequestMapping("addBoard")
    public String addBoard(BoardVO bvo) {
		
		// 전달받은 파라미터 값들을 HashMap에 저장한다.

		b_Service.addBoard(bvo);
		return "redirect:boardList";
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
	
    @RequestMapping("boardListAjax")
    public String boardListAjax(String cPage) {
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
		
		if(cPage == null || cPage.equalsIgnoreCase("undefined"))
			page.setNowPage(1);
		else {
			int nowPage = Integer.parseInt(cPage);
			page.setNowPage(nowPage);
		}
		
		if(obj_ar == null) {
			ar = b_Service.list(String.valueOf(page.getBegin()) ,String.valueOf(page.getEnd()));
		}else {
			ar = (BoardVO[])obj_ar;
			
		}
		
		request.setAttribute("ar", ar);
		request.setAttribute("page", page);
		
		return "/jsp/admin/schoolRecord/boardList_ajax";
    }

	@RequestMapping("boardViewAjax")
	public ModelAndView boardViewAjax(String bd_idx){
		ModelAndView mv = new ModelAndView();
		BoardVO vo = b_Service.getBoard(bd_idx);
		mv.addObject("bvo", vo);
		mv.setViewName("/jsp/admin/schoolRecord/boardView_ajax");

		return mv;
	}
    
    @RequestMapping("searchBoard")
    public ModelAndView searchBoard(String cPage,String value) {
		ModelAndView mv = new ModelAndView();
        BoardVO[] ar = null;
        Paging page = null;
        boolean search_flag = true;
        
        int cnt = b_Service.reGetTotalRecord(value);
        
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
	public ModelAndView checkNotice(String cPage) {
		ModelAndView mv = new ModelAndView();
		BoardVO[] ar = null;
		Paging page = new Paging();
		boolean notice_flag = true;
		page.setTotalRecord(b_Service.cntNonNotice());

		if(cPage == null || cPage.equals("undefined")) {
			page.setNowPage(1);
		}else {
			page.setNowPage(Integer.parseInt(cPage));
		}

		ar = b_Service.checkNotice(String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));

		mv.addObject("ar", ar);
		mv.addObject("page", page);
		mv.addObject("notice_flag", notice_flag);
		mv.setViewName("/jsp/admin/schoolRecord/boardList_ajax");

		return mv;
	}

	@RequestMapping("viewBoardList")
	public ModelAndView viewBoardList(String c_idx, String cPage) {
		ModelAndView mv = new ModelAndView();
		BoardVO[] ar = null;
		Paging page = new Paging();
		boolean viewList_flag = true;

		page.setTotalRecord(b_Service.cntBoardList(c_idx));

		if(cPage == null || cPage.equals("undefined") || cPage.equals("2")) {
			page.setNowPage(1);
		}else {
			page.setNowPage(Integer.parseInt(cPage));
		}

		ar = b_Service.viewBoardList(c_idx, String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));

		mv.addObject("viewList_flag", viewList_flag);
		mv.addObject("ar", ar);
		mv.addObject("page", page);
		mv.setViewName("/jsp/admin/schoolRecord/boardList_ajax");

		return mv;
	}
}
