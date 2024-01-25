package com.ict.project.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.CounselAddService;
import com.ict.project.service.CounselService;
import com.ict.project.service.CourseService;

import com.ict.project.service.StaffService;

import com.ict.project.service.TraineeService;

import com.ict.project.util.Paging;
import com.ict.project.vo.CounselAddVO;
import com.ict.project.vo.CounselVO;
import com.ict.project.vo.CourseVO;

import com.ict.project.vo.StaffVO;

import com.ict.project.vo.TraineeVO;


import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class CounselController {
    @Autowired
    HttpServletRequest request;
    @Autowired
    HttpSession session;
    @Autowired
    ServletContext application;
    @Autowired
    CounselService cs_Service;
    @Autowired
    CounselAddService ca_Service;
    @Autowired
    CourseService c_Service;
    @Autowired
    StaffService s_service;
    @Autowired
    TraineeService t_Service;
    




    @RequestMapping("counsel")
    public String counsel(String listSelect) {
        String viewPath = null;
        if(listSelect.equals("1"))
            viewPath= "/jsp/admin/counselManage/counselTypeList";
        else if(listSelect.equals("2"))
            viewPath="/jsp/admin/counselManage/counselDateList";
        else if(listSelect.equals("3"))
            viewPath= "/jsp/admin/counselManage/counselTraineeSearch";
        
        return viewPath;
    }

    @RequestMapping("addCounselFile")
    public ModelAndView addCounsel() {
        ModelAndView mv = new ModelAndView();
              
        mv.setViewName("/jsp/admin/counselManage/addCounselFile_ajax");
        return mv;
    }
     @RequestMapping("delCounsel")
    public String delCounsel(String so_idx,String cPage) {
      
      cs_Service.deleteCounsel(so_idx);
      
      return "redirect:counsel?listSelect=2";
    }
    
    @RequestMapping("editCounsel")
    public String editCounsel(CounselVO vo,String edit) {
       if(edit == null) {
        CounselVO cvo = cs_Service.getCounsel(vo.getSo_idx());
        request.setAttribute("edit_cvo", cvo);
        return "/jsp/admin/counselManage/editCounsel_ajax";
        }else{
            cs_Service.editCounsel(vo);
            return "redirect:counsel?listSelect=1&cPage=1";
        }
    }
    @RequestMapping("counselsave")
    public ModelAndView counselsave(CounselAddVO vo,MultipartFile ss_img) {
        ModelAndView mv = new ModelAndView();
        System.out.println(ss_img.getOriginalFilename());
      int cnt = ca_Service.add(vo);
      System.out.println(cnt);
      mv.setViewName("redirect:counsel?listSelect=1");

        
        return mv;
    }

    @RequestMapping("counselAddMain")
    public ModelAndView counselAddMain(String c_idx) {
        ModelAndView mv = new ModelAndView();

        CourseVO cvo = c_Service.getCourse2(c_idx);
        

        // so_idx를 기반으로 CounselVO 객체 가져오기
        CounselAddVO[] ar = ca_Service.list(c_idx);
        mv.addObject("c_idx", c_idx);
        mv.addObject("ar", ar);
        mv.addObject("cvo", cvo);
        mv.setViewName("jsp/admin/counselManage/counselAddMain_ajax");
       
        return mv;
    }


    @RequestMapping("counselAdd")
    public ModelAndView counselAdd(String c_idx) {
        ModelAndView mv = new ModelAndView();
        
        // so_idx를 기반으로 CounselVO 객체 가져오기
        CounselAddVO[] vo = ca_Service.list(c_idx);
        CourseVO cvo = c_Service.getCourse(c_idx);
        mv.addObject("cvo", cvo);
        mv.addObject("vo", vo);
        mv.setViewName("/jsp/admin/counselManage/counselAddMain");
        
        return mv;
    }
    
    @RequestMapping("counselA")
    public ModelAndView counselA(String c_idx){
        ModelAndView mv = new ModelAndView();
        CounselAddVO[] vo = ca_Service.list(c_idx);
        CourseVO cvo = c_Service.getCourse2(c_idx);
        
        mv.addObject("vo", vo);
        mv.addObject("cvo", cvo);
        mv.setViewName("/jsp/admin/counselManage/counselAdd");
        
        return mv;  
    }
    
    
    

    
    @RequestMapping("viewCounsel")
    public String viewCourse(String so_idx) {
        String viewPath = null;

        // so_idx를 기반으로 CounselVO 객체 가져오기
        CounselVO vo = cs_Service.getCounsel(so_idx);


      
        request.setAttribute("select_vo", vo);

        viewPath ="redirect:counsel&listSelect=1";

        return viewPath;
    }

    @RequestMapping("traineeList")
    public ModelAndView traineeList(String cPage){
        ModelAndView mv = new ModelAndView();
       Paging page = new Paging();
		
		page.setTotalRecord(t_Service.getCount());
		
		if(cPage == null || cPage.length()==0) {
			page.setNowPage(1);
		}else {
			int nowPage = Integer.parseInt(cPage);
			page.setNowPage(nowPage);
			
		}
		
		TraineeVO[] tv = t_Service.getTraineeList(String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
		
		mv.addObject("ar", tv);
		mv.addObject("page", page);

        mv.setViewName( "jsp/admin/counselManage/counselTraineeSearch_ajax");
		return mv;
    }

    @RequestMapping("searchCounsel")
    public ModelAndView searchCourse(String num,String year,String select,String value,String listSelect,String cPage){
      if(value.trim().length()==0){
         value= null;
      }
      if(year.equals("년도선택"))
         year = null;
      if(num.equals("표시개수"))
         num = null;
      ModelAndView mv = new ModelAndView();
      Paging page = null;
      if(num!=null && num.length()>0 ) {
            page = new Paging(Integer.parseInt(num),5);
        }
      else {
            page = new Paging();
        }
      

      if(value == null || value.length()<1) {
         value = null;
      }
      if(select == null || select.length()<1){
         select = null;
      }
      
      if(year == null || year.length()==0) {
         year = null;
      }
      //비동기 통신할 jsp로 보내기
      if(listSelect.equals("1")) {

            mv.setViewName("/jsp/admin/counselManage/counselTypeList_ajax");
            page.setTotalRecord(c_Service.getSearchCount(select, value, year));
            page.setNowPage(Integer.parseInt(cPage));
            CourseVO[] ar = c_Service.searchCourse(select,value,year,String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
            mv.addObject("ar", ar);
            mv.addObject("page", page);
        } else if(listSelect.equals("2")){
            mv.setViewName("/jsp/admin/counselManage/counselDateList_ajax");
            page.setTotalRecord(cs_Service.getSearchCount(select, value, year));
            page.setNowPage(Integer.parseInt(cPage));
            CounselVO[] ar = cs_Service.searchCounsel(select,value,year,String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
            
            mv.addObject("ar", ar);
            mv.addObject("page", page);
        }
      
      
      else if(listSelect.equals("3")) {
            page.setTotalRecord(t_Service.getCourseSearchCount(select, value, year));
            page.setNowPage(Integer.parseInt(cPage));
            TraineeVO[] ar = t_Service.getCourseTraineeSearchList(select,value,year,String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));

            mv.addObject("ar", ar);
            mv.addObject("page", page);
            mv.setViewName("/jsp/admin/counselManage/counselTraineeSearch_ajax");
        }
        return mv;
   }

    @RequestMapping("counselMain")
    public ModelAndView counselMain(String listSelect, String cPage, String c_idx) {
        ModelAndView mv = new ModelAndView();
      if(cPage == null)
            cPage = "1";
      // cPage와 listSelect를 받아서 이를 통해 paging객체 만들기.
        
        
      if(listSelect.equals("1")) {
            Paging page = new Paging();
            mv.setViewName("/jsp/admin/counselManage/counselTypeList_ajax");
            page.setTotalRecord(c_Service.getCount());
            page.setNowPage(Integer.parseInt(cPage));
            CourseVO[] ar = null;
            ar = c_Service.getCourseList(String.valueOf(page.getBegin()),String.valueOf(page.getEnd()));
            
            mv.addObject("ar", ar);
            mv.addObject("page", page);
            
        }
      else if(listSelect.equals("2")){
            Paging page = new Paging();
            mv.setViewName("/jsp/admin/counselManage/counselDateList_ajax");
            page.setTotalRecord(cs_Service.getCount());
            page.setNowPage(Integer.parseInt(cPage));
            CounselVO[] ar = cs_Service.getCounselList(String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
            System.out.println(cs_Service.getCount());
            mv.addObject("ar", ar);
            mv.addObject("page", page);
        }
      else if(listSelect.equals("3")){
          mv.setViewName("/jsp/admin/counselManage/counselTraineeSearch_ajax");
          TraineeVO[] ar = null;
          if(c_idx != null){
                Paging page = new Paging();

                page.setTotalRecord(t_Service.getCourseTraineeCount(c_idx));
                System.out.println(c_idx);
                page.setNowPage(Integer.parseInt(cPage));
                ar = t_Service.getCourseTraineeList(c_idx, String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
                mv.addObject("ar", ar);
                mv.addObject("page", page);
            } else {
                ar = null;
                mv.addObject("ar", ar);
            }
            
        }
      else
            mv.setViewName("/jsp/admin/counselManage/counselTypeList_ajax");   
      
        return mv;
    }

    @RequestMapping("ss_dialog")
    public ModelAndView ss_dialog(String select,String c_idx) {
        ModelAndView mv = new ModelAndView();
      
   
      CourseVO cvo = c_Service.getCourse(c_idx);
      mv.addObject("cvo", cvo);
      
      if(select.equals("addCounselFile"))
         mv.setViewName("/jsp/admin/counselManage/addCounselFile_ajax");
      else if(select.equals("counselAddMain"))
            mv.setViewName("/jsp/admin/counselManage/counselAddMain_ajax");
      
        return mv;
    }
  


}