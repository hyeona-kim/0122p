package com.ict.project.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.CourseService;
import com.ict.project.util.Paging;
import com.ict.project.util.Paging2;
import com.ict.project.vo.CourseVO;

@Controller
public class totalController {
    @Autowired
    CourseService cs_Service;

@RequestMapping("total")
public ModelAndView total(String listSelect){
    ModelAndView mv = new ModelAndView();
        if(listSelect.equals("1")){
            mv.setViewName("jsp/admin/totalManage/courseTotal");

        }
        else if (listSelect.equals("2")){
            mv.setViewName("jsp/admin/totalManage/courseTotal");
        }
        else if (listSelect.equals("3")){
            mv.setViewName("jsp/admin/totalManage/courseTotal");
        }
        return mv;
    }
@RequestMapping("courseList")
public ModelAndView courseList(String cPage, String year, String select, String value,String num){
    ModelAndView mv = new ModelAndView();
    if(value == null||value.trim().length()==0){
        value = null;
        select = null;
    } 
    if(year.equals("년도선택")|| year.trim().length()==0)
        year = null;
    if(num.equals("표시개수"))
        num=null;

    Paging page = null;

    if(num != null && num.length() >0)
        page = new Paging(Integer.parseInt(num),5);
    else
        page = new Paging();

    page.setTotalRecord(cs_Service.getSearchCount(select, value, year));
    page.setNowPage(Integer.parseInt(cPage));
    mv.addObject("page", page);
    CourseVO[] ar = cs_Service.searchCourse(select, value, year,String.valueOf(page.getBegin()) ,String.valueOf(page.getEnd()) );
    mv.addObject("c_ar", ar);

    mv.setViewName("jsp/admin/totalManage/table");
    
        return mv;
    }

    


}
