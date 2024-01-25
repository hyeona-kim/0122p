package com.ict.project.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.SuggestionService;
import com.ict.project.util.Paging;
import com.ict.project.vo.SuggestionVO;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


@Controller
public class SuggestionController {
     @Autowired
    HttpServletRequest request;
    @Autowired
    HttpSession session;
    @Autowired
    ServletContext application;
	@Autowired
	SuggestionService s_Service;

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
		mv.addObject("vo", vo);
		mv.setViewName("/jsp/admin/schoolRecord/view_ajax");
		return mv;
	}
    
    @RequestMapping("addSuggestion")
    public String addSuggestion(SuggestionVO svo) {

		s_Service.addSugg(svo);
		return "redirect:suggestionList";
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
}
