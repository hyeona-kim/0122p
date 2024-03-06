package com.ict.project.control;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.CourseService;
import com.ict.project.service.TraineeService;
import com.ict.project.service.TrainingDiaryService;
import com.ict.project.util.FileRenameUtil;
import com.ict.project.util.Paging;
import com.ict.project.vo.CourseVO;
import com.ict.project.vo.TraineeVO;
import com.ict.project.vo.TrainingDiaryVO;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;


@Controller
public class StaffModeController {
    @Autowired
    CourseService c_Service;
    @Autowired
    TrainingDiaryService td_Service;
    @Autowired
    HttpServletRequest request;
    @Autowired
    ServletContext application;
    @Autowired
    TraineeService t_Service;
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
    @RequestMapping("s_traineeEdit")
   public ModelAndView traineeEdit(TraineeVO tvo, String tr_idx, String c_idx) {
        ModelAndView mv = new ModelAndView();
        String enc_type = request.getContentType();
        String viewPath = null;
        System.out.println();
      if ( enc_type == null) {
         TraineeVO vo = t_Service.tlist(tvo.getTr_idx(), c_idx);
         CourseVO vo2 = c_Service.getCourse(c_idx);

         mv.addObject("c_idx", c_idx);
         mv.addObject("vo2", vo2);
         mv.addObject("vo9", vo);
         if (tvo.getT_path() != null) {
            if (tvo.getT_path().contains("인터넷"))
               mv.addObject("ch1", true);
            if (tvo.getT_path().contains("전단지"))
               mv.addObject("ch2", true);
            if (tvo.getT_path().contains("현수막"))
               mv.addObject("ch3", true);
            if (tvo.getT_path().contains("생활정보지"))
               mv.addObject("ch4", true);
            if (tvo.getT_path().contains("고용지원센터"))
               mv.addObject("ch5", true);
            if (tvo.getT_path().contains("직접내방"))
               mv.addObject("ch6", true);
            if (tvo.getT_path().contains("지인소개"))
               mv.addObject("ch7", true);
            if (tvo.getT_path().contains("HRD"))
               mv.addObject("ch8", true);
            if (tvo.getT_path().contains("기타"))
               mv.addObject("ch9", true);
         }
         viewPath = "jsp/staff/schoolRecord/traineeInfo";
      } else if (enc_type != null && enc_type.startsWith("multipart")){
         String[] ab = tvo.getTr_rrn().split(",");
         tvo.setTr_rrn(ab[0] + "-" + ab[1]);
         String[] ab2 = tvo.getTr_phone().split(",");
         tvo.setTr_phone(ab2[0] + "-" + ab2[1] + "-" + ab2[2]);
         String[] ab3 = tvo.getTr_hp().split(",");
         tvo.setTr_hp(ab3[0] + "-" + ab3[1] + "-" + ab3[2]);

         MultipartFile f = tvo.getFile();
         if (f != null && f.getSize() > 0) {

            String realPath = application.getRealPath("/upload_file");
            String fname = f.getOriginalFilename();
            tvo.setOri_name(fname);

            fname = FileRenameUtil.checkSameFileName(fname, realPath);

            try {
               f.transferTo(new File(realPath, fname));
               tvo.setFile_name(fname);
            } catch (Exception e) {
               e.printStackTrace();
            }
         }

         String str = tvo.getTr_addr();
         String[] aa = str.split(",");
         str = "";
         for (String bb : aa) {
            str += bb;
         }
         tvo.setTr_addr(str);

         int cnt = t_Service.trainedit(tvo);
         viewPath = ("redirect:traineecurrentbt1?c_idx=" + c_idx);
      }
      mv.setViewName(viewPath);
      return mv;
   }

}
