package com.ict.project.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.CourseService;
import com.ict.project.service.SubjectService;
import com.ict.project.service.TrainingDiaryService;
import com.ict.project.util.Paging;
import com.ict.project.vo.CourseVO;
import com.ict.project.vo.SubjectVO;
import com.ict.project.vo.TrainingDiaryVO;

@Controller
public class EvaluationManageController {

    @Autowired
    CourseService c_Service;
    @Autowired
    SubjectService s_Service;

    @Autowired
    TrainingDiaryService td_Service;

    @RequestMapping("em_log")
    public ModelAndView em_log(String listSelect) {
        ModelAndView mv = new ModelAndView();
        if (listSelect.equals("1")) {
            mv.setViewName("/jsp/admin/evaluationManage/settingSubject");
        } else if (listSelect.equals("2")) {
            mv.setViewName("/jsp/admin/evaluationManage/testSubject");
        } else if (listSelect.equals("3")) {
            mv.setViewName("/jsp/admin/evaluationManage/traineetotaltest");
        } else if (listSelect.equals("4")) {
            mv.setViewName("/jsp/admin/evaluationManage/upskill");
        } else if (listSelect.equals("5")) {
            mv.setViewName("/jsp/admin/evaluationManage/traineeseveralty");
        } else if (listSelect.equals("6")) {
            mv.setViewName("/jsp/admin/evaluationManage/skillseveralty");
        } else if (listSelect.equals("7")) {
            mv.setViewName("/jsp/admin/evaluationManage/skilltest");
        } else if (listSelect.equals("8")) {
            mv.setViewName("/jsp/admin/evaluationManage/deviation");
        } else if (listSelect.equals("9")) {
            mv.setViewName("/jsp/admin/evaluationManage/testcomparison");
        } else if (listSelect.equals("10")) {
            mv.setViewName("/jsp/admin/evaluationManage/testcomparison_mt");
        } else if (listSelect.equals("11")) {
            mv.setViewName("/jsp/admin/evaluationManage/upskilltest");
        } else if (listSelect.equals("12")) {
            mv.setViewName("/jsp/admin/evaluationManage/testfile");
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
        if (listSelect.equals("1")) {
            mv.setViewName("/jsp/admin/evaluationManage/settingSubject_ajax");
        } else if (listSelect.equals("2")) {
            mv.setViewName("/jsp/admin/evaluationManage/testSubject_ajax");
        } else if (listSelect.equals("3")) {
            mv.setViewName("/jsp/admin/evaluationManage/traineetotaltest_ajax");
        } else if (listSelect.equals("4")) {
            mv.setViewName("/jsp/admin/evaluationManage/upskill_ajax");
        } else if (listSelect.equals("5")) {
            mv.setViewName("/jsp/admin/evaluationManage/traineeseveralty_ajax");
        } else if (listSelect.equals("6")) {
            mv.setViewName("/jsp/admin/evaluationManage/skillseveralty_ajax");
        } else if (listSelect.equals("7")) {
            mv.setViewName("/jsp/admin/evaluationManage/skilltest_ajax");
        } else if (listSelect.equals("8")) {
            mv.setViewName("/jsp/admin/evaluationManage/deviation_ajax");
        } else if (listSelect.equals("9")) {
            mv.setViewName("/jsp/admin/evaluationManage/testcomparison_ajax");
        } else if (listSelect.equals("10")) {
            mv.setViewName("/jsp/admin/evaluationManage/testcomparison_mt_ajax");
        } else if (listSelect.equals("11")) {
            mv.setViewName("/jsp/admin/evaluationManage/upskilltest_ajax");
        } else if (listSelect.equals("12")) {
            mv.setViewName("/jsp/admin/evaluationManage/testfile_ajax");
        }

        return mv;
    }

    @RequestMapping("subjectStatus")
    public ModelAndView subjectStatus(String c_idx) {
        ModelAndView mv = new ModelAndView();
        CourseVO cvo = c_Service.getCourse2(c_idx);
        mv.addObject("cvo", cvo);
        mv.setViewName("/jsp/admin/evaluationManage/subjectStatus");
        return mv;
    }

    @RequestMapping("diary_ajax2")
    public ModelAndView diary(String listSelect, String select, String value, String num, String cPage, String c_idx) {
        ModelAndView mv = new ModelAndView();

        if (num == null || num.trim().length() < 1 || num.equals("표시개수"))
            num = null;
        if (cPage == null)
            cPage = "1";

        SubjectVO[] s_ar = s_Service.getList(Integer.parseInt(c_idx));

        CourseVO cvo = c_Service.getCourse2(c_idx);
        mv.addObject("cvo", cvo);
        mv.addObject("s_ar", s_ar);

        mv.setViewName("/jsp/admin/evaluationManage/subjectStatus_ajax");
        return mv;
    }

}
