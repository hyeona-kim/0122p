package com.ict.project.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.CourseService;
import com.ict.project.service.SubjectService;
import com.ict.project.util.Paging;
import com.ict.project.vo.CourseVO;

@Controller
public class EvaluationManageController {

    @Autowired
    CourseService c_Service;
    @Autowired
    SubjectService s_Service;

    @RequestMapping("em_log")
    public ModelAndView em_log(String listSelect) {
        ModelAndView mv = new ModelAndView();
        if (listSelect.equals("1")) {
            mv.setViewName("/jsp/admin/evaluationManage/settingSubject");
        } else if (listSelect.equals("2")) {
            mv.setViewName(" ");
        }

        return mv;
    }

    @RequestMapping("evalutationManageLog")
    public ModelAndView trainingLog(String listSelect, String select, String value, String year, String num,
            String cPage) {
        ModelAndView mv = new ModelAndView();
        if (value == null || value.trim().length() < 1)
            select = null;
        if (year == null || year.trim().length() < 1 || year.equals("년도선택"))
            year = null;
        if (num == null || num.trim().length() < 1 || num.equals("표시개수"))
            num = null;
        if (cPage == null)
            cPage = "1";

        Paging page = null;
        if (num == null)
            page = new Paging();
        else
            page = new Paging(Integer.parseInt(num), 5);
        page.setTotalRecord(c_Service.getSearchCount(select, value, year));
        page.setNowPage(Integer.parseInt(cPage));

        mv.addObject("page", page);
        CourseVO[] ar = c_Service.searchCourse(select, value, year, String.valueOf(page.getBegin()),
                String.valueOf(page.getEnd()));
        mv.addObject("c_ar", ar);
        if (listSelect.equals("1"))
            mv.setViewName("/jsp/admin/evaluationManage/settingSubject_ajax");
        else if (listSelect.equals("2"))
            mv.setViewName("");
        return mv;
    }

}
