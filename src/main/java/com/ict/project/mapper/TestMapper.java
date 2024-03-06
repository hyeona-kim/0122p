package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.CourseTypeVO;
import com.ict.project.vo.CourseVO;
import com.ict.project.vo.MemberVO;
import com.ict.project.vo.StaffVO;
import com.ict.project.vo.TraineeVO;
import com.ict.project.vo.TrainingBookVO;
import com.ict.project.vo.AskcounselingVO;

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

    int qnawrite(MemberVO vo);

    List<MemberVO> getmember(String m_id);
}
