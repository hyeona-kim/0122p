package com.ict.project.control;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import com.ict.project.service.CourseService;
import com.ict.project.service.TraineeService;
import com.ict.project.vo.CourseVO;
import com.ict.project.vo.TraineeVO;

@Controller
public class FollwupController {
    @Autowired
    CourseService c_Service;
    @Autowired
    TraineeService tr_Service;

    @RequestMapping("f_log")
    public ModelAndView f_log(String listSelect) {

        ModelAndView mv = new ModelAndView();

        if (listSelect.equals("1")) {
            CourseVO[] ar = c_Service.getList();

            mv.addObject("c_ar", ar);
            mv.addObject("length", ar.length);
            mv.setViewName("/jsp/admin/follwup/job");

        } else if (listSelect.equals("2")) {
            mv.setViewName("/jsp/admin/follwup/");
        } else if (listSelect.equals("3")) {
            mv.setViewName("/jsp/admin/follwup/");
        } else if (listSelect.equals("4")) {
            mv.setViewName("/jsp/admin/follwup/");
        } else if (listSelect.equals("5")) {
            mv.setViewName("/jsp/admin/follwup/");
        } else if (listSelect.equals("6")) {
            mv.setViewName("/jsp/admin/follwup/");
        }

        return mv;
    }

    @RequestMapping("job")
    public ModelAndView job(String listSelect, String year, String select, String c_idx) {
        ModelAndView mv = new ModelAndView();
        if (c_idx.equals("0")) {
            System.out.println(0);
            CourseVO[] ar = c_Service.searchCourse(null, null, null, "1",
                    String.valueOf(c_Service.getSearchCount(null, null, null)));
            mv.addObject("ar", ar);
            mv.addObject("length", ar.length);
            mv.setViewName("/jsp/admin/follwup/job_ajax");
        } else {
            System.out.println(c_idx);
            CourseVO cvo = c_Service.getCourse(c_idx);
            mv.addObject("ar", cvo);
            mv.addObject("length", 1);
            mv.setViewName("/jsp/admin/follwup/job_ajax");

        }

        return mv;
    }

}
