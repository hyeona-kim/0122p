package com.ict.project.control;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.BoardService;
import com.ict.project.util.Paging;
import com.ict.project.vo.BoardVO;




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
    @RequestMapping("boardList")
    public ModelAndView boardList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/jsp/admin/schoolRecord/boardList");
        return mv;
    }
    @RequestMapping("addBoard")
    public String addBoard(BoardVO bvo) {
		
		// 전달받은 파라미터 값들을 HashMap에 저장한다.

		b_Service.addBoard(bvo);
		return "redirect:boardList";
    }
    @RequestMapping("boardAddReply")
    public String boardAddReply(BoardVO bvo) {		
		b_Service.addReply(bvo);
		return "redirect:boardList";
    }
	
    @RequestMapping("boardListAjax")
    public String boardListAjax(String cPage ) {
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
    
    @RequestMapping("searchBoard")
    public String searchBoard(String cPage,String tag,String value,String subject) {
        BoardVO[] ar = null;
        Paging page = null;
        boolean bl = true;
        
        
        // 검색을 위한 HashMap을 만든다
        int cnt = b_Service.reGetTotalRecord(subject);
        
        if(cnt > 0) {
            page = new Paging();
            page.setTotalRecord(cnt);
            if(cPage.equals("undefined")) {
                page.setNowPage(1);				
            }else {
                page.setNowPage(Integer.parseInt(cPage));								
            }
            ar = b_Service.searchBoard(subject, String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
        }
        
        request.setAttribute("bl", bl);
        request.setAttribute("ar", ar);
        request.setAttribute("page", page);

        return "redirect:boardMain";
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
    
    
}
