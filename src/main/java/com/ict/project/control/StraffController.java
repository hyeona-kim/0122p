package com.ict.project.control;

import java.util.HashSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.StaffService;
import com.ict.project.util.Paging;
import com.ict.project.vo.StaffVO;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class StraffController {
    @Autowired
    HttpServletRequest request;
    @Autowired
    HttpSession session;
    @Autowired
    ServletContext application;
    @Autowired
    StaffService s_Service;

    @RequestMapping("staffList")
    public ModelAndView staffList(String main, String cPage) {
        ModelAndView mv = new ModelAndView();
        StaffVO[] ar = s_Service.getList();
        mv.addObject("ar", ar);
        if (main == null) {
            mv.setViewName("/jsp/admin/etcList/staffList");
        } else {
            Paging page = new Paging();
            page.setTotalRecord(ar.length);
            page.setNowPage(Integer.parseInt(cPage));
            mv.addObject("page", page);
            ar = s_Service.getList2(String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
            mv.addObject("ar", ar);
            mv.addObject("admin_menu", "staff");
            mv.setViewName("/jsp/admin/main_admin_ajax");
        }
        return mv;
    }

    @RequestMapping("menu")
    public String menu(String select) {
        System.out.println(select);
        return "/jsp/admin/" + select + "/main2";
    }

    @RequestMapping("addStaff")
    public String addStaff(StaffVO svo) {
        String code = null;

        // 사용권한이 교강사인 경우(rt_idx가 1) 교수코드를 생성
        if (svo.getRt_idx().equals("1")) {
            String[] s_ar = s_Service.searchSfCode();
            HashSet<String> set = new HashSet<String>();

            // 기존에 존재하는 교수코드를 가져와서 Hashset에 저장
            for (int i = 0; i < s_ar.length; i++) {
                set.add(s_ar[i]);
            }

            // 난수로 임의의 교수코드를 생성
            int num = (int) Math.floor(Math.random() * 999999 + 100000);
            code = String.valueOf(num);

            // while문을 이용해 기존의 교수코드와 중복여부 체크
            while (set.contains("tc" + code)) {
                num = (int) Math.floor(Math.random() * 999999 + 100000);
                code = String.valueOf(num);
            }
        }
        svo.setSf_code("tc" + code);

        // 전화번호 합쳐서 보내기.
        String[] ar = request.getParameterValues("sf_phone");
        String phone = ar[0] + "-" + ar[1] + "-" + ar[2];
        svo.setSf_phone(phone);

        s_Service.addStaff(svo);
        return "redirect:staffList";
    }

    @RequestMapping("delStaff")
    public ModelAndView delStaff(String sf_idx) {
        ModelAndView mv = new ModelAndView();
        s_Service.deleteStaff(sf_idx);

        mv.setViewName("redirect:staffList");
        return mv;
    }

    @RequestMapping("staffAddForm")
    public String staffAddForm() {
        return "/jsp/admin/etcList/add_ajax";
    }

    @RequestMapping("staffEditForm")
    public ModelAndView staffEditForm(String sf_idx) {
        ModelAndView mv = new ModelAndView();
        StaffVO vo = s_Service.getStaff(sf_idx);
        String phone1 = vo.getSf_phone().substring(0, 3); // 010
        String phone2 = vo.getSf_phone().substring(4, 8); // 가운데 4자리
        String phone3 = vo.getSf_phone().substring(9, 13); // 뒤 4자리

        mv.addObject("phone1", phone1);
        mv.addObject("phone2", phone2);
        mv.addObject("phone3", phone3);
        mv.addObject("vo", vo);
        mv.setViewName("/jsp/admin/etcList/edit_ajax");

        return mv;
    }

    @RequestMapping("editStaff")
    public String editStaff(StaffVO vo) {
        String code = null;
        if (vo.getRt_idx().equals("1")) {
            String[] s_ar = s_Service.searchSfCode();
            HashSet<String> set = new HashSet<String>();

            // 기존에 존재하는 교수코드를 가져와서 Hashset에 저장
            for (int i = 0; i < s_ar.length; i++) {
                set.add(s_ar[i]);
            }

            // 난수로 임의의 교수코드를 생성
            int num = (int) Math.floor(Math.random() * 999999 + 100000);
            code = String.valueOf(num);

            // while문을 이용해 기존의 교수코드와 중복여부 체크
            while (set.contains("tc" + code)) {
                num = (int) Math.floor(Math.random() * 999999 + 100000);
                code = String.valueOf(num);
            }
        }
        vo.setSf_code("tc" + code);
        // 퇴사일을 지정하지 않았을 경우 null로 지정
        if (vo.getSf_fire_date() == null || vo.getSf_fire_date().trim().length() == 0) {
            vo.setSf_fire_date(null);
        }

        // 전화번호 합쳐서 보내기.
        String[] ar = request.getParameterValues("sf_phone");
        String phone = ar[0] + "-" + ar[1] + "-" + ar[2];
        vo.setSf_phone(phone);

        s_Service.editStaff(vo);
        return "redirect:staffList";
    }

    @RequestMapping("unblockStaff")
    public String unblockStaff(String sf_idx) {
        s_Service.unblockStaff(sf_idx);
        return "redirect:staffList";
    }

}
