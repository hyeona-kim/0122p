package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.CourseTypeVO;
import com.ict.project.vo.CourseVO;
import com.ict.project.vo.EvaluationStatusVO;
import com.ict.project.vo.MemberVO;
import com.ict.project.vo.QnaVO;
import com.ict.project.vo.QuestionVO;
import com.ict.project.vo.StaffVO;
import com.ict.project.vo.SubjectVO;
import com.ict.project.vo.TraineeVO;
import com.ict.project.vo.TrainingBookVO;
import com.ict.project.vo.WorkplusVO;
import com.ict.project.vo.AskcounselingVO;
import com.ict.project.vo.CommVO;

public interface TestMapper {
    MemberVO login(String m_id);

    List<CourseTypeVO> getCtList();

    List<StaffVO> getSfList();

    List<CourseVO> ctList(String ct_idx);

    List<CourseVO> searchCourse(String c_name, String ct_idx);

    int addAsk(AskcounselingVO vo);

    int regMember(MemberVO vo);

    int checkSameId(String m_id);

    int checkSameEmail(String m_email);

    List<CourseVO> myCourse(String m_id);

    int editMyInfo(MemberVO vo);

    int editTrainee(TraineeVO tvo);

    MemberVO[] getMember(String m_id);

    CourseVO[] getCourseVO(String c_idx);

    int enrollCourse(TraineeVO vo);

    TraineeVO getTraineeVO(String tr_phone);

    int updateTrIdx(String m_id, String tr_idx);

    List<TrainingBookVO> trBookList(String c_idx);

    MemberVO checkEmail(String m_email);

    int addaskcounseling(AskcounselingVO vo);

    int qnawrite(QnaVO vo);

    List<MemberVO> getmember(String m_id);

    List<QnaVO> qnaall();
    //
    int count(String qname);

    List<QnaVO> qnalist(String qname, String begin, String end);

    List<CommVO> commList(String qna_idx);

    int addqna(QnaVO vo);

    QnaVO getqna(String qna_idx);

    int addComm(CommVO vo);

    int edit(QnaVO vo);

    int del(String qna_idx);


    List<TraineeVO> tr_name();

    List<WorkplusVO> afterlist();
  
    List<SubjectVO> mySubject(String c_idx);

    List<QuestionVO> myExam(String s_idx);

    int countMyExam(String c_idx);

    List<AskcounselingVO> myReply(String m_id);

    List<AskcounselingVO> getReply(String ac_idx);

}
