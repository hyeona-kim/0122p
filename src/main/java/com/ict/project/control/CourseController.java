package com.ict.project.control;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.mapper.SkillMapper;
import com.ict.project.service.CourseService;
import com.ict.project.service.CourseTypeService;
import com.ict.project.service.RoomService;
import com.ict.project.service.SkillService;
import com.ict.project.service.StaffService;
import com.ict.project.service.UpskillService;
import com.ict.project.util.LmsBean;
import com.ict.project.util.Paging;
import com.ict.project.vo.CourseTypeVO;
import com.ict.project.vo.CourseVO;
import com.ict.project.vo.RoomVO;
import com.ict.project.vo.SkillVO;
import com.ict.project.vo.StaffVO;
import com.ict.project.vo.UpSkillVO;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


@Controller
public class CourseController {
    @Autowired
    HttpServletRequest request;
    @Autowired
    HttpSession session;
    @Autowired
    ServletContext application;
    @Autowired
	CourseService c_Service;
	@Autowired
	CourseTypeService ct_Service;
	@Autowired
	RoomService r_Service;
	@Autowired
	StaffService s_Service;
	@Autowired
	UpskillService us_Service;
    @Autowired
    SkillService sk_Service;

    @RequestMapping("course")
    public String course(String listSelect) {
        String viewPath = null;
        if(listSelect.equals("1"))
            viewPath= "/jsp/admin/courseReg/courselog";
        else if(listSelect.equals("2"))
            viewPath="/jsp/admin/courseReg/serve";
        else if(listSelect.equals("3"))
            viewPath= "/jsp/admin/courseReg/maketime";
        
        return viewPath;
    }

    @RequestMapping("addCourse")
    public String addCourse( CourseVO cvo,String listSelect) {
        
        c_Service.addCourse(cvo);
              
        return "redirect:course?listSelect="+listSelect;
    }
     @RequestMapping("delCourse")
    public String delCourse(String c_idx,String cPage) {
		
		int cnt = c_Service.deleteCourse(c_idx);
		
		return "redirect:course?listSelect=1";
    }
    
    @RequestMapping("editCourse")
    public String editCourse(CourseVO cvo,String edit) {
       if(edit == null) {
        CourseVO vo = c_Service.getCourse(cvo.getC_idx());
        request.setAttribute("edit_cvo", vo);
        return "/jsp/admin/courseReg/editCourse_ajax";
        }else{
            c_Service.editCourse(cvo);
            return "redirect:course?listSelect=1&cPage=1";
        }
    }
    
    @RequestMapping("viewCourse")
    public String viewCourse(String c_idx) {
        String viewPath = null;

        // c_idx를 기반으로 CourseVO 객체 가져오기
        CourseVO vo = c_Service.getCourse(c_idx);
      
        request.setAttribute("select_vo", vo);

        viewPath ="redirect:course&listSelect=1";

        return viewPath;
    }

    @RequestMapping("searchCourse")
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
		page.setTotalRecord(c_Service.getSearchCount(select, value, year));
		page.setNowPage(Integer.parseInt(cPage));
		
		CourseVO[] ar = c_Service.searchCourse(select,value,year,String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
	
		mv.addObject("ar", ar);
		mv.addObject("page", page);

		
		//비동기 통신할 jsp로 보내기
		if(listSelect.equals("1"))
            mv.setViewName("/jsp/admin/courseReg/courseLog_ajax");
		else if(listSelect.equals("2"))
            mv.setViewName("/jsp/admin/courseReg/serve_ajax");

		else if(listSelect.equals("3"))
            mv.setViewName("/jsp/admin/courseReg/makeTime_ajax");
        return mv;
	}

