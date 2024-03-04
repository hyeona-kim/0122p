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
import com.ict.project.service.CourseTypeService;
import com.ict.project.service.TraineeService;
import com.ict.project.util.Paging;
import com.ict.project.vo.CourseTypeVO;
import com.ict.project.vo.CourseVO;
import com.ict.project.vo.TraineeVO;

@Controller
public class FollwupController {
    @Autowired
    CourseService c_Service;
    @Autowired
    CourseTypeService ct_Service;
    @Autowired
    TraineeService tr_Service;
    @Autowired
    TraineeService t_Service;

    @RequestMapping("f_log")
    public ModelAndView f_log(String listSelect) {

        ModelAndView mv = new ModelAndView();

        if (listSelect.equals("1")) {
            CourseVO[] ar = c_Service.getList();
            CourseTypeVO[] ct_ar = ct_Service.getList();
            mv.addObject("c_ar", ar);
            mv.addObject("ct_ar", ct_ar);
            mv.setViewName("/jsp/admin/follwup/job");

        } else if (listSelect.equals("2")) {
            mv.setViewName("/jsp/admin/follwup/jobsituation");
        } else if (listSelect.equals("3")) {
            mv.setViewName("/jsp/admin/follwup/ex_post");
        } else if (listSelect.equals("4")) {
            mv.setViewName("/jsp/admin/follwup/ex_postlist");
        } else if (listSelect.equals("5")) {
            mv.setViewName("/jsp/admin/follwup/employment");
        } else if (listSelect.equals("6")) {
            mv.setViewName("/jsp/admin/follwup/");
        }

        return mv;
    }

    @RequestMapping("job")
    public ModelAndView job(String listSelect, String ct_idx, String c_idx) {
        ModelAndView mv = new ModelAndView();

        CourseVO[] ar = c_Service.search_ct(c_idx, ct_idx);
        mv.addObject("ar", ar);

        mv.setViewName("/jsp/admin/follwup/job_ajax");

        return mv;
    }

    @RequestMapping("jobsituation")
    public ModelAndView jobsituation(String listSelect, String year, String ct_idx, String c_idx) {

        ModelAndView mv = new ModelAndView();
        CourseVO[] ar = c_Service.search_ct(c_idx, ct_idx);

        mv.addObject("ar", ar);
        mv.setViewName("/jsp/admin/follwup/jobsituation_ajax");

        return mv;
    }

    /* 과정별 훈련생 현황 메뉴 */
    @RequestMapping("ex_post")
    public ModelAndView ex_post(String cPage, String value, String select, String year, String num, String listselect) {
        ModelAndView mv = new ModelAndView();
        if (cPage == null)
            cPage = "1";
        if (value == null || value.trim().length() == 0) {
            value = null;
            select = null;
        }
        if (year == null || year.equals("년도선택") || year.trim().length() == 0)
            year = null;
        if (num == null || num.equals("표시개수"))
            num = null;

        Paging page = null;

        if (num != null && num.length() > 0)
            page = new Paging(Integer.parseInt(num), 5);
        else
            page = new Paging();

        page.setTotalRecord(c_Service.getSearchCount(select, value, year));

        page.setNowPage(Integer.parseInt(cPage));
        mv.addObject("page", page);
        CourseVO[] ar = c_Service.searchCourse(select, value, year, String.valueOf(page.getBegin()),
                String.valueOf(page.getEnd()));
        mv.addObject("ar", ar);

        if (listselect != null && listselect.equals("3")) {
            mv.setViewName("/jsp/admin/follwup/ex_post_ajax");
        } else if (listselect != null && listselect.equals("4")) {
            mv.setViewName("/jsp/admin/follwup/ex_postlist_ajax");
        } else if (listselect != null && listselect.equals("5")) {
            mv.setViewName("/jsp/admin/follwup/employment_ajax");
        }

        return mv;
    }

    @RequestMapping("current")
    public ModelAndView traineecurrentbt1(String cPage, String c_idx, String listselect) {
        ModelAndView mv = new ModelAndView();
        Paging page = new Paging();

        page.setTotalRecord(t_Service.getCount());

        if (cPage == null || cPage.length() == 0) {
            page.setNowPage(1);
        } else {
            int nowPage = Integer.parseInt(cPage);
            page.setNowPage(nowPage);

        }

        TraineeVO[] tv = t_Service.clist(c_idx, String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
        CourseVO aa = c_Service.getCourse(c_idx);
        mv.addObject("ar", tv);
        mv.addObject("page", page);
        mv.addObject("c_idx", c_idx);
        mv.addObject("aa", aa);

        if (listselect != null && listselect.equals("3")) {
            mv.setViewName("jsp/admin/follwup/postcurrent");
        } else if (listselect != null && listselect.equals("5"))
            mv.setViewName("jsp/admin/follwup/employmentbt");

        return mv;
    }
}
