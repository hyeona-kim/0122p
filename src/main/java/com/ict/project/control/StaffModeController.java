package com.ict.project.control;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.BusinessService;
import com.ict.project.service.CounselService;
import com.ict.project.service.CourseService;
import com.ict.project.service.CourseTypeService;
import com.ict.project.service.QcService;
import com.ict.project.service.SubjectService;
import com.ict.project.service.TraineeService;
import com.ict.project.service.TrainingDiaryService;
import com.ict.project.service.TrfinalService;
import com.ict.project.service.WorkplusService;
import com.ict.project.util.FileRenameUtil;
import com.ict.project.util.Paging;
import com.ict.project.vo.BusinessVO;
import com.ict.project.vo.CounselVO;
import com.ict.project.vo.CourseTypeVO;
import com.ict.project.vo.CourseVO;
import com.ict.project.vo.QcVO;
import com.ict.project.vo.SubjectVO;
import com.ict.project.vo.TraineeVO;
import com.ict.project.vo.TrainingDiaryVO;
import com.ict.project.vo.TrfinalVO;
import com.ict.project.vo.WorkplusVO;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
   @Autowired
   BusinessService bs_Service;
   @Autowired
   QcService q_Service;
   @Autowired
   TrfinalService tf_Service;
   @Autowired
   WorkplusService w_Service;
   @Autowired
   CourseTypeService ct_Service;
   @Autowired
   HttpServletResponse response;
   @Autowired
   CounselService cc_Service;
   @Autowired
   SubjectService s_Service;

   // 훈련일지
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
      mv.setViewName("redirect:staffMain?leftList=1&c_idx=" + cvo.getC_idx());
      return mv;
   }

   @RequestMapping("s_delTraining")
   public String s_delTraining(String td_idx, String c_idx) {
      int cnt = td_Service.del_td(td_idx);
      // System.out.println(cnt);
      return "redirect:staffMain?leftList=1&c_idx=" + c_idx;
   }

   @RequestMapping("s_viewTraining")
   public ModelAndView s_viewTraining(String td_idx, String c_idx) {
      ModelAndView mv = new ModelAndView();
      // System.out.println(c_idx);
      mv.setViewName("/jsp/staff/trainingLog/viewDiary");
      // td_idx를 통해 VO객체 가지고오기
      TrainingDiaryVO tdvo = td_Service.get_td(td_idx);
      CourseVO cvo = c_Service.getCourse2(c_idx);

      mv.addObject("cvo", cvo);
      mv.addObject("tdvo", tdvo);
      return mv;
   }

   @RequestMapping("s_editTraining")
   public ModelAndView s_editTraining(String td_idx, String c_idx) {
      ModelAndView mv = new ModelAndView();
      // System.out.println(c_idx);
      mv.setViewName("/jsp/staff/trainingLog/editDiary");
      // td_idx를 통해 VO객체 가지고오기
      TrainingDiaryVO tdvo = td_Service.get_td(td_idx);
      CourseVO cvo = c_Service.getCourse2(c_idx);

      mv.addObject("cvo", cvo);
      mv.addObject("tdvo", tdvo);
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
      mv.setViewName("redirect:staffMain?leftList=1&c_idx=" + cvo.getC_idx());
      return mv;
   }
   //
   //
   //
   //
   //
   //
   //
   //
   //
   //
   //
   //
   //
   //
   //
   //
   //
   //
   //
   //
   //
   //
   //
   //
   //
   //

   // 평가관리
   @RequestMapping("diary_ajax_s")
   public ModelAndView diary(String listSelect, String num, String cPage, String c_idx, String s_idx) {
      ModelAndView mv = new ModelAndView();

      if (num == null || num.trim().length() < 1 || num.equals("표시개수"))
         num = null;
      if (cPage == null)
         cPage = "1";

      SubjectVO[] s_ar = s_Service.getList(Integer.parseInt(c_idx));
      mv.addObject("s_ar", s_ar);

      mv.setViewName("/jsp/staff/evaluate/subjectStatus_ajax");
      return mv;
   }

   // 과정별 훈련생 관리
   @RequestMapping("s_traineeEdit")
   public ModelAndView traineeEdit(TraineeVO tvo, String tr_idx, String c_idx) {
      ModelAndView mv = new ModelAndView();
      String enc_type = request.getContentType();
      String viewPath = null;
      System.out.println();
      if (enc_type == null) {
         TraineeVO vo = t_Service.tlist(tvo.getTr_idx(), c_idx);
         CourseVO vo2 = c_Service.getCourse(c_idx);

         mv.addObject("c_idx", c_idx);
         mv.addObject("vo2", vo2);
         mv.addObject("vo9", vo);
         if (vo.getT_path() != null) {
            if (vo.getT_path().contains("인터넷"))
               mv.addObject("t_path1", 1);
            if (vo.getT_path().contains("전단지"))
               mv.addObject("t_path2", 2);
            if (vo.getT_path().contains("현수막")) {
               mv.addObject("t_path3", 3);
            }
            if (vo.getT_path().contains("생활정보지")) {
               mv.addObject("t_path4", 4);
            }
            if (vo.getT_path().contains("고용지원센터")) {
               mv.addObject("t_path5", 5);
            }
            if (vo.getT_path().contains("직접내방")) {
               mv.addObject("t_path6", 6);
            }
            if (vo.getT_path().contains("지인소개"))
               mv.addObject("t_path7", 7);
            if (vo.getT_path().contains("HRD"))
               mv.addObject("t_path8", 8);
            if (vo.getT_path().contains("기타"))
               mv.addObject("t_path9", 9);
         }
         viewPath = "jsp/staff/schoolRecord/traineeInfo";
      } else if (enc_type != null && enc_type.startsWith("multipart")) {
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
         } else {
            tvo.setOri_name(null);
            tvo.setFile_name(null);
         }
         String str = tvo.getTr_addr();

         String[] aa = str.split(",");
         str = "";

         if (aa.length == 0) {
            tvo.setTr_addr(null);
         } else {
            for (String bb : aa) {
               str += bb + " ";
            }
            tvo.setTr_addr(str);
         }

         int cnt = t_Service.trainedit(tvo);
         viewPath = ("redirect:staffMain?leftList=4&c_idx=" + c_idx);
      }
      mv.setViewName(viewPath);
      return mv;
   }

   @RequestMapping("s_traineewrite")
   public ModelAndView traineewrite(String tr_idx, String c_idx) {
      ModelAndView mv = new ModelAndView();
      // System.out.println(c_idx);
      TraineeVO vo = t_Service.view(tr_idx);
      CourseVO cvo = c_Service.getCourse(c_idx);
      BusinessVO bvo = bs_Service.list(tr_idx);
      QcVO[] ar = q_Service.list(tr_idx);
      TrfinalVO tfvo = tf_Service.list(tr_idx);
      CourseTypeVO ctvo = ct_Service.getOne(cvo.getCt_idx());

      mv.addObject("bvo", bvo);
      mv.addObject("ar", ar);
      mv.addObject("tfvo", tfvo);
      mv.addObject("vo12", vo);
      mv.addObject("cc", cvo);
      mv.addObject("ctvo", ctvo);
      if (ar != null && ar.length > 0) {
         mv.addObject("length", ar.length);
      } else {
         mv.addObject("length", 0);
      }
      mv.setViewName("jsp/staff/schoolRecord/Traineewrite");
      return mv;
   }

   @RequestMapping("s_Traineewrite_ajax")
   public ModelAndView Traineewrite_ajax(String tr_idx, String c_idx, BusinessVO bvo, TrfinalVO tfvo, TraineeVO tvo,
         String[] qc_idx, String[] qc_name, String[] qc_date, String[] qc_place, String[] qc_cname, String[] qc_day,
         String[] qc_job, String[] qc_position, String[] qc_tridx) {
      ModelAndView mv = new ModelAndView();
      int cnt = 5;
      int cnt1 = 5;
      int cnt2 = 5;
      int cnt3 = 5;
      int cnt4 = 5;
      QcVO vo = new QcVO();
      // 값이 들어 왔을 경우에만 실행해야 함

      if (bvo != null) {
         bvo.setTr_idx(tr_idx);
         if (bvo.getBs_idx() != null && bvo.getBs_idx().trim().length() > 0)
            cnt = bs_Service.bedit(bvo);
         else
            cnt = bs_Service.badd(bvo);
      }
      if (tfvo != null) {
         tfvo.setTr_idx(tr_idx);
         if (tfvo.getTf_idx() != null && tfvo.getTf_idx().trim().length() > 0)
            cnt1 = tf_Service.tfedit(tfvo);
         else
            cnt1 = tf_Service.tfadd(tfvo);
      }
      if (qc_date != null && qc_date.length > 0) {
         for (int i = 0; i < qc_tridx.length; i++) {
            if (qc_date[i] == null || qc_date[i].trim().length() < 1) // 값이 안들어있다면 vo에 값을 넣을 이유가 없음
               continue;
            vo.setQc_name(qc_name[i]);
            vo.setTr_idx(tr_idx);
            vo.setQc_date(qc_date[i]);
            vo.setQc_place(qc_place[i]);
            vo.setQc_cname(qc_cname[i]);
            vo.setQc_day(qc_day[i]);
            vo.setQc_job(qc_job[i]);
            vo.setQc_position(qc_position[i]);
            vo.setQc_tridx(qc_tridx[i]);
            if ((qc_idx != null && qc_idx.length > 0) && i < qc_idx.length
                  && (qc_idx[i] != null && qc_idx[i].trim().length() > 0)) {
               vo.setQc_idx(qc_idx[i]);
               cnt2 = q_Service.editWrite(vo);
            } else {
               cnt3 = q_Service.addWrite(vo);
            }

         }
      }

      if (tvo.getTr_etc() != null && tvo.getTr_etc().trim().length() > 0) {
         cnt4 = t_Service.etcedit(tvo);
      }
      // System.out.println(cnt + "/" + cnt1 + "/" + cnt2 + "/" + cnt3 + "/" + cnt4);
      mv.setViewName("redirect:staffMain?leftList=4&c_idx=" + c_idx);
      return mv;
   }

   @RequestMapping("s_mangecard")
   public ModelAndView mangecard(String tr_idx, String c_idx, String cPage, TraineeVO tvo, CourseVO ccvo,
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
      if (qvo == null) {
         mv.addObject("length", 0);
      } else {
         mv.addObject("length", qvo.length);
      }
      mv.addObject("tfvo", tfvo);
      mv.addObject("tr_idx", tr_idx);
      mv.addObject("c_idx", c_idx);
      mv.addObject("cvo2", cvo);
      mv.addObject("vo15", vo);

      mv.setViewName("jsp/staff/schoolRecord/afterManageCard");

      return mv;

   }

   @RequestMapping("s_afterManage_axaj")
   public ModelAndView afterManage_axaj(String[] wp_skill, String[] wp_area, String tr_idx, String c_idx,
         WorkplusVO wvo, QcVO qvo, MultipartFile file) {
      ModelAndView mv = new ModelAndView();

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
            if (sb.length() > 0)
               sb.deleteCharAt(sb.length() - 1); // 값이 하나라도 있었다면 마지막 값은 /, 없을경우 if문 자체가 실행되지 않음
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
            if (sb.length() != 0) {
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

      mv.setViewName("redirect:staffMain?leftList=4&c_idx=" + c_idx);

      return mv;
   }

   @RequestMapping("AfterManagedownFile")
   public String AfterManagedownFile(String file_name) {
      System.out.println(file_name);
      String realPath = application.getRealPath("/upload_file");

      // System.out.println(realPath);
      String fullPath = realPath + System.getProperty("file.separator") + file_name;

      File f = new File(fullPath);
      if (f.exists() && f.isFile()) {
         byte[] buf = new byte[2048];

         BufferedInputStream bis = null;
         BufferedOutputStream bos = null;
         FileInputStream fis = null;
         ServletOutputStream sos = null;
         try {
            response.setContentType("application/x-msdownload");
            response.setHeader("Content-Disposition",
                  "attachment;filename=" + new String(file_name.getBytes(), "8859_1"));
            fis = new FileInputStream(f);
            bis = new BufferedInputStream(fis);
            // 응답 객체를 통해 output스트림 생성
            sos = response.getOutputStream();
            bos = new BufferedOutputStream(sos);
            int size = -1;
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
            } catch (Exception e2) {
               e2.printStackTrace();
            }
         }
      }
      return null;
   }

   // 상담관리
   @RequestMapping("s_counseling")
   public ModelAndView s_counseling(String tr_idx, String c_idx, String so_idx) {
      ModelAndView mv = new ModelAndView();
      TraineeVO vo = t_Service.view(tr_idx);
      CourseVO cvo = c_Service.getCourse(c_idx);
      CounselVO[] ccvo = cc_Service.counselList(tr_idx);

      if (ccvo != null)
         mv.addObject("ss_num", ccvo.length);
      mv.addObject("ccvo", ccvo);
      mv.addObject("vo11", vo);
      mv.addObject("cv", cvo);
      mv.setViewName("jsp/staff/schoolRecord/traineeCounseling");

      return mv;
   }

   @RequestMapping("s_counseling_detail")
   public ModelAndView s_counseling_detai(String so_idx, String tr_idx) {
      ModelAndView mv = new ModelAndView();

      CounselVO vo = cc_Service.getCounsel(so_idx);
      mv.addObject("ss_num", cc_Service.counselCount(tr_idx));
      mv.addObject("vo", vo);
      mv.setViewName("/jsp/staff/schoolRecord/counselEdit_ajax");

      return mv;
   }

   @RequestMapping("s_delCounsel")
   @ResponseBody
   public Map<String, Integer> delCounsel(String so_idx) {
      Map<String, Integer> map = new HashMap<>();
      int cnt = cc_Service.deleteCounsel(so_idx);
      map.put("cnt", cnt);
      return map;
   }

   @RequestMapping("s_updateCounsel")
   @ResponseBody
   public Map<String, Integer> s_updateCounsel(CounselVO csvo) {
      Map<String, Integer> map = new HashMap<>();

      int cnt = cc_Service.editCounsel(csvo);
      map.put("cnt", cnt);
      return map;
   }

   // /s_add_counsel
   @RequestMapping("s_add_counsel")
   public ModelAndView s_add_counsel(String tr_idx) {
      ModelAndView mv = new ModelAndView();
      TraineeVO tvo = t_Service.view(tr_idx);
      mv.addObject("tvo", tvo);
      mv.addObject("ss_num", cc_Service.counselCount(tr_idx));
      mv.setViewName("/jsp/staff/schoolRecord/counselListAdd_ajax");

      return mv;
   }

   // s_counselListAdd
   @RequestMapping("s_counselListAdd")
   public ModelAndView s_counselListAdd(CounselVO csvo) {
      ModelAndView mv = new ModelAndView();
      cc_Service.addCounsel(csvo);
      mv.setViewName("redirect:staffMain?leftList=4&c_idx=" + csvo.getC_idx());

      return mv;
   }
}