package com.ict.project.control;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.AskcounselingService;
import com.ict.project.service.CourseService;
import com.ict.project.service.LoginService;
import com.ict.project.service.PaymentService;
import com.ict.project.service.StaffService;
import com.ict.project.service.TrainingDiaryService;
import com.ict.project.util.Paging;
import com.ict.project.vo.AskcounselingVO;
import com.ict.project.vo.CourseVO;
import com.ict.project.vo.PaymentDTO;
import com.ict.project.vo.StaffVO;
import com.ict.project.vo.TrainingDiaryVO;

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
    @Autowired
    TrainingDiaryService td_Service;
    int cnt = 0;
    @Autowired
    AskcounselingService as_Service;
    @Autowired
    PaymentService py_Service;

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

    @RequestMapping("main_info")
    @ResponseBody
    public Map<String, Object> main_info(String cPage) {
        Map<String, Object> map = new HashMap<>();

        Paging page = new Paging(5, 2);
        if (cPage == null || cPage.trim().length() == 0) {
            cPage = "1";
        }
        page.setTotalRecord(td_Service.main_td_count());
        page.setNowPage(Integer.valueOf(cPage));

        TrainingDiaryVO[] ar = td_Service.main_td(String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));

        map.put("page", page);
        map.put("td_ar", ar);
        return map;
    }

    @RequestMapping("a_viewTD")
    public ModelAndView a_viewTD(String td_idx) {
        ModelAndView mv = new ModelAndView();
        TrainingDiaryVO tdvo = td_Service.get_td(td_idx);
        CourseVO cvo = c_Service.getCourse2(tdvo.getC_idx());
        mv.addObject("cvo", cvo);
        mv.addObject("tdvo", tdvo);
        mv.setViewName("/jsp/admin/viewDiary");
        return mv;
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

                session.setAttribute("main_select", 1);
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
                session.setAttribute("main_select", 2);
            }
            session.setAttribute("vo", vo);
            session.setAttribute("main_select", 2);
        }
        mv.setViewName(viewPath);
        return mv;
    }

    @RequestMapping("logoutlll")
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
        if (mode == null) {
            if (select2 == 1) {
                // 관리자인 경우
                viewPath = "/jsp/admin/main_admin";
            } else if (select2 == 2) {
                // 교강사인 경우
                viewPath = "/jsp/staff/trainingLog/main";
            }
        } else {
            System.out.println(select2);
            if (select2 == 1) {
                // 관리자인경우 ( 교강사 모드로 변경)
                session.removeAttribute("main_select");
                session.setAttribute("main_select", 2);
                viewPath = "redirect:clickLogo";
            } else if (select2 == 2) {
                // 교강사인경우 (관리자 모드로 변경)
                session.removeAttribute("main_select");
                session.setAttribute("main_select", 1);
                viewPath = "redirect:clickLogo";
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
        } else if (leftList.equals("6")) {
            mv.setViewName("/jsp/staff/chat/main");
        }

        return mv;
    }

    @RequestMapping("getCountast")
    @ResponseBody

    public Map<String,Object> getCountast(String select,String list,String c_idx,String today) {
        Map<String,Object> map = new HashMap<>();
        //System.out.println(select);

        AskcounselingVO[] ar1 = null;
        AskcounselingVO[] ar2 = null;
        PaymentDTO[] ar3 = null;
        if (list == null) {
            DecimalFormat df = new DecimalFormat("00");
            Calendar currentCalendar = Calendar.getInstance();

            // 현재 날짜 구하기
            String strYear = Integer.toString(currentCalendar.get(Calendar.YEAR));
            String strMonth = df.format(currentCalendar.get(Calendar.MONTH) + 1);
            String strDay = df.format(currentCalendar.get(Calendar.DATE));
            String strDate = strYear + "-" + strMonth + "-" + strDay;

            // 일주일 전 날짜 구하기
            currentCalendar.add(Calendar.DATE, -7);
            String strYear7 = Integer.toString(currentCalendar.get(Calendar.YEAR));
            String strMonth7 = df.format(currentCalendar.get(Calendar.MONTH) + 1);
            String strDay7 = df.format(currentCalendar.get(Calendar.DATE));
            String strDate7 = strYear7 + "-" + strMonth7 + "-" + strDay7;

            // 한달 전 날짜 구하기
            currentCalendar.add(Calendar.MONTH, -1);
            String strYear31 = Integer.toString(currentCalendar.get(Calendar.YEAR));
            String strMonth31 = df.format(currentCalendar.get(Calendar.MONTH) + 1);
            String strDay31 = df.format(currentCalendar.get(Calendar.DATE));
            String strDate31 = strYear31 + "-" + strMonth31 + "-" + strDay31;

            if (select.equals("0")) {
                ar1 = as_Service.getASK(strDate, strDate, "0", null);
                ar2 = as_Service.getASK(strDate, strDate, "1", null);
                ar3 = py_Service.getTotalPay(strDate, strDate);
            } else if (select.equals("1")) {
                ar1 = as_Service.getASK(strDate7, strDate, "0", null);
                ar2 = as_Service.getASK(strDate7, strDate, "1", null);
                ar3 = py_Service.getTotalPay(strDate7, strDate);
            } else if (select.equals("2")) {
                ar1 = as_Service.getASK(strDate31, strDate, "0", null);
                ar2 = as_Service.getASK(strDate31, strDate, "1", null);
                ar3 = py_Service.getTotalPay(strDate31, strDate);
            }

            int inquiry = 0;
            int consult = 0;
            int bookpay = 0;
            int total_pay = 0;
            if (ar1 != null)
                inquiry = ar1.length;
            if (ar2 != null)
                consult = ar2.length;
            if(ar3 != null){
                bookpay = ar3.length;
                for(int i=0; i<ar3.length; i++){
                    total_pay += Integer.parseInt(ar3[i].getTbvo().getTb_price());
                }
            }
            
            map.put("inquiry", inquiry);
            map.put("consult", consult);
            map.put("bookpay", bookpay);
            map.put("total_pay", total_pay);
            return map;
        } else {
            // list 인 경우
            if (c_idx == null || c_idx.trim().length() == 0) {
                c_idx = null;
            }

            if(today == null){
                ar1 = as_Service.getASK(null, null, "0",c_idx);
                ar2 = as_Service.getASK(null, null, "1",c_idx);
            }else{
                DecimalFormat df = new DecimalFormat("00");
                Calendar currentCalendar = Calendar.getInstance();
                String strYear = Integer.toString(currentCalendar.get(Calendar.YEAR));
                String strMonth = df.format(currentCalendar.get(Calendar.MONTH) + 1);
                String strDay = df.format(currentCalendar.get(Calendar.DATE));
                String strDate = strYear + "-"+strMonth + "-"+strDay;

                ar1 =  as_Service.getASK(strDate, strDate, "0",c_idx);
                ar2 = as_Service.getASK(strDate, strDate, "1",c_idx);
            }


            map.put("inquiry", ar1);
            map.put("consult", ar2);
            return map;
        }
    }


    @RequestMapping("getconsult")
    @ResponseBody
    public Map<String,Object> getconsult(String today) {
        Map<String,Object> map = new HashMap<>();
        //System.out.println(select);
        AskcounselingVO[] ar2 = as_Service.todayconsult(today);
        map.put("consult", ar2);
        return map ;
    }

    @RequestMapping("selectASK")
    public ModelAndView selectASK(String ac_idx) {
        ModelAndView mv = new ModelAndView();
        AskcounselingVO asvo = as_Service.selectASK(ac_idx);
        String viewPath = "";

        if(asvo.getAc_type().equals("0")){
            //문의인경우

            viewPath = "/jsp/admin/inquiry_ajax";
        } else if (asvo.getAc_type().equals("1")) {
            // 상담인경우
            viewPath = "/jsp/admin/consult_ajax";
        }

        CourseVO cvo = c_Service.getCourse2(asvo.getC_idx());

        mv.setViewName(viewPath);
        mv.addObject("cvo", cvo);
        mv.addObject("asvo", asvo);

        return mv;
    }

    @RequestMapping("updateCI")
    @ResponseBody
    public Map<String, Integer> updateCI(String ac_idx, String ac_answer_date, String ac_answer) {
        Map<String, Integer> map = new HashMap<>();
        if (ac_answer_date == null || ac_answer_date.length() == 0) {
            DecimalFormat df = new DecimalFormat("00");
            Calendar currentCalendar = Calendar.getInstance();

            // 현재 날짜 구하기
            String strYear = Integer.toString(currentCalendar.get(Calendar.YEAR));
            String strMonth = df.format(currentCalendar.get(Calendar.MONTH) + 1);
            String strDay = df.format(currentCalendar.get(Calendar.DATE));
            String strDate = strYear + "-" + strMonth + "-" + strDay;
            ac_answer_date = strDate;
        }
        int cnt = as_Service.updateASK(ac_idx, ac_answer_date, ac_answer);
        map.put("cnt", cnt);
        return map;
    }

}
