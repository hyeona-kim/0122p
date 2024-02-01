package com.ict.project.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.CourseService;
import com.ict.project.service.TraineeService;
import com.ict.project.util.Paging;
import com.ict.project.vo.CourseVO;
import com.ict.project.vo.TraineeVO;

@Controller
public class totalController {
    @Autowired
    CourseService cs_Service;
    @Autowired
    TraineeService tr_Service;

    @RequestMapping("total")
    public ModelAndView total(String listSelect){
        ModelAndView mv = new ModelAndView();
        
        if(listSelect.equals("1")){
            mv.setViewName("jsp/admin/totalManage/courseTotal");

        }else if (listSelect.equals("2")){
            mv.setViewName("jsp/admin/totalManage/traineeTotal");
            int totalCourse =cs_Service.getSearchCount(null, null, null);
            CourseVO[] c_ar = cs_Service.searchCourse(null, null, null, "1", String.valueOf(totalCourse));
            mv.addObject("c_ar", c_ar);
        }else if (listSelect.equals("3")){
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

    @RequestMapping("traineeTotal")
    public ModelAndView trainee(String listSelect,String c_idx,String value,String select){
        ModelAndView mv = new ModelAndView();   
        if(value == null || value.length()==0)
            select =null;

        int cnt =tr_Service.getTCount(c_idx, null, null, select, value);
        TraineeVO[] ar = tr_Service.getTList("1", String.valueOf(cnt),c_idx, null, null, select, value);
        mv.addObject("t_ar", ar);
        if(ar!= null){
            for(int i=0; i<ar.length;i++){
                String str2 = ar[i].getTr_rrn();
                int divisionCode = Integer.parseInt(str2.substring(7,8));
                if(divisionCode%2 ==0){//여자
                    ar[i].setGender(false);
                }else{
                    ar[i].setGender(true);
                }
                String dateOfBirth = null;
                if(divisionCode == 1 || divisionCode == 2 || divisionCode == 5 || divisionCode == 6){
                    // 한국인 1900~, 외국인 1900~
                    dateOfBirth = "19"+str2.substring(0, 2)+"-"+str2.substring(2, 4)+"-"+str2.substring(4, 6);
                }else if(divisionCode == 3 || divisionCode == 4 || divisionCode == 7 || divisionCode == 8){
                    // 한국인 2000~, 외국인 2000~
                    dateOfBirth = "20"+str2.substring(0, 2)+"-"+str2.substring(2, 4)+"-"+str2.substring(4, 6);
                }else if(divisionCode == 9 || divisionCode == 0){
                    // 한국인 1800~
                    dateOfBirth = "18"+str2.substring(0, 2)+"-"+str2.substring(2, 4)+"-"+str2.substring(4, 6);
                }
                ar[i].setTr_rrn(dateOfBirth);
            }
        }
        mv.setViewName("jsp/admin/totalManage/traineeTotal_ajax");
        return mv;
    }
    
    


}
