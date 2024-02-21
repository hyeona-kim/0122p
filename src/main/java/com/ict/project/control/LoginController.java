package com.ict.project.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.LoginService;
import com.ict.project.service.StaffService;
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
    @Autowired
    StaffService s_Service;

    int cnt = 0;

    @RequestMapping("index")
    public String requestMethodName() {
        return "/jsp/index";
    }

    @RequestMapping("login")
    public String requestMethodName(String select) {
        String viewPath = null;

        String enc_type = request.getContentType();
        if (enc_type == null || enc_type.isEmpty()) {
            if (select.equalsIgnoreCase("admin")) {
                viewPath = "/jsp/login/login_admin";
            } else if (select.equalsIgnoreCase("train")) {
                viewPath = "/jsp/login/login_train";
            } else if (select.equalsIgnoreCase("teacher")) {
                viewPath = "/jsp/login/login_teacher";
            }
        }
        return viewPath;
    }

    @RequestMapping("login_ok")
    public ModelAndView login_ok(String select, String ID, String PW) {
        ModelAndView mv = new ModelAndView();
        String viewPath = null;
        if (select.equalsIgnoreCase("admin")) {

            StaffVO vo = l_Service.login_admin(ID, PW);
            if (vo == null) {
                viewPath = "/jsp/index";
                mv.addObject("login", "fail");
            } else {
                viewPath = "/jsp/admin/main_admin";
                session.removeAttribute("cnt");
                session.setAttribute("main_select", "1");
            }
            session.setAttribute("vo", vo);
        } else if (select.equalsIgnoreCase("teacher")) {
            StaffVO vo = l_Service.login_teacher(ID, PW);
            if (vo == null) {
                if (s_Service.sf_link(ID).equals("1")) {
                    mv.addObject("block", "true");
                    mv.setViewName("/jsp/index");
                }
                if (session.getAttribute("cnt") == null)
                    session.setAttribute("cnt", 0);
                cnt = (int) session.getAttribute("cnt");
                mv.addObject("login", "fail");
                session.setAttribute("cnt", cnt + 1);
                if (cnt >= 4) {
                    // 아이디 블락 처리
                    int tt = s_Service.block(ID);
                    System.out.println(tt);
                    session.removeAttribute("cnt");
                    mv.addObject("block", "true");
                }
                viewPath = "/jsp/index";
            } else {
                // viewPath = "/jsp/admin/counselReceipt/main";
                viewPath = "/jsp/admin/main";
                session.removeAttribute("cnt");
                session.setAttribute("main_select", "2");
            }
            session.setAttribute("vo", vo);
        }
        mv.setViewName(viewPath);
        return mv;
    }

    @RequestMapping("logout")
    public String logout() {
        session.removeAttribute("vo");
        session.removeAttribute("main_select");
        return "redirect:index";
    }

    @RequestMapping("clickLogo")
    public String clickLogo() {
        String select = (String) session.getAttribute("main_select");
        String viewPath = "/jsp/index";

        if (select.equals("1")) {
            viewPath = "/jsp/admin/main_admin";
        } else if (select.equals("2")) {
            viewPath = "/jsp/admin/main";
        }
        return viewPath;
    }
}
