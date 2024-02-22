package com.ict.project.control;

import java.io.File;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.StaffService;
import com.ict.project.util.FileRenameUtil;
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
            if (cPage == null) {
                mv.addObject("admin_menu", "allMenu");
                mv.setViewName("/jsp/admin/main_admin_ajax");
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
        }
        return mv;
    }

    @RequestMapping("menu")
    public String menu(String select) {
        System.out.println(select);
        return "/jsp/admin/" + select + "/main2";
    }

    @RequestMapping("addStaff")
    public String addStaff(StaffVO svo, String authority, String log_idx, MultipartFile ifile) {
        String code = null;
        svo.setSf_tcr("0");
        svo.setSf_mgr("0");
        svo.setSf_tmgr("0");
        String realPath = application.getRealPath("upload_sign");
        
        if(ifile != null && ifile.getSize() > 0){
            System.out.println("ifile 호출");
            String f_name = FileRenameUtil.checkSameFileName(ifile.getOriginalFilename(), realPath); 
            try {//파일업로드 
                ifile.transferTo(new File(realPath,f_name));
    
            } catch (Exception e) {
                    e.printStackTrace();
            }
            svo.setSf_fname(f_name);
        } else {
            System.out.println("서명쪽 호출");
            if(svo.getSf_fname() == null || svo.getSf_fname().trim().length() < 7){
                System.out.println("서명값 없음");
                svo.setSf_fname(null);
            }

        }
        // 사용권한이 교강사인 경우 교수코드를 생성
        if (authority.equals("0")) {
            svo.setSf_tcr("1");
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
        } else if (authority.equals("1")) {
            svo.setSf_tcr("0");
            svo.setSf_mgr("1");
        } else if (authority.equals("2")) {
            svo.setSf_tcr("1");
            svo.setSf_mgr("1");
        } else {
            // 최고관리자는 교강사 및 모든 관리자 페이지를 열람할 수 있어야 하므로 모두 1값으로 고정
            svo.setSf_tmgr("1");
            svo.setSf_mgr("1");
            svo.setSf_tcr("1");
            StaffVO svo2 = s_Service.getStaff(log_idx); // 권한을 양도하였으므로 기존 로그인한 인원의 권한을 관리자로 변경해야함
            svo2.setSf_tmgr("0");
            s_Service.editStaff(svo2);
        }
        svo.setSf_code("tc" + code);

        // 전화번호 합쳐서 보내기.
        String[] ar = request.getParameterValues("sf_phone");
        String phone = ar[0] + "-" + ar[1] + "-" + ar[2];
        svo.setSf_phone(phone);
        s_Service.addStaff(svo);

        if (authority.equals("3")) {
            session.removeAttribute("vo");
            return "redirect:index";
        }
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
    public ModelAndView staffEditForm(String sf_idx, String place) {
        ModelAndView mv = new ModelAndView();
        StaffVO vo = s_Service.getStaff(sf_idx);
        String phone1 = vo.getSf_phone().substring(0, 3); // 010
        String phone2 = vo.getSf_phone().substring(4, 8); // 가운데 4자리
        String phone3 = vo.getSf_phone().substring(9, 13); // 뒤 4자리

        mv.addObject("phone1", phone1);
        mv.addObject("phone2", phone2);
        mv.addObject("phone3", phone3);
        mv.addObject("vo", vo);
        mv.addObject("place", place);
        mv.setViewName("/jsp/admin/etcList/edit_ajax");

        return mv;
    }

    @RequestMapping("editStaff")
    public String editStaff(StaffVO vo, String authority, String log_idx, String place, MultipartFile ifile) {
        String code = null;
        vo.setSf_tcr("0");
        vo.setSf_mgr("0");
        vo.setSf_tmgr("0");
        String realPath = application.getRealPath("upload_sign");
        
        if(ifile != null && ifile.getSize() > 0){
            System.out.println("ifile");
            String f_name = FileRenameUtil.checkSameFileName(ifile.getOriginalFilename(), realPath); 
            try {//파일업로드 
                ifile.transferTo(new File(realPath,f_name));
    
            } catch (Exception e) {
                    e.printStackTrace();
            }
            vo.setSf_fname(f_name);

        } else {

            if(vo.getSf_fname() == null || vo.getSf_fname().trim().length() < 7)
                vo.setSf_fname(null);

        }
        if (authority.equals("0")) {
            vo.setSf_tcr("1");
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
        } else if (authority.equals("1")) {
           vo.setSf_mgr("1");
        } else if (authority.equals("2")){
            vo.setSf_tcr("1");
            vo.setSf_mgr("1");
        } else { // 최고 관리자일 경우
            vo.setSf_tmgr("1");
            vo.setSf_mgr("1");
            vo.setSf_tcr("1");
            StaffVO svo2 = s_Service.getStaff(log_idx); // 권한을 양도하였으므로 기존 로그인한 인원의 권한을 관리자로 변경해야함
            svo2.setSf_tmgr("0");
            s_Service.editStaff(svo2);
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

        if (authority.equals("3") && vo.getSf_idx() != log_idx) { // 자신을 수정한 것이 아닐 경우에는 로그아웃 시켜야 함
            session.removeAttribute("vo");
            return "redirect:index";
        } else if (place != null && place.trim().length() > 0){
            return "redirect:clickLogo";
        } else {
            return "redirect:staffList";
        }
    }

    @RequestMapping("unblockStaff")
    public String unblockStaff(String sf_idx, String main) {
        s_Service.unblockStaff(sf_idx);
        if (main == null)
            return "redirect:staffList";
        else
            return null;
    }

    @ResponseBody
    @RequestMapping("addSign")
    public Map<String, String> addSign(MultipartFile s_file){
        String realPath = application.getRealPath("upload_sign");
        Map<String, String> map = new HashMap<>();
        
        if(s_file != null && s_file.getSize() > 0){
            System.out.println("파일이 있는데?");
            String f_name = FileRenameUtil.checkSameFileName("sign.png", realPath); 
            try {//파일업로드 
                s_file.transferTo(new File(realPath,f_name));
    
            } catch (Exception e) {
                 e.printStackTrace();
            }
            map.put("f_name", f_name);
        }
        return map;
    }

}
