package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.TestMapper;
import com.ict.project.vo.CourseTypeVO;
import com.ict.project.vo.CourseVO;
import com.ict.project.vo.MemberVO;
import com.ict.project.vo.QnaVO;
import com.ict.project.vo.StaffVO;
import com.ict.project.vo.TraineeVO;
import com.ict.project.vo.TrainingBookVO;
import com.ict.project.vo.AskcounselingVO;
import com.ict.project.vo.CommVO;

@Service
public class TestService {
    @Autowired
    private TestMapper t_Mapper;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public MemberVO login(String m_id, String m_pw) {
        MemberVO vo = t_Mapper.login(m_id);

        // 암호화된 비밀번호와 입력받은 비밀번호와 같은지 비교
        if (vo != null) {
            if (passwordEncoder.matches(m_pw, vo.getM_pw())) {
                return vo;
            }
        }

        return null;
    }

    public CourseTypeVO[] getCtList() {
        CourseTypeVO[] ar = null;

        List<CourseTypeVO> list = t_Mapper.getCtList();
        if (list != null && !list.isEmpty()) {
            ar = new CourseTypeVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    public StaffVO[] getSfList() {
        StaffVO[] ar = null;

        List<StaffVO> list = t_Mapper.getSfList();
        if (list != null && !list.isEmpty()) {
            ar = new StaffVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    public QnaVO[] qnaall() {
        QnaVO[] ar = null;
        List<QnaVO> list = t_Mapper.qnaall();
        if (list != null && !list.isEmpty()) {
            ar = new QnaVO[list.size()];
            list.toArray(ar);
        }
        return ar;
    }

    public CourseVO[] ctList(String ct_idx) {
        CourseVO[] ar = null;

        List<CourseVO> list = t_Mapper.ctList(ct_idx);
        if (list != null && !list.isEmpty()) {
            ar = new CourseVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    public CourseVO[] searchCourse(String c_name, String ct_idx) {
        CourseVO[] ar = null;

        List<CourseVO> list = t_Mapper.searchCourse(c_name, ct_idx);
        if (list != null && !list.isEmpty()) {
            ar = new CourseVO[list.size()];
            list.toArray(ar);
        }
        return ar;
    }

    public int addAsk(AskcounselingVO vo) {
        return t_Mapper.addAsk(vo);
    }

    public int regMember(MemberVO vo) {
        MemberVO mvo = new MemberVO();
        mvo.setM_id(vo.getM_id());
        mvo.setM_email(vo.getM_email());
        mvo.setM_name(vo.getM_name());
        mvo.setM_phone(vo.getM_phone());

        mvo.setM_pw(passwordEncoder.encode(vo.getM_pw()));

        return t_Mapper.regMember(mvo);
    }

    public int checkSameId(String m_id) {
        return t_Mapper.checkSameId(m_id);
    }

    public int checkSameEmail(String m_email) {
        return t_Mapper.checkSameEmail(m_email);
    }

    public CourseVO[] myCourse(String m_id) {
        CourseVO[] ar = null;
        List<CourseVO> list = t_Mapper.myCourse(m_id);
        if (list != null && !list.isEmpty()) {
            ar = new CourseVO[list.size()];
            list.toArray(ar);
        }
        return ar;
    }

    public MemberVO checkSamePw(String m_id, String m_pw) {
        // 전달받은 id로 vo객체를 얻어낸다.
        MemberVO vo = t_Mapper.login(m_id);

        // 얻어낸 vo가 있다면, passwordEncoder를 이용해 pw를 비교한다
        if (vo != null) {
            if (passwordEncoder.matches(m_pw, vo.getM_pw())) {
                return vo;
            }
        }
        return null;
    }

    public MemberVO[] getMember(String m_id) {
        return t_Mapper.getMember(m_id);
    }

    public int editMyInfo(MemberVO vo) {
        MemberVO mvo = new MemberVO();
        mvo.setM_id(vo.getM_id());
        mvo.setM_email(vo.getM_email());
        mvo.setM_name(vo.getM_name());
        mvo.setM_phone(vo.getM_phone());
        mvo.setM_addr(vo.getM_addr());

        mvo.setM_pw(passwordEncoder.encode(vo.getM_pw()));

        return t_Mapper.editMyInfo(mvo);
    }

    public int editTrainee(TraineeVO tvo) {
        return t_Mapper.editTrainee(tvo);
    }

    public CourseVO[] getCourseVO(String c_idx) {
        return t_Mapper.getCourseVO(c_idx);
    }

    public int enrollCourse(TraineeVO vo) {
        return t_Mapper.enrollCourse(vo);
    }

    public TraineeVO getTraineeVO(String tr_phone) {
        return t_Mapper.getTraineeVO(tr_phone);
    }

    public int updateTrIdx(String m_id, String tr_idx) {
        return t_Mapper.updateTrIdx(m_id, tr_idx);
    }

    public TrainingBookVO[] trBookList(String c_idx) {
        TrainingBookVO[] ar = null;
        List<TrainingBookVO> list = t_Mapper.trBookList(c_idx);
        if (list != null && !list.isEmpty()) {
            ar = new TrainingBookVO[list.size()];
            list.toArray(ar);
        }
        return ar;
    }

    public int askcounseling(AskcounselingVO vo) {

        return t_Mapper.addaskcounseling(vo);
    }

    public int qnawrite(QnaVO vo) {
        return t_Mapper.qnawrite(vo);
    }

    public MemberVO[] getmember(String m_id) {
        MemberVO[] ar = null;
        List<MemberVO> list = t_Mapper.getmember(m_id);
        if (list != null && !list.isEmpty()) {
            ar = new MemberVO[list.size()];
            list.toArray(ar);
        }
        return ar;
    }

    public int count(String qname) {
        return t_Mapper.count(qname);
    }

    public QnaVO[] getList(String qname, String begin, String end) {
        QnaVO[] ar = null;

        List<QnaVO> list = t_Mapper.qnalist(qname, begin, end);

        if (list != null && !list.isEmpty()) {
            ar = new QnaVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    // 기본키로 검색하는 기능
    public QnaVO getqna(String qna_idx) {
        return t_Mapper.getqna(qna_idx);
    }

    // 게시물 추가
    public int addqna(QnaVO vo) {
        return t_Mapper.addqna(vo);
    }

    public int addComm(CommVO vo) {
        return t_Mapper.addComm(vo);
    }

    public int del(String qna_idx) {
        return t_Mapper.del(qna_idx);
    }

    public int edit(QnaVO vo) {
        return t_Mapper.edit(vo);
    }

    public CommVO[] cList(String qna_idx) {
        CommVO[] ar = null;

        List<CommVO> list = t_Mapper.commList(qna_idx);
        if (list != null && !list.isEmpty()) {
            ar = new CommVO[list.size()];
            list.toArray(ar);
        }
        return ar;
    }

    public MemberVO checkEmail(String m_email) {
        return t_Mapper.checkEmail(m_email);
    }

}
