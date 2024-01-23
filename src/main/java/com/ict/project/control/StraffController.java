package com.ict.project.control;

import java.util.HashSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.StaffService;
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
    public ModelAndView staffList() {
        ModelAndView mv = new ModelAndView();
        StaffVO[] ar = s_Service.getList();
		mv.addObject("ar",ar);
		mv.setViewName("/jsp/admin/etcList/staffList");
		return mv;
    }
    @RequestMapping("menu")
    public String menu(String select) {
        return "/jsp/admin/"+select+"/main";
    }
    
    @RequestMapping("addStaff")
    public String addStaff(StaffVO svo) {
        String code = "";     
        System.out.println(svo.getRt_idx());
        if(svo.getRt_idx().equals(1)) {
            System.out.println(svo.getRt_idx());
			String[] s_ar = s_Service.searchSfCode();
			
			HashSet<String> set = new HashSet<String>();
            
			for(int i=0; i<s_ar.length; i++) {
                set.add(s_ar[i]);
			}
            
			int num = 0;
			while(!set.contains(code)) {
                num = (int)Math.floor(Math.random()*999999+100000);
				code = String.valueOf(num);
			}
		}
        svo.setSf_code(code);
        //전화번호 합쳐서 보내기.
        String[] ar = request.getParameterValues("sf_phone");
        String phone = ar[0]+"-"+ar[1]+"-"+ar[2];
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

        mv.addObject("vo", vo);
        mv.setViewName("/jsp/admin/etcList/edit_ajax");

        return mv;
    }
    
    @RequestMapping("editStaff")
    public String editStaff(StaffVO vo) {
        if(vo.getSf_fire_date().equals("")){
            vo.setSf_fire_date(null);
        }
        s_Service.editStaff(vo);
        return "redirect:staffList";
    }
    
    
}
