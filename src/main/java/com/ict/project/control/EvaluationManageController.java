package com.ict.project.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.CourseService;
import com.ict.project.service.EvaluationStatusService;
import com.ict.project.service.GradeCheckService;
import com.ict.project.service.QuestionService;
import com.ict.project.service.StaffService;
import com.ict.project.service.SubjectService;
import com.ict.project.service.TraineeService;
import com.ict.project.service.TrainingDiaryService;
import com.ict.project.util.Paging;
import com.ict.project.vo.CounselingdetailVO;
import com.ict.project.vo.CourseTypeVO;
import com.ict.project.vo.CourseVO;
import com.ict.project.vo.EvaluationStatusVO;
import com.ict.project.vo.GradeCheckVO;
import com.ict.project.vo.RoomVO;

import com.ict.project.vo.QuestionVO;

import com.ict.project.vo.StaffVO;
import com.ict.project.vo.SubjectVO;
import com.ict.project.vo.TraineeVO;
import com.ict.project.vo.TrainingDiaryVO;

import ch.qos.logback.core.model.Model;

import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class EvaluationManageController {

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

    @RequestMapping("examInput")
    public ModelAndView examInput(String s_idx) {
        ModelAndView mv = new ModelAndView();

        SubjectVO svo = s_Service.list2(s_idx);
        mv.addObject("svo", svo);

        mv.setViewName("/jsp/admin/evaluationManage/examInput");
        return mv;
    }

    @RequestMapping("diary_ajax3")
    public ModelAndView diary_ajax3(String listSelect, String num, String cPage, String s_idx) {
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
    public ModelAndView c_dialog(String listSelect, String es_idx, String s_idx) {
        ModelAndView mv = new ModelAndView();

        SubjectVO svo = s_Service.list2(s_idx);
        mv.addObject("svo", svo);
        EvaluationStatusVO esvo = es_Service.getone(es_idx);
        mv.addObject("esvo", esvo);

        
        if (listSelect.equals("1"))
            mv.setViewName("/jsp/admin/evaluationManage/addEvidence_ajax");
        else if (listSelect.equals("2")){
            QuestionVO[] qt_ar = qt_Service.list(es_idx);
            String[] n = esvo.getEs_num_question().split("/");
            mv.addObject("n1", n[0]);
            mv.addObject("n2", n[1]);
            String[] select = new String[n[0].length()];
            for(int i = 0; i < Integer.parseInt(n[0]); i++){
                select = qt_ar[i].getQt_select().split("│");
                mv.addObject("select"+i, select);
            }
            mv.addObject("qt_ar", qt_ar);
            mv.setViewName("/jsp/admin/evaluationManage/viewExam_ajax");
        }
        else if (listSelect.equals("3")){
            if(esvo.getEs_type().equals("2")){
                String[] n = esvo.getEs_num_question().split("/");
                mv.addObject("n1", n[0]);
                mv.addObject("n2", n[1]);
            }  
            mv.setViewName("/jsp/admin/evaluationManage/examFill_ajax");
        }
        return mv;
    }

    @RequestMapping("gradeManage")
    public ModelAndView gradeManage(String s_idx) {
        ModelAndView mv = new ModelAndView();

        EvaluationStatusVO[] es_ar = es_Service.list(s_idx);

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

    @RequestMapping("list_ajax")
    public ModelAndView list_ajax(String c_idx, String es_idx) {
        ModelAndView mv = new ModelAndView();

        System.out.println(es_idx + "/");
        TraineeVO[] tr_ar = tr_Service.clist(c_idx, null, null);
        if (tr_ar != null) {

            int[] totalScore = new int[tr_ar.length];
            for (int i = 0; i < tr_ar.length; i++) {
                tr_ar[i].setGc_ar(gc_Service.list(tr_ar[i].getTr_idx()));
                totalScore[i] = gc_Service.all_grade(es_idx, tr_ar[i].getTr_idx());
            }

            mv.addObject("tr_ar", tr_ar);
            mv.addObject("totalScore", totalScore);
        }
        mv.setViewName("/jsp/admin/evaluationManage/traineeScoreList_ajax");
        return mv;

    }

    @RequestMapping("grading")
    public ModelAndView grading(String tr_idx, String es_idx){
        ModelAndView mv = new ModelAndView();



        return mv;
    }

    @RequestMapping("addExam")
    public ModelAndView requestMethodName(String[] sk_idx, String[] qt_name, String[] qt_content, String[] qt_select, String[] qt_correct, String[] qt_type, String[] qt_score, String es_idx, String s_idx ) {
        ModelAndView mv = new ModelAndView();
        QuestionVO qvo = new QuestionVO();
        for(int i = 0; i < qt_name.length; i++){
            if(qt_type[i].equals("0")){
                qvo.setQt_select(qt_select[i]);
                System.out.println(qt_select[i]);
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
        mv.setViewName("redirect:examInput?s_idx="+s_idx);
        return mv;
    }
    

}
