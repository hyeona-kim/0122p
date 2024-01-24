package com.ict.project.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.CounselAddService;
import com.ict.project.service.CounselService;
import com.ict.project.util.Paging;
import com.ict.project.vo.CounselVO;
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
    


  


    @RequestMapping("counsel")
    public String counsel(String listSelect) {
        String viewPath = null;
        if(listSelect.equals("1"))
            viewPath= "counselAdd";
        else if(listSelect.equals("2"))
            viewPath="/jsp/admin/counselManage/counselDateList";
        else if(listSelect.equals("3"))
            viewPath= "/jsp/admin/counselManage/counselTraineeSearch";
        
        return viewPath;
    }

    @RequestMapping("addCounselFile")
    public String addCounsel( CounselVO vo,String listSelect) {
        
        cs_Service.addCounsel(vo);
              
        return "redirect:counsel?listSelect="+listSelect;
    }
     @RequestMapping("delCounsel")
    public String delCounsel(String so_idx,String cPage) {
		
		cs_Service.deleteCounsel(so_idx);
		
		return "redirect:counsel?listSelect=1";
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
    @RequestMapping("counselAdd")
    public String viewCourse2(String so_idx) {
        String viewPath = null;

        // so_idx를 기반으로 CounselVO 객체 가져오기
        CounselVO vo = cs_Service.getCounsel(so_idx);
      
        request.setAttribute("select_vo", vo);

        viewPath ="";

        return viewPath;
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
		if(num!=null && num.length()>0 )
			page = new Paging(Integer.parseInt(num),5);
		else 
			page = new Paging();
		

		if(value == null || value.length()<1) {
			value = null;
		}
		if(select == null || select.length()<1){
			select = null;
		}
		
		if(year == null || year.length()==0) {
			year = null;
		}
		page.setTotalRecord(cs_Service.getSearchCount(select, value, year));
		page.setNowPage(Integer.parseInt(cPage));
		
		CounselVO[] ar = cs_Service.searchCounsel(select,value,year,String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
	
		mv.addObject("ar", ar);
		mv.addObject("page", page);

		
		//비동기 통신할 jsp로 보내기
		if(listSelect.equals("1"))
            mv.setViewName("/jsp/admin/counselManage/counselTypeList_ajax");
		else if(listSelect.equals("2"))
            mv.setViewName("/jsp/admin/counselManage/counselDataList_ajax");

		else if(listSelect.equals("3"))
            mv.setViewName("/jsp/admin/counselManage/counselTraineeSearch_ajax");
        return mv;
	}

    @RequestMapping("counselMain")
    public ModelAndView counselMain(String listSelect, String cPage) {
        ModelAndView mv = new ModelAndView();
		
		// cPage와 listSelect를 받아서 이를 통해 paging객체 만들기.
		Paging page = new Paging();
		page.setTotalRecord(cs_Service.getCount());
		page.setNowPage(Integer.parseInt(cPage));
		CounselVO[] ar = null;
		ar = cs_Service.getCounselList(String.valueOf(page.getBegin()),String.valueOf(page.getEnd()));
		mv.addObject("ar", ar);
		mv.addObject("page", page);
		if(listSelect.equals("1"))
			mv.setViewName("/jsp/admin/counselManage/counselTypeList_ajax");
		else if(listSelect.equals("2"))
            mv.setViewName("/jsp/admin/counselManage/counselDateList_ajax");
		else if(listSelect.equals("3"))
            mv.setViewName("/jsp/admin/counselManage/counselTraineeList_ajax"); 
		else
            mv.setViewName("/jsp/admin/counselManage/counselTypeList_ajax");	
		
        return mv;
    }
  


}
