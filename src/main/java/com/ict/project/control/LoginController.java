package com.ict.project.control;

import java.io.File;
import java.util.HashMap;
import java.util.HashSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonCreator.Mode;
import com.ict.project.service.LoginService;
import com.ict.project.util.FileRenameUtil;
import com.ict.project.util.LmsBean;
import com.ict.project.util.Paging;
import com.ict.project.vo.CourseTypeVO;
import com.ict.project.vo.CourseVO;
import com.ict.project.vo.RoomVO;
import com.ict.project.vo.StaffVO;
import com.ict.project.vo.TrainuploadVO;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestMethod;


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
    public String login_ok(String select,String ID,String PW) {
       String viewPath = null;
	
		if(select.equalsIgnoreCase("admin")) {
			StaffVO vo = l_Service.login_admin(ID, PW);
			viewPath = "/jsp/admin/counselReceipt/main";
			session.setAttribute("vo", vo);
			
		}else if(select.equalsIgnoreCase("train")) {			
			viewPath = "/jsp/train/main";
		}else if(select.equalsIgnoreCase("teacher")) {
            StaffVO vo = l_Service.login_teacher(ID,PW);
			viewPath = "/jsp/teacher/counselReceipt/main";
            session.setAttribute("vo", vo);
		}
		
		return viewPath;
    }
    @RequestMapping("logout")
    public String logout() {
        session.removeAttribute("vo");
		
		return "redirect:index";
    }

}
