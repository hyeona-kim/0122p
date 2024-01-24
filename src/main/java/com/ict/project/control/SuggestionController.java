package com.ict.project.control;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
    @RequestMapping(value="searchSugg", method = RequestMethod.POST)
    public ModelAndView requestMethodName(String cPage,String tag,String value) {
        ModelAndView mv = new ModelAndView();
        SuggestionVO[] ar = null;
		Paging page = null;
		boolean bl = true;
		
		// 검색을 위한 HashMap을 만든다
		HashMap<String, String> map = new HashMap<String, String>();
		map.put(tag, value);
		
		// Paging을 다시 만들기 위해 totalRecord를 다시 구한다
		int cnt = s_Service.reGetTotalRecord(value);
		
		if(cnt > 0) {
			page = new Paging();
			page.setTotalRecord(cnt);
			if(cPage.equals("undefined")) {
				page.setNowPage(1);				
			}else {
				page.setNowPage(Integer.parseInt(cPage));								
			}
			ar = s_Service.getSuggList(String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
		}
		
		request.setAttribute("bl", bl);
		request.setAttribute("ar", ar);
		request.setAttribute("page", page);
        mv.setViewName("suggMain");
		
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
		
		request.setAttribute("ar", ar);
		request.setAttribute("page", page);
		mv.setViewName("/jsp/admin/schoolRecord/suggList_ajax");
		return mv;
    }
    
}
