package com.ict.project.control;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import com.ict.project.service.CourseService;
import com.ict.project.service.CourseTypeService;
import com.ict.project.service.QcService;
import com.ict.project.service.TraineeService;
import com.ict.project.service.TrfinalService;
import com.ict.project.service.WorkplusService;
import com.ict.project.util.FileRenameUtil;
import com.ict.project.util.Paging;
import com.ict.project.vo.CourseTypeVO;
import com.ict.project.vo.CourseVO;
import com.ict.project.vo.QcVO;
import com.ict.project.vo.TraineeVO;
import com.ict.project.vo.TrfinalVO;
import com.ict.project.vo.WorkplusVO;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class FollwupController {
    @Autowired
    HttpServletRequest request;
    @Autowired
    HttpServletResponse response;
    @Autowired
    HttpSession session;
    @Autowired
    ServletContext application;
    @Autowired
    CourseService c_Service;
    @Autowired
    CourseTypeService ct_Service;
    @Autowired
    TraineeService t_Service;
    @Autowired
    QcService q_Service;
    @Autowired
    TrfinalService tf_Service;
    @Autowired
    WorkplusService w_Service;

    @RequestMapping("f_log")
    public ModelAndView f_log(String listSelect) {

        ModelAndView mv = new ModelAndView();
        mv.addObject("listSelect", listSelect);

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
            mv.setViewName("/jsp/admin/follwup/alljobsituation");
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
    public ModelAndView ex_post(String cPage, String value, String select, String year, String num, String listSelect) {
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
        if (listSelect != null && listSelect.equals("3")) {
            mv.setViewName("/jsp/admin/follwup/ex_post_ajax");
        } else if (listSelect != null && listSelect.equals("4")) {
            mv.setViewName("/jsp/admin/follwup/ex_postlist_ajax");
        } else if (listSelect != null && listSelect.equals("5")) {
            mv.setViewName("/jsp/admin/follwup/employment_ajax");
        }

        return mv;
    }

    @RequestMapping("current")
    public ModelAndView current(String cPage, String c_idx, String listSelect, String value, String select) {
        ModelAndView mv = new ModelAndView();

        CourseVO aa = c_Service.getCourse2(c_idx);

        mv.addObject("c_idx", c_idx);
        mv.addObject("aa", aa);
        if (listSelect != null && listSelect.equals("3")) {
            mv.setViewName("jsp/admin/follwup/postcurrent");
        } else if (listSelect != null && listSelect.equals("5")) {
            mv.setViewName("jsp/admin/follwup/employmentbt");
        } else if (listSelect != null && listSelect.equals("6")) {
            Paging page = new Paging();

            if (value.trim().length() > 0) {
                page.setTotalRecord(t_Service.follwupcount(value, select));
            } else {
                page.setTotalRecord(t_Service.getCount());
            }

            if (cPage == null || cPage.length() == 0) {
                page.setNowPage(1);
            } else {
                int nowPage = Integer.parseInt(cPage);
                page.setNowPage(nowPage);
            }
            TraineeVO[] tvo = t_Service.follup(String.valueOf(page.getBegin()), String.valueOf(page.getEnd()), c_idx,
                    value, select);
            mv.addObject("tvo", tvo);
            mv.addObject("page", page);

            mv.setViewName("jsp/admin/follwup/alljobsituation_ajax");
        }

        return mv;
    }

    @RequestMapping("fl_Download")
    public ResponseEntity<Resource> fileDownload(String f_name) {
        System.out.println(f_name);
        String realPath = application.getRealPath("/upload_follwup/" + f_name);

        File f = new File(realPath);

        if (f.exists()) {
            byte[] buf = new byte[4096];
            int size = -1;

            BufferedInputStream bis = null;
            FileInputStream fis = null;

            BufferedOutputStream bos = null;
            ServletOutputStream sos = null;

            try {
                response.setContentType("application/x-msdownload");
                response.setHeader("Content-Disposition",
                        "attachment;filename=" + new String(f_name.getBytes(), "8859_1"));

                fis = new FileInputStream(f);
                bis = new BufferedInputStream(fis);

                sos = response.getOutputStream();
                bos = new BufferedOutputStream(sos);

                while ((size = bis.read(buf)) != -1) {
                    bos.write(buf, 0, size);
                    bos.flush();
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (fis != null)
                        fis.close();
                    if (bis != null)
                        bis.close();
                    if (sos != null)
                        sos.close();
                    if (bos != null)
                        bos.close();
                } catch (Exception e) {
                }
            }
        }
        return null;

    }

    @RequestMapping("savefl_Img")
    public ModelAndView saveBoardImg(MultipartFile f_file, String tr_idx, String c_idx) {

        ModelAndView mv = new ModelAndView();

        // MultipartFile이 인자로 넘어오는 경우에는
        // 무조건 생성해서 넘어오기 때문에 null과 비교하면 안된다
        if (f_file.getSize() > 0) {
            String realPath = application.getRealPath("upload_follwup");

            String oname = f_file.getOriginalFilename();

            String f_name = FileRenameUtil.checkSameFileName(oname, realPath);
            // db에 훈련생 컬럼에 업데이트
            int cnt = c_Service.update_f_file(f_name, tr_idx);
            try {
                f_file.transferTo(new File(realPath, f_name));
            } catch (Exception e) {
                e.printStackTrace();
            }

            String Path = request.getContextPath();
            mv.setViewName("redirect:current?listSelect=5&c_idx=" + c_idx);

        }
        return mv;
    }

    @RequestMapping("fl_mangecard")
    public ModelAndView fl_mangecard(String tr_idx, String c_idx, String cPage, TraineeVO tvo, CourseVO ccvo,
            WorkplusVO wwvo, String select) {
        ModelAndView mv = new ModelAndView();
        if (select != null && select.trim().length() > 0) {
            mv.addObject("select", select);
        }

        // System.out.println(tr_idx);
        TraineeVO vo = t_Service.view(tr_idx);
        CourseVO cvo = c_Service.getCourse(c_idx);
        TrfinalVO tfvo = tf_Service.list(tr_idx);
        QcVO[] qvo = q_Service.list(tr_idx);
        WorkplusVO wvo = w_Service.list(tr_idx, c_idx);

        String str2 = vo.getTr_rrn();
        int divisionCode = Integer.parseInt(str2.substring(7, 8));
        if (divisionCode % 2 == 0)// 여자
            vo.setGender(false);
        else// 남자
            vo.setGender(true);
        String dateOfBirth = null;
        if (divisionCode == 1 || divisionCode == 2 || divisionCode == 5 || divisionCode == 6) {
            // 한국인 1900~, 외국인 1900~
            dateOfBirth = "19" + str2.substring(0, 2) + "-" + str2.substring(2, 4) + "-" + str2.substring(4, 6);
        } else if (divisionCode == 3 || divisionCode == 4 || divisionCode == 7 || divisionCode == 8) {
            // 한국인 2000~, 외국인 2000~
            dateOfBirth = "20" + str2.substring(0, 2) + "-" + str2.substring(2, 4) + "-" + str2.substring(4, 6);
        } else if (divisionCode == 9 || divisionCode == 0) {
            // 한국인 1800~
            dateOfBirth = "18" + str2.substring(0, 2) + "-" + str2.substring(2, 4) + "-" + str2.substring(4, 6);
        }
        vo.setTr_rrn(dateOfBirth);
        if (wvo != null) {

            String[] skill = wvo.getWp_skill().split("/");
            String[] area = wvo.getWp_area().split("/");
            mv.addObject("skill", skill);
            mv.addObject("area", area);
        }

        mv.addObject("wvo", wvo);
        mv.addObject("qvo", qvo);
        if (qvo != null)
            mv.addObject("length", qvo.length);
        else
            mv.addObject("length", 0);
        mv.addObject("tfvo", tfvo);
        mv.addObject("tr_idx", tr_idx);
        mv.addObject("c_idx", c_idx);
        mv.addObject("cvo2", cvo);
        mv.addObject("vo15", vo);

        mv.setViewName("/jsp/admin/follwup/afterManageCard");

        return mv;

    }

    @RequestMapping("fl_afterManage_axaj")
    public ModelAndView fl_afterManage_axaj(String[] wp_skill, String[] wp_area, String tr_idx, String c_idx,
            WorkplusVO wvo, QcVO qvo, MultipartFile file, String select) {
        ModelAndView mv = new ModelAndView();

        // int cnt2 = 3;
        // int cnt3 = 3;
        /*
         * for(String wp_idx: r10){
         * cnt += w_Service.addwork(wp_idx,tr_idx);
         * }
         */

        if (wvo != null) {
            String enc_type = request.getContentType();
            if (enc_type.startsWith("multipart")) {
                try {

                    String realPath = application.getRealPath("/upload_file");
                    String fname = null;
                    String oname = null;
                    if (file.getSize() > 0) {
                        oname = file.getOriginalFilename();
                        fname = FileRenameUtil.checkSameFileName(oname, realPath);
                        try {
                            file.transferTo(new File(realPath, fname));
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                    wvo.setFile_name(fname);
                    wvo.setOri_name(oname);
                } catch (Exception e) {
                    e.printStackTrace();
                }

            }
            if (wp_skill != null && wp_skill.length > 0) {
                StringBuffer sb = new StringBuffer();
                for (int i = 0; i < wp_skill.length; i++) {
                    if (wp_skill[i] == null || wp_skill[i].trim().length() < 1) // 값이 없으면 다음으로 넘어감
                        continue;
                    sb.append(wp_skill[i]);
                    sb.append("/"); // 반복문 탈출 후 마지막 index(sb.length - 1)값 삭제
                }
                if (sb.length() > 0) {
                    sb.deleteCharAt(sb.length() - 1); // 값이 하나라도 있었다면 마지막 값은 /, 없을경우 if문 자체가 실행되지 않음
                }
                wvo.setWp_skill(sb.toString()); // 배열에 있는 값에 따라 x ~ x/x/x 사이의 값이 들어간다
            }
            if (wp_area != null && wp_area.length > 0) {
                StringBuffer sb = new StringBuffer();
                for (int i = 0; i < wp_area.length; i++) {
                    if (wp_area[i] == null || wp_area[i].trim().length() < 1)
                        continue;
                    sb.append(wp_area[i]);
                    sb.append("/");
                }
                if (sb.length() > 0) {
                    sb.deleteCharAt(sb.length() - 1);
                }
                wvo.setWp_area(sb.toString());
            }
            if (wvo.getWp_idx() != null && wvo.getWp_idx().trim().length() > 0) // 이미 wp_idx값이 있을 경우(수정)
                w_Service.editwork(wvo);
            else
                w_Service.addwork(wvo);
        }

        if (qvo != null) {
            if (qvo.getQc_idx() != null && qvo.getQc_idx().trim().length() > 0)
                q_Service.qqedit(qvo);
            else
                q_Service.add(qvo);
        }
        if (select != null && select.equals("3")) {
            mv.setViewName("redirect:current?listSelect=3&c_idx=" + c_idx);
        } else {

            mv.setViewName("redirect:current?listSelect=3&c_idx=" + c_idx);
        }
        return mv;
    }

}
