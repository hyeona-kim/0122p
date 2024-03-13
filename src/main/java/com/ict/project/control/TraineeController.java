package com.ict.project.control;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.BusinessService;
import com.ict.project.service.ConfirmService;
import com.ict.project.service.CounselService;
import com.ict.project.service.CourseService;
import com.ict.project.service.CourseTypeService;
import com.ict.project.service.QcService;
import com.ict.project.service.TraineeCurrentService;
import com.ict.project.service.TraineeService;
import com.ict.project.service.TrfinalService;
import com.ict.project.service.UploadService;
import com.ict.project.service.WorkplusService;
import com.ict.project.util.FileRenameUtil;
import com.ict.project.util.Paging;
import com.ict.project.vo.BusinessVO;
import com.ict.project.vo.CounselVO;
import com.ict.project.vo.CourseTypeVO;
import com.ict.project.vo.CourseVO;
import com.ict.project.vo.QcVO;
import com.ict.project.vo.TraineeVO;
import com.ict.project.vo.TrainuploadVO;
import com.ict.project.vo.TrfinalVO;
import com.ict.project.vo.WorkplusVO;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class TraineeController {
   @Autowired
   HttpServletRequest request;
   @Autowired
   HttpSession session;
   @Autowired
   ServletContext application;
   @Autowired
   HttpServletResponse response;
   @Autowired
   TraineeCurrentService tc_Service;
   @Autowired
   UploadService u_Service;
   @Autowired
   TraineeService t_Service;
   @Autowired
   ConfirmService cu_Service;
   @Autowired
   CourseService c_Service;
   @Autowired
   CourseTypeService ct_Service;
   @Autowired
   CounselService cc_Service;
   @Autowired
   BusinessService bs_Service;
   @Autowired
   QcService q_Service;
   @Autowired
   TrfinalService tf_Service;
   @Autowired
   WorkplusService w_Service;

   private String editor_img = "/editor_img";
   private String upload_file = "/upload_file";

   /* 과정별 훈련생 현황 메뉴 */
   @RequestMapping("traincurrent")
   public ModelAndView traincurrent(String cPage, String value, String select,
         String year, String num) {
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
      mv.setViewName("jsp/admin/schoolRecord/TraineeCurrent");

      return mv;
   }

   /* 훈련생 확인 서류 등록 메뉴 */
   @RequestMapping("trainupload")
   public ModelAndView trainupload(String cPage) {
      ModelAndView mv = new ModelAndView();
      Paging page = new Paging(5, 5);

      page.setTotalRecord(u_Service.getCount());

      if (cPage == null || cPage.length() == 0)
         page.setNowPage(1);
      else {
         int nowPage = Integer.parseInt(cPage);
         page.setNowPage(nowPage);
      }
      TrainuploadVO[] ar = u_Service.getList(String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));

      mv.addObject("page", page);
      mv.addObject("ar", ar);

      mv.setViewName("jsp/admin/schoolRecord/trainupload");

      return mv;

   }

   /* 훈련생 서류 파일 등록 */
   @RequestMapping("uploadwrite")
   public String requestMethodName(TrainuploadVO tvo, MultipartFile file) {
      String viewPath = null;
      String enc_type = request.getContentType();

      if (enc_type == null)
         viewPath = "jsp/admin/schoolRecord/uploadwrite";
      else if (enc_type.startsWith("multipart")) {
         viewPath = "redirect:trainupload";
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
            tvo.setFile_name(fname);
            tvo.setOri_name(oname);
            int cnt = u_Service.add(tvo);
         } catch (Exception e) {
            e.printStackTrace();
         }

      }

      return viewPath;
   }

   /* 훈련생 확인 서류 수정 */
   @RequestMapping("trainuploadedit")
   public ModelAndView trainuploadedit(TrainuploadVO tvo) {
      ModelAndView mv = new ModelAndView();
      String enc_type = request.getContentType();
      // System.out.println("enc_type:----"+enc_type);
      String viewPath = null;

      if (enc_type != null && enc_type.startsWith("application")) {
         TrainuploadVO vo = u_Service.getUpload(tvo.getTn_idx());// tn_idx
         mv.addObject("vo3", vo);
         viewPath = "jsp/admin/schoolRecord/TrainuploadEdit";

      } else if (enc_type != null && enc_type.startsWith("multipart")) {
         MultipartFile f = tvo.getFile();
         if (f != null && f.getSize() > 0) {
            String realPath = application.getRealPath(upload_file);
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
         tvo.setIp(request.getRemoteAddr());
         int cnt = u_Service.edit(tvo);
         viewPath = ("redirect:trainupload");
      }
      mv.setViewName(viewPath);
      return mv;
   }

   /* 훈련생 확인 서류 삭제 */
   @RequestMapping("trainuploaddel")
   public ModelAndView trainuploaddel(String tn_idx) {
      ModelAndView mv = new ModelAndView();

      int cnt = u_Service.delete(tn_idx);
      mv.setViewName("redirect:trainupload");
      return mv;
   }

   @RequestMapping("trainconfirm")
   public ModelAndView trainconfirm(String cPage, String value, String year, String num, String select) {
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

      mv.setViewName("jsp/admin/schoolRecord/Trainconfirm");
      return mv;
   }

   @RequestMapping("confilmsearch")
   public ModelAndView trainconfirm_ajax(String cPage, String value, String year, String num, String select) {
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

      mv.setViewName("jsp/admin/schoolRecord/traineeConfirm_ajax");
      return mv;
   }

   @RequestMapping("confirm")
   public ModelAndView confirm(String cPage, String c_idx, String tn_idx) {
      ModelAndView mv = new ModelAndView();

      TrainuploadVO[] ar = u_Service.all();

      if (ar != null)
         mv.addObject("ar", ar);

      mv.setViewName("/jsp/admin/schoolRecord/confirm_ajax");
      return mv;
   }

   @RequestMapping("trainuploadview")
   public ModelAndView trainuploadview(String tn_idx) {
      ModelAndView mv = new ModelAndView();

      TrainuploadVO vo = u_Service.view(tn_idx);
      if (vo != null) {
         mv.addObject("vo6", vo);
         mv.setViewName("jsp/admin/schoolRecord/trainuploadview");
      }

      return mv;
   }

   @RequestMapping("traindownload")
   public ResponseEntity<Resource> traindownload(String fname) {
      String realPath = application.getRealPath("/upload_file/" + fname);

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
            response.setHeader("Content-Disposition", "attachment;filename=" + new String(fname.getBytes(), "8859_1"));

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
            } catch (Exception e2) {
               e2.printStackTrace();
            }
         }

      }
      return null;

   }

   @RequestMapping("traineecurrentbt1")
   public ModelAndView traineecurrentbt1(String cPage, String c_idx) {
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
      mv.setViewName("jsp/admin/schoolRecord/traineecurrentbt1");
      return mv;
   }

   @RequestMapping("counseling")
   public ModelAndView counseling(String tr_idx, String c_idx, String so_idx) {
      ModelAndView mv = new ModelAndView();
      TraineeVO vo = t_Service.view(tr_idx);
      CourseVO cvo = c_Service.getCourse(c_idx);
      CounselVO[] ccvo = cc_Service.counselList(tr_idx);

      if (ccvo != null)
         mv.addObject("ss_num", ccvo.length);
      mv.addObject("ccvo", ccvo);
      mv.addObject("vo11", vo);
      mv.addObject("cv", cvo);
      mv.setViewName("jsp/admin/schoolRecord/traineeCounseling");

      return mv;
   }

   @RequestMapping("tcsearch")
   public ModelAndView tcsearch(String cPage, String value, String select, String year, String num) {

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
      mv.setViewName("jsp/admin/schoolRecord/TraineeCurrent_ajax");
      return mv;
   }

   @RequestMapping("trainee_name")
   public ModelAndView trainee_name(String select, String value) {
      ModelAndView mv = new ModelAndView();
      Paging page = new Paging(20, 5);
      if (value == null || value.trim().length() < 1)
         select = null;
      else
         select = "4";
      page.setTotalRecord(t_Service.getCourseSearchCount(select, value, null));
      page.setNowPage(1);

      TraineeVO[] ar = t_Service.getCourseTraineeSearchList(select, value, null, String.valueOf(page.getBegin()),
            String.valueOf(page.getEnd()));
      mv.addObject("page", page);
      mv.addObject("ar", ar);

      mv.setViewName("jsp/admin/schoolRecord/trainee_search");
      return mv;
   }

   @RequestMapping("traineeEdit")
   public ModelAndView traineeEdit(TraineeVO tvo, String tr_idx, String c_idx, String cPage, String edit) {
      ModelAndView mv = new ModelAndView();
      String enc_type = request.getContentType();
      String viewPath = null;

      if (edit == null && enc_type == null) {
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
         viewPath = "jsp/admin/schoolRecord/traineeEdit";
      } else if (enc_type != null && enc_type.startsWith("multipart")) {
         String[] ab = tvo.getTr_rrn().split(",");
         tvo.setTr_rrn(ab[0] + "-" + ab[1]);
         String[] ab2 = tvo.getTr_phone().split(",");
         tvo.setTr_phone(ab2[0] + "-" + ab2[1] + "-" + ab2[2]);
         String[] ab3 = tvo.getTr_hp().split(",");
         tvo.setTr_hp(ab3[0] + "-" + ab3[1] + "-" + ab3[2]);

         MultipartFile f = tvo.getFile();
         if (f != null && f.getSize() > 0) {

            String realPath = application.getRealPath(upload_file);
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
         viewPath = ("redirect:traineecurrentbt1?c_idx=" + c_idx);
      }
      mv.setViewName(viewPath);
      return mv;
   }

   @RequestMapping("traineewrite")
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
      mv.setViewName("jsp/admin/schoolRecord/Traineewrite");
      return mv;
   }

   @PostMapping("cudel")
   public ModelAndView cudel(String[] chk, String c_idx) {
      ModelAndView mv = new ModelAndView();
      int cnt = 0;

      for (String tr_idx : chk) {
         cnt += t_Service.delete(tr_idx, c_idx);
      }

      mv.setViewName("redirect:traineecurrentbt1?c_idx=" + c_idx);
      return mv;
   }

   @RequestMapping("alledit")
   public ModelAndView alledit(String c_idx, String cPage, String[] chk, String[] nowstatus, String[] tr_idx) {
      ModelAndView mv = new ModelAndView();

      int cnt = 0;
      for (String e : chk) {
         for (int i = 0; i < tr_idx.length; i++) {
            if (tr_idx[i].equals(e))
               cnt += t_Service.status(e, nowstatus[i]);
         }
      }
      mv.setViewName("redirect:traineecurrentbt1?c_idx=" + c_idx);

      return mv;
   }

   @RequestMapping("couupload")
   public ModelAndView couupload(String tr_idx, String c_idx, String ss_num, String so_idx) {
      ModelAndView mv = new ModelAndView();

      CounselVO cvo = cc_Service.getCounsel(so_idx);
      CourseVO vvo = c_Service.getCourse(c_idx);
      // System.out.println(ss_num);
      mv.addObject("vvo", vvo);
      mv.addObject("tr_idx", tr_idx);
      mv.addObject("c_idx", c_idx);
      mv.addObject("ss_num", ss_num);
      mv.addObject("cvo", cvo);
      mv.setViewName("jsp/admin/schoolRecord/counseling_ajax");

      return mv;

   }

   @RequestMapping("counseling_ajax")
   public ModelAndView counseling_ajax(CounselVO ccvo, String ss_num) {
      ModelAndView mv = new ModelAndView();

      if (ccvo.getSo_day() != null && ccvo.getSo_day().trim().length() > 1) {
         t_Service.setCounsel_date(ccvo.getTr_idx(), ccvo.getSo_day(), ss_num);
         cc_Service.addCounsel(ccvo);
      }

      mv.setViewName("redirect:traineecurrentbt1?c_idx=" + ccvo.getC_idx());
      return mv;
   }

   @RequestMapping("Traineewrite_ajax")
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
      mv.setViewName("redirect:traineecurrentbt1?c_idx=" + c_idx);
      return mv;
   }

   @RequestMapping("mangecard")
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
      if (qvo != null)
         mv.addObject("length", qvo.length);
      else
         mv.addObject("length", 0);
      mv.addObject("tfvo", tfvo);
      mv.addObject("tr_idx", tr_idx);
      mv.addObject("c_idx", c_idx);
      mv.addObject("cvo2", cvo);
      mv.addObject("vo15", vo);

      mv.setViewName("jsp/admin/schoolRecord/afterManageCard");

      return mv;

   }

   @RequestMapping("afterManage_axaj")
   public ModelAndView afterManage_axaj(String[] wp_skill, String[] wp_area, String tr_idx, String c_idx,
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
            sb.deleteCharAt(sb.length() - 1);
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
         mv.setViewName("redirect:jobsituation?c_idx=" + c_idx);
      } else {

         mv.setViewName("redirect:traineecurrentbt1?c_idx=" + c_idx);
      }
      return mv;
   }

   @RequestMapping("confirmAdd")
   public ModelAndView confirmAdd(String c_idx, String cPage, String chk) {
      ModelAndView mv = new ModelAndView();

      int cnt = c_Service.tnadd(chk, c_idx);
      ;

      mv.setViewName("redirect:trainconfirm");

      return mv;

   }

}