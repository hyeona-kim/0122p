package com.ict.project.control;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.WeeklyMeetingService;
import com.ict.project.util.FileRenameUtil;
import com.ict.project.util.Paging;
import com.ict.project.vo.CounselingdetailVO;
import com.ict.project.vo.WeeklyMeetingVO;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class WeeklyMeetingController {
    @Autowired
    HttpServletRequest request;
    @Autowired
    HttpServletResponse response;
    @Autowired
    HttpSession session;
    @Autowired
    WeeklyMeetingService wk_Service;
    @Autowired
    ServletContext application;

    @RequestMapping("weeklyMeeting")
    public ModelAndView weeklyMeeting() {
        ModelAndView mv = new ModelAndView();
        WeeklyMeetingVO[] ar = wk_Service.getWeeklyMeetingList();
        mv.addObject("ar", ar);
        mv.setViewName("/jsp/admin/etcList/weeklyMeeting/weeklyMeeting");
        return mv;
    }

    @RequestMapping("weeklyMeetingMain")
    public ModelAndView weeklyMeetingMain(String listSelect) {
        ModelAndView mv = new ModelAndView();

        Paging page = new Paging();
        page.setTotalRecord(wk_Service.getSearchCount(null, null));
        page.setNowPage(1);

        mv.addObject("page", page);

        WeeklyMeetingVO[] ar = wk_Service.searchweeklyMeeting(null, null, String.valueOf(page.getBegin()),
                String.valueOf(page.getEnd()));

        mv.addObject("wk_ar", ar);
        if (listSelect.equals("1"))
            mv.setViewName("/jsp/admin/etcList/weeklyMeeting/weeklyMeeting_ajax");
        else if (listSelect.equals("2")) {
            mv.setViewName("/jsp/admin/etcList/weeklyMeeting/");
        }
        return mv;
    }

    @RequestMapping("addWeeklyMeeting")
    public ModelAndView addWeeklyMeeting(WeeklyMeetingVO vo) {
        ModelAndView mv = new ModelAndView();
        String encType = request.getContentType();
        System.out.println(encType);
        if (encType.startsWith("appli")) {
            wk_Service.addWeeklyMeeting(vo);
        } else if (encType.startsWith("multipart")) {
            MultipartFile mf = vo.getFile();
            String fname = null;

            if (mf != null && mf.getSize() > 0) {
                String realPath = application.getRealPath("upload_wk");

                String oname = mf.getOriginalFilename();

                fname = FileRenameUtil.checkSameFileName(oname, realPath);

                try {
                    mf.transferTo(new File(realPath, fname));
                } catch (Exception e) {
                    e.printStackTrace();
                }
                vo.setWk_file_name(fname);
                vo.setWk_ori_name(oname);
            }
            wk_Service.addWeeklyMeeting(vo);
        }

        mv.setViewName("redirect:weeklyMeeting?listSelect=1");
        return mv;
    }

    @RequestMapping("wk_dialog")
    public ModelAndView wk_dialog(String select, String cr_idx) {
        ModelAndView mv = new ModelAndView();

        WeeklyMeetingVO[] ar = wk_Service.getWeeklyMeetingList();
        mv.addObject("wk_ar", ar);

        if (select.equals("addWeeklyMeeting"))
            mv.setViewName("/jsp/admin/etcList/weeklyMeeting/addWeeklyMeeting_ajax");
        else if (select.equals("editWeeklyMeeting"))
            mv.setViewName("/jsp/admin/etcList/weeklyMeeting/editWeeklyMeeting_ajax");

        return mv;

    }

    @RequestMapping("delWeeklyMeeting")
    public String delWeeklyMeeting(String wk_idx) {
        int cnt = wk_Service.delWeeklyMeeting(wk_idx);

        return "redirect:weeklyMeeting?listSelect=1";
    }

    @RequestMapping("editWeeklyMeeting")
    public ModelAndView editWeeklyMeeting(WeeklyMeetingVO wvo, String edit, String wk_idx) {
        ModelAndView mv = new ModelAndView();
        int cnt = wk_Service.editWeeklyMeeting(wvo);
        mv.setViewName("redirect:weeklyMeeting?listSelect=1");
        return mv;
    }

    @RequestMapping("weeklyMeetingEditForm")
    public ModelAndView weeklyMeetingEditForm(String wk_idx) {
        ModelAndView mv = new ModelAndView();
        WeeklyMeetingVO vo = wk_Service.getWk(wk_idx);
        mv.addObject("edit_war", vo);
        mv.setViewName("/jsp/admin/etcList/weeklyMeeting/editWeeklyMeeting_ajax");
        return mv;
    }

    @RequestMapping("searchweeklyMeeting")
    public ModelAndView searchweeklyMeeting(String num, String select, String value, String listSelect, String cPage) {

        if (value == null || value.trim().length() == 0) {
            value = null;
            select = null;
        }

        if (num.equals("표시개수"))
            num = null;

        ModelAndView mv = new ModelAndView();
        Paging page = null;
        if (num != null && num.length() > 0)
            page = new Paging(Integer.parseInt(num), 5);
        else
            page = new Paging();

        page.setTotalRecord(wk_Service.getSearchCount(select, value));

        page.setNowPage(Integer.parseInt(cPage));

        WeeklyMeetingVO[] ar = null;

        ar = wk_Service.searchweeklyMeeting(select, value, String.valueOf(page.getBegin()),
                String.valueOf(page.getEnd()));
        mv.addObject("wk_ar", ar);
        mv.addObject("page", page);

        // 비동기 통신할 jsp로 보내기
        if (listSelect.equals("1"))
            mv.setViewName("/jsp/admin/etcList/weeklyMeeting/weeklyMeeting_ajax");
        else if (listSelect.equals(""))
            mv.setViewName("/jsp/admin/etcList/weeklyMeeting/");
        return mv;
    }

}
