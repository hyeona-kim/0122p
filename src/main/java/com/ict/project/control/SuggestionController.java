package com.ict.project.control;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.SuggestionService;
import com.ict.project.service.TestService;
import com.ict.project.util.FileRenameUtil;
import com.ict.project.util.Paging;
import com.ict.project.vo.CommVO;
import com.ict.project.vo.QnaVO;
import com.ict.project.vo.SuggestionVO;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class SuggestionController {
	@Autowired
	HttpServletResponse response;
	@Autowired
	HttpServletRequest request;
	@Autowired
	HttpSession session;
	@Autowired
	ServletContext application;
	@Autowired
	SuggestionService s_Service;

	@Autowired
	TestService t_Service;

	private List<SuggestionVO> sg_r_list;

	// 메인페이지로 이동시 고충 및 건의사항 전체 목록을 반환하는 기능
	@RequestMapping("suggMain")
	public ModelAndView requestMethodName(String cPage, String qname) {
		ModelAndView mv = new ModelAndView();
		Paging page = null;
		page = new Paging();

		page.setTotalRecord(t_Service.count(qname));
		if (cPage == null || cPage.equals("undefined"))
			page.setNowPage(1);
		else {
			int nowPage = Integer.parseInt(cPage);
			page.setNowPage(nowPage);
		}

		System.out.println(t_Service.count(qname));

		QnaVO[] ar = t_Service.getList(qname,
				String.valueOf(page.getBegin()),
				String.valueOf(page.getEnd()));
		mv.addObject("ar", ar);
		mv.addObject("page", page);
		mv.setViewName("/jsp/admin/schoolRecord/suggList_ajax");
		return mv;
	}

	@RequestMapping("viewSugg_s")
	public ModelAndView viewSugg_s(String qna_idx) {
		ModelAndView mv = new ModelAndView();
		QnaVO vo = t_Service.getqna(qna_idx);
		mv.addObject("vo", vo);

		CommVO[] cvo = t_Service.cList(qna_idx);
		mv.addObject("cvo", cvo);

		mv.setViewName("/jsp/admin/schoolRecord/view_ajax");
		return mv;
	}

	//
	//
	//
	//
	//
	//
	//
	//
	//
	//

	// 고충 및 건의사항 메뉴 클릭시 메인페이지로 이동
	@RequestMapping("suggestionList")
	public String suggestionList() {
		return "/jsp/admin/schoolRecord/suggestionList";
	}

	// [글쓰기] 버튼을 클릭시 글쓰기 양식을 반환하는 기능
	@RequestMapping("sugAddForm")
	public String sugAddForm() {
		return "/jsp/admin/schoolRecord/add_ajax";
	}

	// 글 보기 상태에서 [답변] 버튼을 클릭시 답변 양식을 반환하는 기능
	@RequestMapping("reply")
	public ModelAndView reply(String sg_idx) {
		ModelAndView mv = new ModelAndView();
		SuggestionVO vo = s_Service.view(sg_idx);
		mv.addObject("vo", vo);
		mv.setViewName("/jsp/admin/schoolRecord/reply_ajax");
		return mv;
	}

	// 목록에서 [제목]을 클릭 시 해당 글의 내용을 보는 기능
	@RequestMapping("viewSugg")
	public ModelAndView viewSugg(String sg_idx) {
		ModelAndView mv = new ModelAndView();
		SuggestionVO vo = s_Service.view(sg_idx);

		Object obj = session.getAttribute("sg_r_list");
		if (obj == null) {
			sg_r_list = new ArrayList<SuggestionVO>();
			session.setAttribute("sg_r_list", sg_r_list);
		} else {
			sg_r_list = (ArrayList<SuggestionVO>) obj;
		}
		boolean read = CheckRead(vo);
		if (!read) {
			sg_r_list.add(vo);
			s_Service.addHit(vo.getSg_idx());
		}

		mv.addObject("vo", vo);
		mv.setViewName("/jsp/admin/schoolRecord/view_ajax");
		return mv;
	}

	// 조회수 증가 기능을 위해 읽은 글인지 확인하는 기능
	public boolean CheckRead(SuggestionVO vo) {
		boolean flag = false;

		for (int i = 0; i < sg_r_list.size(); i++) {
			SuggestionVO svo = sg_r_list.get(i);
			if (vo.getSg_idx().equals(svo.getSg_idx())) {
				flag = true;
				break;
			}
		}
		return flag;
	}

	// 글쓰기 - 고충 및 건의사항 작성에서 [등록]을 클릭 시
	// DB에 해당 내용을 저장 후 목록으로 돌아가는 기능
	@RequestMapping("addSuggestion")
	public ModelAndView addSuggestion(SuggestionVO svo) {
		ModelAndView mv = new ModelAndView();
		String encType = request.getContentType();
		if (encType.startsWith("application")) {
			s_Service.addSugg(svo);
		} else if (encType.startsWith("multipart")) {
			MultipartFile mf = svo.getFile();
			String fname = null;

			if (mf != null && mf.getSize() > 0) {
				String realPath = application.getRealPath("upload_suggFile");

				String oname = mf.getOriginalFilename();

				fname = FileRenameUtil.checkSameFileName(oname, realPath);

				try {
					mf.transferTo(new File(realPath, fname));
				} catch (Exception e) {
					e.printStackTrace();
				}
				svo.setSg_file_name(fname);
				svo.setSg_ori_name(oname);
			}
			s_Service.addSugg(svo);
		}
		mv.setViewName("redirect:suggestionList");
		return mv;
	}

	// 글보기 - [답변] - 고충 및 건의사항 답변 작성에서 [등록] 버튼을 클릭 시
	// 해당 내용을 DB에 저장 후 목록으로 돌아가는 기능
	@RequestMapping("addReply")
	public ModelAndView addReply(SuggestionVO svo) {
		ModelAndView mv = new ModelAndView();
		String encType = request.getContentType();
		if (encType.startsWith("application")) {
			s_Service.addReply(svo);
		} else if (encType.startsWith("multipart")) {
			MultipartFile mf = svo.getFile();
			String fname = null;

			if (mf != null && mf.getSize() > 0) {
				String realPath = application.getRealPath("upload_suggFile");

				String oname = mf.getOriginalFilename();

				fname = FileRenameUtil.checkSameFileName(oname, realPath);

				try {
					mf.transferTo(new File(realPath, fname));
				} catch (Exception e) {
					e.printStackTrace();
				}
				svo.setSg_file_name(fname);
				svo.setSg_ori_name(oname);
			}
			s_Service.addReply(svo);
		}
		mv.setViewName("redirect:suggestionList");
		return mv;
	}

	// 목록에서 [검색] 버튼을 클릭 시 제목으로 검색하는 기능
	@RequestMapping("searchSugg")
	public ModelAndView requestMethodName(String cPage, String tag, String value) {
		ModelAndView mv = new ModelAndView();
		SuggestionVO[] ar = null;
		Paging page = new Paging();
		boolean search_flag = true;

		// Paging을 다시 만들기 위해 totalRecord를 다시 구한다
		int cnt = s_Service.reGetTotalRecord(value);

		if (cnt > 0) {
			page.setTotalRecord(cnt);
			if (cPage == null || cPage.equals("undefined")) {
				page.setNowPage(1);
			} else {
				page.setNowPage(Integer.parseInt(cPage));
			}
			ar = s_Service.search(value, String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
		}

		mv.addObject("search_flag", search_flag);
		mv.addObject("ar", ar);
		mv.addObject("page", page);
		if (value.trim().length() > 0) {
			mv.setViewName("/jsp/admin/schoolRecord/suggList_ajax");
		} else {
			mv.setViewName("redirect:suggMain");
		}

		return mv;
	}

	// 목록에서 전체공지 [숨김] 버튼 클릭시
	// 공지사항이 아닌 글들만 반환하는 기능
	@RequestMapping("checkNotice_sugg")
	public ModelAndView checkNotice(String cPage) {
		ModelAndView mv = new ModelAndView();
		SuggestionVO[] ar = null;
		Paging page = new Paging();
		boolean notice_flag = true;
		page.setTotalRecord(s_Service.cntNonNotice());

		if (cPage == null || cPage.equals("undefined")) {
			page.setNowPage(1);
		} else {
			page.setNowPage(Integer.parseInt(cPage));
		}
		ar = s_Service.checkNotice(String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
		mv.addObject("ar", ar);
		mv.addObject("page", page);
		mv.addObject("notice_flag", notice_flag);
		mv.setViewName("/jsp/admin/schoolRecord/suggList_ajax");

		return mv;
	}

	// 목록에서 첨부파일에 [파일명]을 클릭 시 해당 파일을 다운로드 하는 기능
	@RequestMapping("SuggDownload")
	public ResponseEntity<Resource> fileDownload(String fname) {
		String realPath = application.getRealPath("/upload_suggFile/" + fname);

		File f = new File(realPath);

		if (f.exists()) {
			byte[] buf = new byte[4096];
			int size = -1;

			BufferedInputStream bis = null;
			FileInputStream fis = null;

			BufferedOutputStream bos = null;
			ServletOutputStream sos = null;

			try {
				response.setContentType("application/x-msdownload");
				response.setHeader("Content-Disposition",
						"attachment;filename=" + new String(fname.getBytes(), "8859_1"));

				fis = new FileInputStream(f);
				bis = new BufferedInputStream(fis);

				sos = response.getOutputStream();
				bos = new BufferedOutputStream(sos);

				while ((size = bis.read(buf)) != -1) {
					bos.write(buf, 0, size);
					bos.flush();
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (fis != null)
						fis.close();
					if (bis != null)
						bis.close();
					if (sos != null)
						sos.close();
					if (bos != null)
						bos.close();
				} catch (Exception e) {
				}
			}
		}
		return null;
	}

	// 글쓰기 또는 답변 작성시 에디터에 이미지를 추가할 때
	// 해당 이미지를 서버에 업로드하여 해당 이미지의 위치를 반환하는 기능
	@RequestMapping("saveSuggImg")
	@ResponseBody
	public Map<String, String> saveSuggImg(MultipartFile file) {
		Map<String, String> map = new HashMap<String, String>();

		// MultipartFile이 인자로 넘어오는 경우에는
		// 무조건 생성해서 넘어오기 때문에 null과 비교하면 안된다
		if (file.getSize() > 0) {
			String realPath = application.getRealPath("upload_suggImage");

			String oname = file.getOriginalFilename();

			String fname = FileRenameUtil.checkSameFileName(oname, realPath);

			try {
				file.transferTo(new File(realPath, fname));
			} catch (Exception e) {
				e.printStackTrace();
			}

			String Path = request.getContextPath();

			map.put("url", Path + "/upload_suggImage");
			map.put("fname", fname);
		}
		return map;
	}
}
