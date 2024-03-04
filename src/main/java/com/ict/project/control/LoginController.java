package com.ict.project.control;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.CourseService;
import com.ict.project.service.LoginService;
import com.ict.project.service.StaffService;
import com.ict.project.vo.CourseVO;
import com.ict.project.vo.StaffVO;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
    @Autowired
    CourseService c_Service;

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
            // 관리자인경우
            StaffVO vo = l_Service.login_admin(ID, PW);
            if (vo == null) {
                // 로그인 실패
                viewPath = "/jsp/index";
                mv.addObject("login", "fail");
            } else {
                // 로그인 성공
                viewPath = "/jsp/admin/main_admin";
                session.removeAttribute("cnt");
                session.setAttribute("main_select", "1");
            }
            session.setAttribute("vo", vo);
            session.setAttribute("main_select", 1);
        } else if (select.equalsIgnoreCase("teacher")) {
            // 교강사인 경우
            StaffVO vo = l_Service.login_teacher(ID, PW);
            if (vo == null) {
                // 로그인실패
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
                // 로그인 성공
                // viewPath = "/jsp/admin/counselReceipt/main";
                viewPath = "redirect:staffMain?leftList=1";
                session.removeAttribute("cnt");
                session.setAttribute("main_select", "2");
            }
            session.setAttribute("vo", vo);
            session.setAttribute("main_select", 2);
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
    public String clickLogo(String mode) {
        Object select = session.getAttribute("main_select");
        String viewPath = "/jsp/index";
        int select2 = 0;
        if (select != null)
            select2 = (int) select;
        if(mode == null){
            if (select2 == 1) {
                viewPath = "/jsp/staff/trainingLog/main";
            } else if (select2 == 2) {
                viewPath = "/jsp/admin/main_admin";
            }
        }else{
            System.out.println(select2);
            if (select2 == 1) {
                session.removeAttribute("main_select");
                session.setAttribute("main_select", 2);
                viewPath = "/jsp/admin/main_admin";
            } else if (select2 == 2) {
                session.removeAttribute("main_select");
                session.setAttribute("main_select", 1);
                viewPath = "/jsp/staff/trainingLog/main";
            }
        }
        
        return viewPath;
    }

    @RequestMapping("checkPass")
    @ResponseBody
    public Map<String, Object> checkPass(String password, String sf_idx) {
        Map<String, Object> map = new HashMap<>();
        map.put("sf_vo", null);
        StaffVO sfvo = s_Service.getStaff(sf_idx);
        if (sfvo.getSf_pwd().equals(password))
            map.put("sf_vo", sfvo);
        return map;
    }

    @RequestMapping("changePass")
    @ResponseBody
    public Map<String, Object> changePass(String password, String sf_idx) {
        Map<String, Object> map = new HashMap<>();

        int cnt = s_Service.editPass(sf_idx, password);
        map.put("cnt", cnt);

        return map;
    }

    @RequestMapping("changeMe")
    public ModelAndView changeMe(String sf_idx) {
        ModelAndView mv = new ModelAndView();
        StaffVO sfvo = s_Service.getStaff(sf_idx);
        mv.setViewName("/jsp/staff/changeMe");
        mv.addObject("sf_vo", sfvo);
        return mv;
    }

    @RequestMapping("editMe")
    @ResponseBody
    public Map<String, Object> editMe(String sf_idx, String sf_id, String sf_email, String sf_phone) {
        Map<String, Object> map = new HashMap<>();

        int cnt = s_Service.editMe(sf_idx, sf_id, sf_email, sf_phone);
        map.put("cnt", cnt);
        return map;
    }

    @RequestMapping("staffMain")
    public ModelAndView staffMain(String leftList, String c_idx) {
        ModelAndView mv = new ModelAndView();
        /*
         * <li id='l_one'><a onclick="list(1)">훈련일지</a></li>
         * <li id='l_two'><a onclick="list(2)">평가관리</a></li>
         * <li id='l_three'><a onclick="list(3)">상담관리</a></li>
         * <li id='l_four'><a onclick="list(4)">학적부</a></li>
         * <li id='l_five'><a onclick="list(5)">일정보기</a></li>
         */
        if (leftList.equals("1")) {
            mv.setViewName("/jsp/staff/trainingLog/main");
        } else if (leftList.equals("2")) {
            mv.setViewName("/jsp/staff/evaluate/main");
        } else if (leftList.equals("4")) {
            mv.setViewName("/jsp/staff/schoolRecord/main");
        } else if (leftList.equals("5")) {
            mv.setViewName("/jsp/staff/schedule/main");
        }
        return mv;
    }

}
