package com.ict.project.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.LoginService;
import com.ict.project.vo.StaffVO;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;



@org.springframework.stereotype.Controller
public class LoginController {
    @Autowired
    HttpServletRequest request;
    @Autowired
    HttpSession session;
    @Autowired
    ServletContext application;
	@Autowired
	LoginService l_Service;

    @RequestMapping("index")
    public String requestMethodName() {
        return "/jsp/index";
    }
    @RequestMapping("login")
    public String requestMethodName(String select){
        String viewPath = null;
		
		String enc_type = request.getContentType();
		if(enc_type == null || enc_type.isEmpty()) {	
			if(select.equalsIgnoreCase("admin")) {
				viewPath = "/jsp/login/login_admin";
			}else if(select.equalsIgnoreCase("train")) {
				viewPath = "/jsp/login/login_train";
			}else if(select.equalsIgnoreCase("teacher")) {
				viewPath = "/jsp/login/login_teacher";
			}
		}
		return viewPath;
    }
    @RequestMapping("login_ok")
    public ModelAndView login_ok(String select,String ID,String PW) {
        ModelAndView mv = new ModelAndView();
        String viewPath = null;
	
		if(select.equalsIgnoreCase("admin")) {
			StaffVO vo = l_Service.login_admin(ID, PW);
            if(vo == null){
                viewPath = "/jsp/login/login_admin";
                mv.addObject("login", "fail");
            }
            else
			    viewPath = "/jsp/admin/counselReceipt/main";
			session.setAttribute("vo", vo);	
		}else if(select.equalsIgnoreCase("train")) {			
			viewPath = "/jsp/train/main";
		}else if(select.equalsIgnoreCase("teacher")) {
            StaffVO vo = l_Service.login_teacher(ID,PW);
            if(vo == null){
                viewPath = "/jsp/login/login_teacher";
                mv.addObject("login", "fail");
            }
            else 
			    viewPath = "/jsp/teacher/counselReceipt/main";
            session.setAttribute("vo", vo);
		}
		mv.setViewName(viewPath);
		return mv;
    }
    @RequestMapping("logout")
    public String logout() {
        session.removeAttribute("vo");
		
		return "redirect:index";
    }

}
