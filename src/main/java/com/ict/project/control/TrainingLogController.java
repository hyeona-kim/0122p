package com.ict.project.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.CourseService;
import com.ict.project.service.TrainingDiaryService;
import com.ict.project.util.Paging;
import com.ict.project.vo.CourseVO;
import com.ict.project.vo.TrainingDiaryVO;

import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class TrainingLogController {

    @Autowired
    CourseService c_Service;
    @Autowired
    TrainingDiaryService td_Service;

    @RequestMapping("t_log")
    public ModelAndView t_log(String listSelect) {
        ModelAndView mv = new ModelAndView();
        if (listSelect.equals("1")) {
            mv.setViewName("/jsp/admin/trainingLog/traineeLog");
        } else if (listSelect.equals("2")) {
            mv.setViewName("/jsp/admin/trainingLog/plusTraining");
        }
        return mv;
    }

    @RequestMapping("trainingLog")
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
            mv.setViewName("/jsp/admin/trainingLog/traineeLog_ajax");
        else if (listSelect.equals("2"))
            mv.setViewName("/jsp/admin/trainingLog/plusTraining_ajax");
        return mv;
    }

    @RequestMapping("trainingDiary")
    public ModelAndView trainingDiary(String c_idx) {
        ModelAndView mv = new ModelAndView();
        CourseVO cvo = c_Service.getCourse2(c_idx);
        mv.addObject("cvo", cvo);
        mv.setViewName("/jsp/admin/trainingLog/trainingDiary");
        return mv;
    }

    @RequestMapping("diary_ajax")
    public ModelAndView diary(String listSelect, String select, String value, String num, String cPage, String c_idx) {
        ModelAndView mv = new ModelAndView();
        if (value == null || value.trim().length() < 1)
            select = null;
        if (num == null || num.trim().length() < 1 || num.equals("표시개수"))
            num = null;
        if (cPage == null)
            cPage = "1";

        Paging page = null;
        if (num == null)
            page = new Paging();
        else
            page = new Paging(Integer.parseInt(num), 5);

        page.setTotalRecord(td_Service.searchCount(c_idx, select, value));
        page.setNowPage(Integer.parseInt(cPage));
        mv.addObject("page", page);

        TrainingDiaryVO[] td_ar = td_Service.searchList(c_idx, select, value, String.valueOf(page.getBegin()),
                String.valueOf(page.getEnd()));
        mv.addObject("td_ar", td_ar);
        CourseVO cvo = c_Service.getCourse2(c_idx);
        mv.addObject("cvo", cvo);

        mv.setViewName("/jsp/admin/trainingLog/trainingDairy_ajax");
        return mv;
    }

    @RequestMapping("tl_dialog")
    public ModelAndView tl_dialog(String c_idx) {
        ModelAndView mv = new ModelAndView();
        CourseVO cvo = c_Service.getCourse2(c_idx);
        mv.addObject("cvo", cvo);
        mv.setViewName("/jsp/admin/trainingLog/writeDiary");
        return mv;
    }

    @RequestMapping("main_trainingdiary")
    public ModelAndView main_trainingdiary(String c_idx, String cPage) {
        ModelAndView mv = new ModelAndView();
        if (cPage == null || cPage.length() == 0)
            cPage = "1";
        Paging page = new Paging();
        page.setTotalRecord(td_Service.list_count(c_idx)); // 5개만 표현해야 함
        page.setNowPage(Integer.parseInt(cPage));
        TrainingDiaryVO[] td_ar = td_Service.course_list(c_idx, String.valueOf(page.getBegin()),
                String.valueOf(page.getEnd())); // begin, end 기본값 1, 5 각각 들어가있음
        mv.addObject("page", page);
        mv.addObject("td_ar", td_ar);
        mv.addObject("c_idx", c_idx);
        mv.setViewName("/jsp/admin/main_ajax2");

        return mv;
    }

    @RequestMapping("addDiary")
    public ModelAndView addDiary() {
        ModelAndView mv = new ModelAndView();

        return mv;
    }

}
