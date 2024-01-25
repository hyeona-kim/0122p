package com.ict.project.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.CounselReceiptService;
import com.ict.project.util.Paging;
import com.ict.project.vo.CounselReceiptVO;
import com.ict.project.vo.CourseVO;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class CounselReciptController {
     @Autowired
    HttpServletRequest request;
	@Autowired
	HttpServletResponse response;
    @Autowired
    HttpSession session;
    @Autowired
    ServletContext application;
    @Autowired
    CounselReceiptService cr_Service;



    @RequestMapping("counselReceipt")
    public String counselReceipt(String listSelect) {
        String viewPath = null;
        if(listSelect.equals("1"))
            viewPath= "/jsp/admin/counselReceipt/counselReceipt";
        else if(listSelect.equals("2"))
            viewPath="/jsp/admin/counselReceipt/";
        else if(listSelect.equals("3"))
            viewPath= "/jsp/admin/counselReceipt/";
        
        return viewPath;
    }

     @RequestMapping("counselReceiptMain")
    public ModelAndView courseReceipt(String listSelect) {
        ModelAndView mv = new ModelAndView();
		
		CounselReceiptVO[] ar = null;
		ar = cr_Service.getCounselReceiptList();
		mv.addObject("ar", ar);
		if(listSelect.equals("1"))
			mv.setViewName("/jsp/admin/counselReceipt/counselReceipt_ajax");
		else if(listSelect.equals("2"))
            mv.setViewName("/jsp/admin/courseReg/");
		else if(listSelect.equals("3"))
            mv.setViewName("/jsp/admin/courseReg/"); 
        return mv;
    }
}
