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
public class StaffModeController {
    @Autowired
    CourseService c_Service;
    @Autowired
    TrainingDiaryService td_Service;
    //훈련일지
    @RequestMapping("s_diary_ajax")
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

        mv.setViewName("/jsp/staff/trainingLog/trainingDairy_ajax");
        return mv;
    }

    @RequestMapping("s_tl_dialog")
    public ModelAndView tl_dialog(String c_idx) {
        ModelAndView mv = new ModelAndView();
        CourseVO cvo = c_Service.getCourse2(c_idx);
        mv.addObject("cvo", cvo);
        mv.setViewName("/jsp/staff/trainingLog/writeDiary");
        return mv;
    }

    @RequestMapping("s_addDiary")
    public ModelAndView addDiary(String chk1, String chk2, String chk3, TrainingDiaryVO vo) {
        ModelAndView mv = new ModelAndView();
      
        vo.setTd_attend(chk1);
        vo.setTd_tardy(chk2);
        vo.setTd_earlyLeave(chk3);

        CourseVO cvo = c_Service.getCourse2(vo.getC_idx());
        mv.addObject("cvo", cvo);
        int cnt = td_Service.td_add(vo);
        mv.setViewName("redirect:staffMain?leftList=1&c_idx="+cvo.getC_idx());
        return mv;
    }
    @RequestMapping("s_delTraining")
    public String s_delTraining(String td_idx,String c_idx) {
        int cnt =td_Service.del_td(td_idx);
        //System.out.println(cnt);
        return "redirect:staffMain?leftList=1&c_idx="+c_idx;
    }
    
    @RequestMapping("s_viewTraining")
    public ModelAndView s_viewTraining(String td_idx,String c_idx) {
        ModelAndView mv = new ModelAndView();
        //System.out.println(c_idx);
        mv.setViewName("/jsp/staff/trainingLog/viewDiary");
        //td_idx를 통해 VO객체 가지고오기
        TrainingDiaryVO tdvo = td_Service.get_td(td_idx);
        CourseVO cvo = c_Service.getCourse2(c_idx);

        mv.addObject("cvo",cvo);
        mv.addObject("tdvo",tdvo);
        return mv;
    }
    @RequestMapping("s_editTraining")
    public ModelAndView s_editTraining(String td_idx,String c_idx) {
        ModelAndView mv = new ModelAndView();
        //System.out.println(c_idx);
        mv.setViewName("/jsp/staff/trainingLog/editDiary");
        //td_idx를 통해 VO객체 가지고오기
        TrainingDiaryVO tdvo = td_Service.get_td(td_idx);
        CourseVO cvo = c_Service.getCourse2(c_idx);

        mv.addObject("cvo",cvo);
        mv.addObject("tdvo",tdvo);
        return mv;
    }
    @RequestMapping("s_editDiary")
    public ModelAndView s_editDiary(String chk1, String chk2, String chk3, TrainingDiaryVO vo) {
        ModelAndView mv = new ModelAndView();
      
        vo.setTd_attend(chk1);
        vo.setTd_tardy(chk2);
        vo.setTd_earlyLeave(chk3);

        CourseVO cvo = c_Service.getCourse2(vo.getC_idx());
        mv.addObject("cvo", cvo);
        int cnt = td_Service.edit_td(vo);
        mv.setViewName("redirect:staffMain?leftList=1&c_idx="+cvo.getC_idx());
        return mv;
    }
    
    //평가관리


    //과정별 훈련생 관리

}
