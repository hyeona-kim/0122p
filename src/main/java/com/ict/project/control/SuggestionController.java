package com.ict.project.control;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.SuggestionService;
import com.ict.project.util.FileRenameUtil;
import com.ict.project.util.Paging;
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

	private List<SuggestionVO> sg_r_list;

    @RequestMapping("suggestionList")
    public String suggestionList() {
		return "/jsp/admin/schoolRecord/suggestionList";
    }

	@RequestMapping("sugAddForm")
	public String sugAddForm() {
		return "/jsp/admin/schoolRecord/add_ajax";
	}

	@RequestMapping("reply")
	public ModelAndView reply(String sg_idx) {
		ModelAndView mv = new ModelAndView();
		SuggestionVO vo = s_Service.view(sg_idx);
		mv.addObject("vo", vo);
		mv.setViewName("/jsp/admin/schoolRecord/reply_ajax");
		return mv;
	}
	
	@RequestMapping("viewSugg")
	public ModelAndView viewSugg(String sg_idx) {
		ModelAndView mv = new ModelAndView();
		SuggestionVO vo = s_Service.view(sg_idx);

		Object obj = session.getAttribute("sg_r_list");
		if(obj == null) {
			sg_r_list = new ArrayList<SuggestionVO>();
			session.setAttribute("sg_r_list", sg_r_list);
		}else {
			sg_r_list = (ArrayList<SuggestionVO>) obj;
		}
		boolean read = CheckRead(vo);
		if(!read) {
			sg_r_list.add(vo);
			s_Service.addHit(vo.getSg_idx());
		}

		mv.addObject("vo", vo);
		mv.setViewName("/jsp/admin/schoolRecord/view_ajax");
		return mv;
	}

	public boolean CheckRead(SuggestionVO vo) {
		boolean flag = false;

		for (int i=0; i<sg_r_list.size(); i++){
			SuggestionVO svo = sg_r_list.get(i);
			if(vo.getSg_idx().equals(svo.getSg_idx())){
				flag = true;
				break;
			}
		}
		return flag;
	}
    
    @RequestMapping("addSuggestion")
    public ModelAndView addSuggestion(SuggestionVO svo) {
		ModelAndView mv = new ModelAndView();
		String encType = request.getContentType();
		if(encType.startsWith("application")) {
			s_Service.addSugg(svo);
		}else if(encType.startsWith("multipart")) {
			MultipartFile mf = svo.getFile();
			String fname = null;
			
			if(mf != null && mf.getSize() > 0) {
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
   
    @RequestMapping("addReply")
    public ModelAndView addReply(SuggestionVO svo) {
        ModelAndView mv = new ModelAndView();
		s_Service.addReply(svo);
		mv.setViewName("redirect:suggestionList");
		return mv;
    }
    @RequestMapping("searchSugg")
    public ModelAndView requestMethodName(String cPage,String tag,String value) {
        ModelAndView mv = new ModelAndView();
        SuggestionVO[] ar = null;
		Paging page = null;
		boolean search_flag = true;
		
		// Paging을 다시 만들기 위해 totalRecord를 다시 구한다
		int cnt = s_Service.reGetTotalRecord(value);
		
		if(cnt > 0) {
			page = new Paging();
			page.setTotalRecord(cnt);
			if(cPage == null || cPage.equals("undefined")) {
				page.setNowPage(1);	
			}else {
				page.setNowPage(Integer.parseInt(cPage));								
			}
			ar = s_Service.search(value, String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
		}
		
		mv.addObject("search_flag", search_flag);
		mv.addObject("ar", ar);
		mv.addObject("page", page);
		if(value.trim().length() > 0){
			mv.setViewName("/jsp/admin/schoolRecord/suggList_ajax");
		}else {
			mv.setViewName("redirect:suggMain");
		}
		
        return mv;
    }
    @RequestMapping("suggMain")
    public ModelAndView requestMethodName(String cPage) {
        ModelAndView mv = new ModelAndView();
        SuggestionVO[] ar = null;
		Paging page = null;
		
		Object obj_ar = request.getAttribute("ar");
		Object obj_p = request.getAttribute("page");
		if(obj_p == null) {
			page = new Paging();
			page.setTotalRecord(s_Service.getTotalRecord());
		}else {
			page = (Paging)obj_p;
		}
		
		if(cPage == null || cPage.equals("undefined"))
			page.setNowPage(1);
		else {
			int nowPage = Integer.parseInt(cPage);
			page.setNowPage(nowPage);
		}
		
		if(obj_ar == null) {
			ar = s_Service.getSuggList(String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
		}else {
			ar = (SuggestionVO[])obj_ar;
		}		
		
		mv.addObject("ar", ar);
		mv.addObject("page", page);
		mv.setViewName("/jsp/admin/schoolRecord/suggList_ajax");
		return mv;
    }
    
	@RequestMapping("checkNotice_sugg")
	public ModelAndView checkNotice(String cPage) {
		ModelAndView mv = new ModelAndView();
		SuggestionVO[] ar = null;
		Paging page = new Paging();
		boolean notice_flag = true;
		page.setTotalRecord(s_Service.cntNonNotice());

		if(cPage == null || cPage.equals("undefined")){
			page.setNowPage(1);
		}else {
			page.setNowPage(Integer.parseInt(cPage));
		}
		ar = s_Service.checkNotice(String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
		mv.addObject("ar", ar);
		mv.addObject("page", page);
		mv.addObject("notice_flag", notice_flag);
		mv.setViewName("/jsp/admin/schoolRecord/suggList_ajax");

		return mv;
	}

	@RequestMapping("SuggDownload")
	public ResponseEntity<Resource> fileDownload(String fname) {
		String realPath = application.getRealPath("/upload_suggFile/"+fname);

		File f = new File(realPath);

		if(f.exists()) {
			byte[] buf = new byte[4096];
			int size = -1;

			BufferedInputStream bis = null;
			FileInputStream fis = null;

			BufferedOutputStream bos = null;
			ServletOutputStream sos = null;

			try {
				response.setContentType("application/x-msdownload");
				response.setHeader("Content-Disposition", "attachment;filename="+new String(fname.getBytes(), "8859_1"));

				fis = new FileInputStream(f);
				bis = new BufferedInputStream(fis);

				sos = response.getOutputStream();
				bos = new BufferedOutputStream(sos);

				while((size=bis.read(buf)) != -1) {
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
				} catch (Exception e) { }
			}
		}
		return null;
	}
}