    @RequestMapping("addCourseType")
    public ModelAndView addCourseType(String[] name,String[] text, String listSelect) {
        ModelAndView mv = new ModelAndView();
        String[] ct_name = name;
		String[] ct_color =text;
		CourseTypeVO vo = new CourseTypeVO();
		
		if(ct_name != null && !ct_name.equals("")) {
			for(int i = 0; i < ct_name.length;i++) {
				if(ct_name[i] != null && !ct_name[i].isEmpty()) {
					vo.setCt_name(ct_name[i]);
					vo.setCt_color(ct_color[i]);
					vo.setCt_idx(Integer.toString(i+1));
					ct_Service.addCourseType(vo);
				}
				
			}
		}
		mv.setViewName("redirect:course?listSelect="+listSelect);
        return mv;
    }
    @RequestMapping("courseMain")
    public ModelAndView courseMain(String listSelect, String cPage) {
        ModelAndView mv = new ModelAndView();
		
		// cPage와 listSelect를 받아서 이를 통해 paging객체 만들기.
		Paging page = new Paging();
		page.setTotalRecord(c_Service.getCount());
		page.setNowPage(Integer.parseInt(cPage));
		CourseVO[] ar = null;
		ar = c_Service.getCourseList(String.valueOf(page.getBegin()),String.valueOf(page.getEnd()));
		mv.addObject("ar", ar);
		mv.addObject("page", page);
		if(listSelect.equals("1"))
			mv.setViewName("/jsp/admin/courseReg/courseLog_ajax");
		else if(listSelect.equals("2"))
            mv.setViewName("/jsp/admin/courseReg/serve_ajax");
		else if(listSelect.equals("3"))
            mv.setViewName("/jsp/admin/courseReg/makeTime_ajax"); 
		else
            mv.setViewName("/jsp/admin/courseReg/courseLog_ajax");	
		
        return mv;
    }
    @RequestMapping("addRoom")
    public String addRoom(String[] className,String[] roomSep,String[] use,String listSelect) {
       
        String[] r_name = className;
		String[] r_sep = roomSep;
		String[] r_status = use;
		RoomVO vo = new RoomVO();
		
		if(r_name != null && !r_name.equals("")) {
			for(int i = 0; i < r_name.length;i++) {
				if(r_name[i] != null && !r_name[i].isEmpty()) {
					vo.setR_name(r_name[i]);
					vo.setR_sep(r_sep[i]);
					vo.setR_status(r_status[i]);
					vo.setR_idx(Integer.toString(i+1));
					r_Service.addRoom(vo);
				}
				
			}
		}
		return "redirect:course&listSelect="+listSelect;
    }
    @RequestMapping("c_dialog")
    public ModelAndView c_dialog(String select) {
        ModelAndView mv = new ModelAndView();
        Object obj3 = request.getAttribute("c_ar");
		Object obj4 = request.getAttribute("r_ar");
		

		CourseTypeVO[] c_ar = null;
		if(obj3 == null)
			c_ar = ct_Service.getList();
		else
			c_ar = (CourseTypeVO[]) obj3;
		
		request.setAttribute("c_ar", c_ar);
		
		RoomVO[] r_ar = null;
		if(obj4 == null)
			r_ar = r_Service.getList();
		else
			r_ar = (RoomVO[])obj4;
		
		request.setAttribute("r_ar", r_ar);
		
		StaffVO[] s_ar = s_Service.getList();
		request.setAttribute("s_ar", s_ar);
		
		if(select.equals("addCourse"))
			mv.setViewName("/jsp/admin/courseReg/addCourse_ajax");
		else if(select.equals("addCourseType"))
            mv.setViewName("/jsp/admin/courseReg/addCourseType_ajax");
		else if(select.equals("addRoom"))
            mv.setViewName("/jsp/admin/courseReg/addRoom_ajax");
		else if(select.equals("editCourse"))
            mv.setViewName("/jsp/admin/courseReg/editCourse_ajax");
		else if(select.equals("addUpskill"))
            mv.setViewName("/jsp/admin/courseReg/addUpskill_ajax");
        return mv;
    }
@RequestMapping("upskill")
    public ModelAndView upskill() {
        ModelAndView mv = new ModelAndView();
		UpSkillVO[] ar = null;
		ar = us_Service.getUpskillList();
		SkillVO[] ar2 = null;
		ar2 = sk_Service.getSkillList();
		
		mv.addObject("ar2", ar2);
		mv.addObject("ar", ar);

        mv.setViewName("/jsp/admin/courseReg/upskill");
        return mv;
    }

    
}
