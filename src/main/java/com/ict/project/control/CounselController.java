package com.ict.project.control;

import java.io.File;

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
import com.ict.project.util.FileRenameUtil;
import com.ict.project.util.Paging;
import com.ict.project.vo.CounselAddVO;
import com.ict.project.vo.CounselVO;
import com.ict.project.vo.CourseVO;


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
        else if(listSelect.equals("3")){
            viewPath= "/jsp/admin/counselManage/counselTraineeSearch";
        } else if(listSelect.equals("4"))
            viewPath= "/jsp/admin/counselManage/counselTraineeInput";
        
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


    @RequestMapping("counselTraineeInput")
    public ModelAndView counselTraineeInput(String c_idx){
        ModelAndView mv = new ModelAndView();

        mv.addObject("c_idx", c_idx);
        mv.setViewName("/jsp/admin/counselManage/counselTraineeInput");

        return mv;
    }


    //상담결과보고 리스트 
    @RequestMapping("counselAddMain")
    public ModelAndView counselAddMain(String c_idx) {
        ModelAndView mv = new ModelAndView();
        
        CourseVO cvo = c_Service.getCourse2(c_idx);
        CounselAddVO[] ar = ca_Service.list(c_idx);
        mv.addObject("c_idx", c_idx);
        mv.addObject("ar", ar);
        if(ar != null)
            mv.addObject("ss_cnt", ar.length);
        mv.addObject("cvo", cvo);
        mv.setViewName("jsp/admin/counselManage/counselAddMain_ajax");
       
        return mv;
    }
    
    @RequestMapping("counselsave")
    public ModelAndView counselsave(CounselAddVO vo,MultipartFile ss_img1) {
        ModelAndView mv = new ModelAndView();
        String realPath = application.getRealPath("counselimg");
        if(ss_img1 != null && ss_img1.getSize() > 0){

            String f_name = FileRenameUtil.checkSameFileName(ss_img1.getOriginalFilename(), realPath);//이름바꿔준거 
            try {//파일업로드 
                ss_img1.transferTo(new File(realPath,f_name));
    
            } catch (Exception e) {
                 e.printStackTrace();
            }
            vo.setSs_img(f_name);
        }

      int cnt = ca_Service.add(vo);

      //System.out.println(cnt);
      mv.setViewName("redirect:counsel?listSelect=1&cPage=1");

        
        return mv;
    }

    //보고서등록버튼, 상담결과보고서등록페이지 이동
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
    public ModelAndView searchCourse(String num,String year,String select,String value,String listSelect,String cPage, String c_idx){
        if(cPage == null || cPage.trim().length() < 1)
            cPage = "1";
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
        select = null;
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
            CourseVO[] ar = null;
            if(value == null){
                page.setTotalRecord(c_Service.getCount());
                page.setNowPage(Integer.parseInt(cPage));
                ar= c_Service.getCourseList(String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
            }else{
                page.setTotalRecord(c_Service.getSearchCount(select, value, year));
                page.setNowPage(Integer.parseInt(cPage));
                ar = c_Service.searchCourse(select,value,year,String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
            }
            
            mv.addObject("ar", ar);
            mv.addObject("page", page);
        } else if(listSelect.equals("2")){
            mv.setViewName("/jsp/admin/counselManage/counselDateList_ajax");
            page.setTotalRecord(cs_Service.getSearchCount(select, value, year));
            page.setNowPage(Integer.parseInt(cPage));
            CounselVO[] ar = cs_Service.searchCounsel(select,value,year,String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
            
            mv.addObject("ar", ar);
            mv.addObject("page", page);
        } else if(listSelect.equals("3")) {
            mv.setViewName("/jsp/admin/counselManage/counselTraineeSearch_ajax");
            TraineeVO[] ar = null;
            if(c_idx != null && value == null){
                page.setTotalRecord(t_Service.getCourseTraineeCount(c_idx));
                page.setNowPage(Integer.parseInt(cPage));
                ar = t_Service.getCourseTraineeList(c_idx, String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
                mv.addObject("ar", ar);
                mv.addObject("page", page);
                mv.addObject("c_idx", c_idx);
            } else {
                page.setTotalRecord(t_Service.getCourseSearchCount(select, value, year));
                page.setNowPage(Integer.parseInt(cPage));
                ar = t_Service.getCourseTraineeSearchList(select,value,year,String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
        
                mv.addObject("ar", ar);
                mv.addObject("page", page);

            }
        }  else if(listSelect.equals("4")) {
            mv.setViewName("/jsp/admin/counselManage/counselTraineeInput_ajax");
            TraineeVO[] ar = null;
            page.setTotalRecord(t_Service.getCourseSearchValueCount(c_idx, select, value, year));
            page.setNowPage(Integer.parseInt(cPage));
            ar = t_Service.getCourseTraineeSearchValueList(c_idx, select,value,year,String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
    
            mv.addObject("ar", ar);
            mv.addObject("page", page);
            mv.addObject("c_idx", c_idx);
        }
        return mv;
   }

    @RequestMapping("counselMain")
    public ModelAndView counselMain(String listSelect, String cPage, String c_idx) {
        ModelAndView mv = new ModelAndView();
      if(cPage == null)
            cPage = "1";
      // cPage와 listSelect를 받아서 이를 통해 paging객체 만들기.
        
        
      Paging page = new Paging();
      if(listSelect.equals("1")) {
            mv.setViewName("/jsp/admin/counselManage/counselTypeList_ajax");
            page.setTotalRecord(c_Service.getCount());
            page.setNowPage(Integer.parseInt(cPage));
            CourseVO[] ar = null;
            ar = c_Service.getCourseList(String.valueOf(page.getBegin()),String.valueOf(page.getEnd()));
            
            mv.addObject("ar", ar);
            mv.addObject("page", page);
            
        }
      else if(listSelect.equals("2")){
            mv.setViewName("/jsp/admin/counselManage/counselDateList_ajax");
            page.setTotalRecord(cs_Service.getCount());
            page.setNowPage(Integer.parseInt(cPage));
            CounselVO[] ar = cs_Service.getCounselList(String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
            mv.addObject("ar", ar);
            mv.addObject("page", page);
        }
        else if(listSelect.equals("3")){
            mv.setViewName("/jsp/admin/counselManage/counselTraineeSearch_ajax");
            TraineeVO[] ar = null;
            if(c_idx != null){
                
                page.setTotalRecord(t_Service.getCourseTraineeCount(c_idx));
                page.setNowPage(Integer.parseInt(cPage));
                ar = t_Service.getCourseTraineeList(c_idx, String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
                mv.addObject("ar", ar);
                mv.addObject("page", page);
                mv.addObject("c_idx", c_idx);
            } else {
                ar = null;
                mv.addObject("ar", ar);
            }
            
        }else if(listSelect.equals("4")){
            mv.setViewName("/jsp/admin/counselManage/counselTraineeInput_ajax");
            TraineeVO[] ar = null;
            page.setTotalRecord(t_Service.getCourseTraineeCount(c_idx));
            page.setNowPage(Integer.parseInt(cPage));
            ar = t_Service.getCourseTraineeList(c_idx, String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
            mv.addObject("ar", ar);
            mv.addObject("page", page);
            mv.addObject("c_idx", c_idx);
        }else
            mv.setViewName("/jsp/admin/counselManage/counselTypeList_ajax");   
        
        return mv;
    }
    
    @RequestMapping("ss_dialog")
    public ModelAndView ss_dialog(String select,String c_idx, String tr_idx){
        ModelAndView mv = new ModelAndView();
        
        
        CourseVO cvo = c_Service.getCourse2(c_idx);
        mv.addObject("cvo", cvo);
        
        
        if(select.equals("addCounselFile"))
        mv.setViewName("/jsp/admin/counselManage/addCounselFile_ajax");
        else if(select.equals("counselAddMain"))
        mv.setViewName("/jsp/admin/counselManage/counselAddMain_ajax");
        
        else if(select.equals("uploadAllCounsel")) {
            mv.setViewName("/jsp/admin/counselManage/uploadAllCounsel_ajax");
            
            TraineeVO[] vo = t_Service.clist(c_idx, null, null);
            mv.addObject("ar", vo);
        }
        else if(select.equals("counselList")){
            mv.setViewName("/jsp/admin/counselManage/counselList_ajax");
            TraineeVO tvo = t_Service.view(tr_idx);
            CounselVO[] ar = cs_Service.counselList(tr_idx);
            tvo.setSs_num(Integer.toString(cs_Service.counselCount(tr_idx)));
            mv.addObject( "cvo", cvo);
            mv.addObject("tvo", tvo);
            mv.addObject("ar", ar);
            
        }
        else if(select.equals("counselListAdd")){
          System.out.println(select);
        mv.setViewName("/jsp/admin/counselManage/counselListAdd_ajax");

      }

        return mv;
    }
        
        
    
  
    @RequestMapping("counselTraineeSearch")
    public ModelAndView counselTraineeSearch(String value){
        ModelAndView mv = new ModelAndView();
        if(value == null || value.trim().length() < 1)
            value = null;
        mv.addObject("value", value);
        mv.setViewName("/jsp/admin/counselManage/counselTraineeSearch");

        return mv;
    }


    @RequestMapping("counselDateSearch")
    public ModelAndView counselDateSearch(String value){
        ModelAndView mv = new ModelAndView();
        if(value == null || value.trim().length() < 1)
            value = null;
        mv.addObject("value", value);
        mv.setViewName("/jsp/admin/counselManage/counselDateList");

        return mv;
    }

    @RequestMapping("uploadAllCounsel")
    public ModelAndView addAllCounsel(String[] date, String[] sf_name, String[] sf_idx, String[] select, String[] so_pp, String[] so_subject, String[] so_pd, String c_idx, String[] tr_idx){
        ModelAndView mv = new ModelAndView();
        CounselVO vo = new CounselVO();
        String ss_end;
        if(date != null && date.length > 0){
            for(int i = 0;i < date.length; i++){
                if(date[i] != null && date[i].trim().length() > 0){
                    vo.setC_idx(c_idx);
                    vo.setSo_day(date[i]);
                    vo.setTr_idx(tr_idx[i]);
                    vo.setSo_menu(select[i]);
                    vo.setSo_pp(so_pp[i]);
                    vo.setSo_subject(so_subject[i]);
                    vo.setSo_pd(so_pd[i]);
                    vo.setSo_tname(sf_name[i]);
                    vo.setSf_idx(sf_idx[i]);
                    cs_Service.addCounsel(vo);
                    ss_end = date[i];
                    t_Service.getCounsel_date(tr_idx[i], ss_end);
                }
            }
        }
        mv.setViewName("redirect:counsel?listSelect=4&cPage=1&c_idx="+c_idx);
        return mv;

    }

}
