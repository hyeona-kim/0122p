package com.ict.project.control;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.CheckExamFileService;
import com.ict.project.service.CourseService;
import com.ict.project.service.EvaluationStatusService;
import com.ict.project.service.GradeCheckService;
import com.ict.project.service.QuestionService;
import com.ict.project.service.StaffService;
import com.ict.project.service.SubjectService;
import com.ict.project.service.TraineeService;
import com.ict.project.service.TrainingDiaryService;
import com.ict.project.util.FileRenameUtil;
import com.ict.project.util.Paging;
import com.ict.project.vo.CheckExamFileVO;
import com.ict.project.vo.CourseVO;
import com.ict.project.vo.EvaluationStatusVO;
import com.ict.project.vo.FileVO;
import com.ict.project.vo.QuestionVO;
import com.ict.project.vo.StaffVO;
import com.ict.project.vo.SubjectVO;
import com.ict.project.vo.TraineeVO;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class EvaluationManageController {

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
    SubjectService s_Service;
    @Autowired
    TrainingDiaryService td_Service;
    @Autowired
    EvaluationStatusService es_Service;
    @Autowired
    StaffService sf_Service;
    @Autowired
    QuestionService qt_Service;
    @Autowired
    GradeCheckService gc_Service;
    @Autowired
    TraineeService tr_Service;
    @Autowired
    CheckExamFileService cef_Service;

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
            mv.setViewName("/jsp/admin/evaluationManage/traineeseveralty");
        } else if (listSelect.equals("5")) {
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
        System.out.println(listSelect + "/");
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
            StaffVO svo = (StaffVO) session.getAttribute("vo");
            CourseVO[] c_ar = c_Service.staffCourse(svo.getSf_idx(), String.valueOf(page.getBegin()),
                    String.valueOf(page.getEnd()));
            page.setTotalRecord(c_Service.staffCourse_count(svo.getSf_idx()));
            System.out.println(page.getTotalRecord());
            System.out.println(svo.getSf_idx());
            System.out.println(c_Service.staffCourse_count(svo.getSf_idx()));
            mv.addObject("c_ar", c_ar);
            mv.addObject("page2", page);
            mv.setViewName("/jsp/admin/evaluationManage/traineetotaltest_ajax");
        } else if (listSelect.equals("4")) {
            mv.setViewName("/jsp/admin/evaluationManage/traineeseveralty_ajax");
        } else if (listSelect.equals("5")) {
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
    public ModelAndView diary(String listSelect, String num, String cPage, String c_idx, String s_idx) {
        ModelAndView mv = new ModelAndView();

        if (num == null || num.trim().length() < 1 || num.equals("표시개수"))
            num = null;
        if (cPage == null)
            cPage = "1";

        SubjectVO[] s_ar = s_Service.getList(Integer.parseInt(c_idx));
        mv.addObject("s_ar", s_ar);

        mv.setViewName("/jsp/admin/evaluationManage/subjectStatus_ajax");
        return mv;
    }

    @RequestMapping("evaluationInfo")
    public ModelAndView evaluationInfo(String s_idx) {
        ModelAndView mv = new ModelAndView();

        SubjectVO svo = s_Service.list2(s_idx);
        mv.addObject("svo", svo);

        mv.setViewName("/jsp/admin/evaluationManage/evaluationInfo");
        return mv;
    }

    @RequestMapping("examEvaluation")
    public ModelAndView examEvaluation(String s_idx) {
        ModelAndView mv = new ModelAndView();

        SubjectVO svo = s_Service.list2(s_idx);
        mv.addObject("svo", svo);

        mv.setViewName("/jsp/admin/evaluationManage/examEvaluation");
        return mv;
    }

    @RequestMapping("examInput")
    public ModelAndView examInput(String s_idx) {
        ModelAndView mv = new ModelAndView();

        SubjectVO svo = s_Service.list2(s_idx);
        mv.addObject("svo", svo);

        mv.setViewName("/jsp/admin/evaluationManage/examInput");
        return mv;
    }

    @RequestMapping("diary_ajax3")
    public ModelAndView diary_ajax3(String listSelect, String num, String cPage, String s_idx, String c_idx) {
        ModelAndView mv = new ModelAndView();

        if (num == null || num.trim().length() < 1 || num.equals("표시개수"))
            num = null;
        if (cPage == null)
            cPage = "1";

        EvaluationStatusVO[] es_ar = es_Service.list(s_idx);
        mv.addObject("es_ar", es_ar);

        if (listSelect.equals("1"))
            mv.setViewName("/jsp/admin/evaluationManage/evaluationInfo_ajax");
        else if (listSelect.equals("2"))
            mv.setViewName("/jsp/admin/evaluationManage/examInput_ajax");
        else if (listSelect.equals("3")) {
            SubjectVO[] s_ar = s_Service.getList(Integer.parseInt(c_idx));
            mv.addObject("s_ar", s_ar);
            mv.setViewName("/jsp/admin/evaluationManage/scoreResult_ajax");
        } else if (listSelect.equals("4"))
            mv.setViewName("/jsp/admin/evaluationManage/examEvaluation_ajax");
        return mv;
    }

    @RequestMapping("delEvaluationStatus")
    public String delEvaluationStatus(String es_idx, String s_idx) {
        int cnt = es_Service.del(es_idx);

        return "redirect:evaluationInfo?s_idx=" + s_idx;
    }

    @RequestMapping("es_dialog")
    public ModelAndView es_dialog(String es_idx, String s_idx) {
        ModelAndView mv = new ModelAndView();

        SubjectVO svo = s_Service.list2(s_idx);
        mv.addObject("svo", svo);

        if (es_idx == null || es_idx.trim().length() < 1) {
            mv.setViewName("/jsp/admin/evaluationManage/addEvaluationInfo_ajax");
        } else {
            EvaluationStatusVO esvo = es_Service.getone(es_idx);
            StaffVO sfvo = sf_Service.getStaff(esvo.getSf_idx());
            if (esvo.getEs_type().equals("2")) {
                String[] str = esvo.getEs_num_question().split("/");
                mv.addObject("q1", str[0]);
                mv.addObject("q2", str[1]);
            }
            mv.addObject("esvo", esvo);
            mv.addObject("sfvo", sfvo);
            mv.setViewName("/jsp/admin/evaluationManage/editEvaluationInfo_ajax");
        }

        return mv;
    }

    @RequestMapping("addEvaluationStatus")
    public String addCounselingDetail(EvaluationStatusVO esvo) {
        es_Service.add(esvo);

        return "redirect:evaluationInfo?s_idx=" + esvo.getS_idx();
    }

    @RequestMapping("editEvaluationStatus")
    public String editEvaluationStatus(EvaluationStatusVO esvo) {
        es_Service.edit(esvo);

        return "redirect:evaluationInfo?s_idx=" + esvo.getS_idx();
    }

    @RequestMapping("es_dialog2")
    public ModelAndView es_dialog2(String listSelect, String es_idx, String s_idx) {
        ModelAndView mv = new ModelAndView();

        SubjectVO svo = s_Service.list2(s_idx);
        mv.addObject("svo", svo);
        EvaluationStatusVO esvo = es_Service.getone(es_idx);
        mv.addObject("esvo", esvo);

        if (listSelect.equals("1"))
            mv.setViewName("/jsp/admin/evaluationManage/addEvidence_ajax");
        else if (listSelect.equals("2")) {
            QuestionVO[] qt_ar = qt_Service.list(es_idx);
            if (esvo.getEs_type().equals("2")) {

                String[] n = esvo.getEs_num_question().split("/");
                mv.addObject("n1", n[0]);
                mv.addObject("n2", n[1]);
                for (int i = 0; i < Integer.parseInt(n[0]); i++) {
                    String[] select = new String[qt_ar[i].getQt_select().length()];
                    select = qt_ar[i].getQt_select().split("│");
                    mv.addObject("select" + i, select);
                }
            }
            mv.addObject("qt_ar", qt_ar);
            mv.setViewName("/jsp/admin/evaluationManage/viewExam_ajax");
        } else if (listSelect.equals("3")) {
            if (esvo.getEs_type().equals("2")) {
                String[] n = esvo.getEs_num_question().split("/");
                mv.addObject("n1", n[0]);
                mv.addObject("n2", n[1]);
            }
            mv.setViewName("/jsp/admin/evaluationManage/examFill_ajax");
        } else if (listSelect.equals("4")) {
            mv.setViewName("/jsp/admin/evaluationManage/checkExam_ajax");
        } else if (listSelect.equals("5")) {
            if (esvo.getEs_type().equals("2")) {
                String[] n = esvo.getEs_num_question().split("/");
                mv.addObject("n1", n[0]);
                mv.addObject("n2", n[1]);
                for (int i = 0; i < Integer.parseInt(n[0]); i++) {
                    String[] select = new String[esvo.getQt_ar()[i].getQt_select().length()];
                    select = esvo.getQt_ar()[i].getQt_select().split("│");
                    mv.addObject("select" + i, select);
                }

            }
            mv.setViewName("/jsp/admin/evaluationManage/editExam_ajax");
        }
        return mv;
    }

    @RequestMapping("gradeManage")
    public ModelAndView gradeManage(String s_idx) {
        ModelAndView mv = new ModelAndView();

        SubjectVO svo = s_Service.list2(s_idx);
        mv.addObject("svo", svo);

        mv.setViewName("/jsp/admin/evaluationManage/gradeManage");
        return mv;
    }

    @RequestMapping("grade_ajax")
    public ModelAndView grade_ajax(String s_idx) {
        ModelAndView mv = new ModelAndView();

        EvaluationStatusVO[] es_ar = es_Service.list(s_idx);
        SubjectVO svo = s_Service.list2(s_idx);

        mv.addObject("svo", svo);
        mv.addObject("es_ar", es_ar);
        mv.setViewName("/jsp/admin/evaluationManage/gradeManage_ajax");
        return mv;
    }

    @RequestMapping("TraineeScoreList")
    public ModelAndView TraineeScoreList(String s_idx, String es_idx) {
        ModelAndView mv = new ModelAndView();

        EvaluationStatusVO esvo = es_Service.getone(es_idx);
        SubjectVO svo = s_Service.list2(s_idx);
        StaffVO sfvo = sf_Service.getStaff(esvo.getSf_idx());

        mv.addObject("svo", svo);
        mv.addObject("esvo", esvo);
        mv.addObject("sfvo", sfvo);
        mv.setViewName("/jsp/admin/evaluationManage/traineeScoreList");
        return mv;

    }

    @RequestMapping("chcekTraineeScoreList")
    public ModelAndView chcekTraineeScoreList(String s_idx, String es_idx) {
        ModelAndView mv = new ModelAndView();

        EvaluationStatusVO esvo = es_Service.getone(es_idx);
        SubjectVO svo = s_Service.list2(s_idx);
        StaffVO sfvo = sf_Service.getStaff(esvo.getSf_idx());

        mv.addObject("svo", svo);
        mv.addObject("esvo", esvo);
        mv.addObject("sfvo", sfvo);
        mv.setViewName("/jsp/admin/evaluationManage/chcekTraineeScoreList");
        return mv;

    }

    @RequestMapping("list_ajax")
    public ModelAndView list_ajax(String c_idx, String es_idx, String listSelect) {
        ModelAndView mv = new ModelAndView();

        TraineeVO[] tr_ar = tr_Service.clist(c_idx, null, null);
        if (tr_ar != null) {

            Integer[] totalScore = new Integer[tr_ar.length];
            for (int i = 0; i < tr_ar.length; i++) {
                tr_ar[i].setGc_ar(gc_Service.list(es_idx, tr_ar[i].getTr_idx()));
                totalScore[i] = gc_Service.all_grade(es_idx, tr_ar[i].getTr_idx());
            }

            mv.addObject("tr_ar", tr_ar);
            mv.addObject("totalScore", totalScore);
        }
        if (listSelect.equals("1"))
            mv.setViewName("/jsp/admin/evaluationManage/traineeScoreList_ajax");
        else if (listSelect.equals("2"))
            mv.setViewName("/jsp/admin/evaluationManage/chcekTraineeScoreList_ajax");
        return mv;

    }

    @RequestMapping("checkExam_file")
    public ModelAndView course_file(CheckExamFileVO cefvo) {
        ModelAndView mv = new ModelAndView();
        String encType = request.getContentType();

        if (encType.startsWith("application")) {
            EvaluationStatusVO esvo = es_Service.getone(cefvo.getEs_idx());
            CheckExamFileVO ar = cef_Service.getFile2(cefvo.getEs_idx());
            mv.addObject("fvo2", ar);
            mv.addObject("esvo", esvo);
            mv.setViewName("/jsp/admin/evaluationManage/checkExam_ajax");
        } else if (encType.startsWith("multipart")) {
            String realPath = application.getRealPath("upload_courseFile");
            String es_idx = cefvo.getEs_idx();

            MultipartFile[] f_ar = new MultipartFile[1];
            f_ar[0] = cefvo.getFile1();

            if (cefvo.getCef_idx() == null || cefvo.getCef_idx().length() == 5) {
                // 파일이 존재하지 않는 경우

                String fname = FileRenameUtil.checkSameFileName(f_ar[0].getOriginalFilename(), realPath);

                try {
                    f_ar[0].transferTo(new File(realPath, fname));// 파일 업로드
                } catch (Exception e) {
                    e.printStackTrace();
                }
                cefvo.setCef_name(fname);

                cef_Service.addFile(cefvo);
                // fvo가 이전의 파일명을 가지고 또 저장하기때문에 중복되는걸 막고자 fvo를 초기화 한다.
                cefvo = new CheckExamFileVO();
                cefvo.setEs_idx(es_idx);

            } else {
                // 파일 존재
                String[] f_idx = cefvo.getCef_idx().split(",");

                if (f_ar[0].getSize() > 0) {
                    String fname = FileRenameUtil.checkSameFileName(f_ar[0].getOriginalFilename(), realPath);
                    try {
                        f_ar[0].transferTo(new File(realPath, fname)); // 파일 업로드
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    cefvo.setCef_idx(f_idx[0]);
                    cefvo.setCef_name(fname);
                    cef_Service.editFile(cefvo);
                }

            }
            mv.setViewName("redirect:evaluationInfo?listselect=2");

        }
        return mv;
    }

    @RequestMapping("checkExam_fileDown")
    public String checkExam_fileDown(CheckExamFileVO fvo) {
        String filename = fvo.getCef_name();
        String realPath = request.getServletContext().getRealPath("upload_courseFile");
        // System.out.println(realPath);
        String fullPath = realPath + System.getProperty("file.separator") + filename;

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
                        "attachment;filename=" + new String(filename.getBytes(), "8859_1"));
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

    @RequestMapping("grading")
    public ModelAndView grading(String tr_idx, String es_idx) {
        ModelAndView mv = new ModelAndView();

        return mv;
    }

    @RequestMapping("addExam")
    public ModelAndView addExam(String[] sk_idx, String[] qt_name, String[] qt_content, String[] qt_select,
            String[] qt_correct, String[] qt_type, String[] qt_score, String es_idx, String s_idx) {
        ModelAndView mv = new ModelAndView();
        QuestionVO qvo = new QuestionVO();
        for (int i = 0; i < qt_name.length; i++) {
            if (qt_type[i].equals("0")) {
                qvo.setQt_select(qt_select[i]);
            } else {
                qvo.setQt_select(null);
            }
            qvo.setEs_idx(es_idx);
            qvo.setQt_name(qt_name[i]);
            qvo.setQt_content(qt_content[i]);
            qvo.setQt_correct(qt_correct[i]);
            qvo.setQt_type(qt_type[i]);
            qvo.setQt_score(qt_score[i]);
            qt_Service.add(qvo);
        }
        EvaluationStatusVO esvo = new EvaluationStatusVO();
        esvo.setEs_idx(es_idx);
        esvo.setEs_examStatus("출제완료");
        es_Service.edit(esvo);
        mv.setViewName("redirect:examInput?s_idx=" + s_idx);
        return mv;
    }

    @RequestMapping("scoreResult")
    public ModelAndView scoreResult(String c_idx) {
        ModelAndView mv = new ModelAndView();
        CourseVO cvo = c_Service.getCourse2(c_idx);
        mv.addObject("cvo", cvo);
        mv.setViewName("/jsp/admin/evaluationManage/scoreResult");

        return mv;
    }

    @RequestMapping("editExam")
    public ModelAndView editExam(String[] qt_idx, String[] sk_idx, String[] qt_name, String[] qt_content,
            String[] qt_select,
            String[] qt_correct, String[] qt_type, String[] qt_score, String es_idx, String s_idx) {
        ModelAndView mv = new ModelAndView();
        QuestionVO qvo = new QuestionVO();
        for (int i = 0; i < qt_name.length; i++) {
            if (qt_type[i].equals("0")) {
                qvo.setQt_select(qt_select[i]);
            } else {
                qvo.setQt_select(null);
            }
            qvo.setQt_idx(qt_idx[i]);
            qvo.setEs_idx(es_idx);
            qvo.setQt_name(qt_name[i]);
            qvo.setQt_content(qt_content[i]);
            qvo.setQt_correct(qt_correct[i]);
            qvo.setQt_type(qt_type[i]);
            qvo.setQt_score(qt_score[i]);
            qt_Service.edit(qvo);
        }
        mv.setViewName("redirect:examInput?s_idx=" + s_idx);
        return mv;
    }
}
