package com.ict.project.control;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.CourseService;
import com.ict.project.service.CourseTypeService;
import com.ict.project.service.RoomService;
import com.ict.project.service.StaffService;
import com.ict.project.util.LmsBean;
import com.ict.project.util.Paging;
import com.ict.project.vo.CourseTypeVO;
import com.ict.project.vo.CourseVO;
import com.ict.project.vo.RoomVO;
import com.ict.project.vo.StaffVO;

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

    @RequestMapping("course")
    public String course(String listSelect) {
        String viewPath = null;
        if(listSelect.equals("1"))
            viewPath= "/jsp/admin/courseReg/courselog.jsp";
        else if(listSelect.equals("2"))
            viewPath="/jsp/admin/courseReg/serve.jsp";
        else if(listSelect.equals("3"))
            viewPath= "/jsp/admin/courseReg/maketime.jsp";
        
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
		ModelAndView mv = new ModelAndView();
        request.removeAttribute("page");
		 
		Paging page = null;

		if(value == null || value.length()<1) {
			value = null;
		}
		if(select == null || select.length()<1){
			select = null;
		}
		
		if(year == null || year.length()==0) {
			year = null;
		}

		LmsBean bean = new LmsBean();
		
		if(value != null && select.equals("1")) {
			StaffVO vo = bean.searchStaff2(value);
			value = vo.getSf_idx();
		}else if(value != null &&select.equals("2")) {
			CourseTypeVO vo = bean.searchCourseType2(value);
			value = vo.getCt_idx();
		}else if(value != null && select.equals("3")) {
			RoomVO vo = bean.searchRoom2(value);
			value = vo.getR_idx();
		}

		if(num!=null && num.length()>0 )
			page = new Paging(Integer.parseInt(num),5);
		else 
			page = new Paging();

		
		page.setTotalRecord(c_Service.getSearchCount(select,value,year));

		 
		if(cPage == null||cPage.equals("undefined")) {
	        page.setNowPage(1);
		}else {
	       int nowPage = Integer.parseInt(cPage);
	       page.setNowPage(nowPage);
	    }
		
		

		CourseVO[] ar = c_Service.searchCourse(select,value,year,String.valueOf(page.getBegin()),
				String.valueOf(page.getEnd()));
	
		mv.addObject("ar", ar);
		mv.addObject("page", page);
		
		String[] ct_name = null;
		String[] r_name = null;
		String[] sf_name = null;
		
		LmsBean lb = new LmsBean();
		
		if(ar != null) {
			ct_name= new String[ar.length];
			r_name= new String[ar.length];
			sf_name= new String[ar.length];
			int i = 0;
			for(CourseVO vo :ar) {
				if(vo.getCt_idx() == null) {
					ct_name[i] ="";
				}else {
					String cName = lb.searchCourseType(vo.getCt_idx()).getCt_name();
					ct_name[i] = cName;
				}
				
				if(vo.getR_idx() == null) {
					r_name[i] ="";
				}else {
					String rName = lb.searchRoom(vo.getR_idx()).getR_name();
					r_name[i] = rName;					
				}
				
				if(vo.getT_idx() ==null) {
					sf_name[i] ="";
				}else {
					String sName = lb.searchStaff(vo.getT_idx()).getSf_name();
					sf_name[i] = sName;					
				}
                i++;
            }
        }   
        mv.addObject("ct_names",ct_name);
        mv.addObject("r_names",r_name);
        mv.addObject("sf_names",sf_name);
		
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
        Object obj = request.getAttribute("page");
		Object obj2 = request.getAttribute("ar");
	
		Paging page = null;
		if(listSelect == null)
			listSelect ="1";
		
		if(obj == null) {
			page =new Paging();
			page.setTotalRecord(c_Service.getCount());
			if(cPage == null|| cPage.equalsIgnoreCase("undefined"))
				page.setNowPage(1);
			else {
				int nowPage = Integer.parseInt(cPage);
				page.setNowPage(nowPage);
			}
		}else {
			page = (Paging)obj;
		}
		
		CourseVO[] ar = null;
		if(obj2 == null)
			ar = c_Service.getCourseList(String.valueOf(page.getBegin()),String.valueOf(page.getEnd()));
		else
			ar = (CourseVO[])obj2;
		
		request.setAttribute("page", page);
		request.setAttribute("ar",ar);
		//////////////////////////////////////////////
		String[] ct_name = null;
		String[] r_name = null;
		String[] sf_name = null;
		
		LmsBean lb = new LmsBean();
		
		if(ar != null) {
			ct_name= new String[ar.length];
			r_name= new String[ar.length];
			sf_name= new String[ar.length];
			int i = 0;
			for(CourseVO vo :ar) {
				if(vo.getCt_idx() == null) {
					ct_name[i] ="";
				}else {
					String cName = lb.searchCourseType(vo.getCt_idx()).getCt_name();
					ct_name[i] = cName;
				}
				
				if(vo.getR_idx() == null) {
					r_name[i] ="";
				}else {
					String rName = lb.searchRoom(vo.getR_idx()).getR_name();
					r_name[i] = rName;					
				}
				
				if(vo.getT_idx() ==null) {
					sf_name[i] ="";
				}else {
					String sName = lb.searchStaff(vo.getT_idx()).getSf_name();
					sf_name[i] = sName;					
				}
				i++;
			}
		}
		
		request.setAttribute("ct_names",ct_name);
		request.setAttribute("r_names",r_name);
		request.setAttribute("sf_names",sf_name);
		
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
		
        return mv;
    }
    
}
