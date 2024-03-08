package com.ict.project.control.front;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.TestService;
import com.ict.project.util.Paging2;
import com.ict.project.vo.CourseTypeVO;
import com.ict.project.vo.CourseVO;
import com.ict.project.vo.MemberVO;
import com.ict.project.vo.QnaVO;
import com.ict.project.vo.StaffVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import com.ict.project.vo.AskcounselingVO;
import com.ict.project.vo.CommVO;

@RestController
@RequestMapping("/login")
public class TestController {
    @Autowired
    private TestService t_Service;

    @Autowired
    private HttpServletRequest request;

    @RequestMapping("/login")
    public Map<String, Object> test(String m_id, String m_pw) {
        Map<String, Object> map = new HashMap<>();

        MemberVO vo = t_Service.login(m_id, m_pw);
        map.put("memberVo", vo);
        map.put("m_id", vo.getM_id());

        return map;
    }

    @RequestMapping("/getCtList")
    public Map<String, Object> getCtList() {
        Map<String, Object> map = new HashMap<>();
        CourseTypeVO[] ar = t_Service.getCtList();

        for (int i = 0; i < ar.length; i++) {
            if (ar[i].getC_ar().length > 0) {
                ar[i].setCvo(ar[i].getC_ar()[0]);
            }
        }

        map.put("courseTypeAr", ar);
        return map;
    }

    @RequestMapping("/getSfList")
    public Map<String, Object> getSfList() {
        Map<String, Object> map = new HashMap<>();
        StaffVO[] ar = t_Service.getSfList();
        map.put("ar", ar);
        return map;
    }

    @RequestMapping("/ctList")
    public Map<String, Object> ctList(String ct_idx) {
        Map<String, Object> map = new HashMap<>();
        CourseVO[] ar = t_Service.ctList(ct_idx);
        map.put("courseAr", ar);
        return map;
    }

    @RequestMapping("/searchCourse")
    public Map<String, Object> searchCourse(String c_name, String ct_idx) {
        Map<String, Object> map = new HashMap<>();
        CourseVO[] ar = t_Service.searchCourse(c_name, ct_idx);
        if (ar != null && ar.length > 0) {
            map.put("CourseAr", ar);
        } else {
            map.put("CourseAr", null);
        }
        return map;
    }

    @RequestMapping("/addAsk")
    public void addAsk(AskcounselingVO vo) {
        t_Service.addAsk(vo);
    }

    @RequestMapping("/regMember")
    public void regMember(MemberVO vo) {
        t_Service.regMember(vo);
    }

    // 아이디 중복체크 기능
    @RequestMapping("/checkSameId")
    public boolean checkSameId(String m_id) {
        boolean flag = false;
        int cnt = t_Service.checkSameId(m_id);
        // 아이디가 중복되면 true, 중복이 아니면 false를 반환
        if (cnt == 1) {
            flag = true;
        } else {
            flag = false;
        }

        return flag;
    }

    // 마이페이지 안에서 수강하는 과정 반환하는 기능
    @RequestMapping("/myCourse")
    public Map<String, Object> myCourse(String m_id) {
        Map<String, Object> map = new HashMap<>();
        CourseVO[] ar = t_Service.myCourse(m_id);
        map.put("ar", ar);
        return map;
    }

    @RequestMapping("/editMyInfo")
    public void editMyInfo(String m_id) {

    }

    @RequestMapping("/online/add")
    public Map<String, Object> onlineAdd(AskcounselingVO vo) {

        Map<String, Object> map = new HashMap<>();

        int cnt = t_Service.askcounseling(vo);
        map.put("res", cnt);

        return map;
    }

    @RequestMapping("/qna/write")
    public Map<String, Object> write(QnaVO vo) {

        Map<String, Object> map = new HashMap<>();

        int cnt = t_Service.qnawrite(vo);
        map.put("res", cnt);
        return map;
    }

    @RequestMapping("/getmemberVO")
    public Map<String, Object> getmember(String m_id) {

        Map<String, Object> map = new HashMap<>();

        MemberVO[] ar = t_Service.getmember(m_id);
        map.put("ar", ar);

        return map;

    }

    @RequestMapping("/qna/getqnaList")
    public Map<String, Object> list(String qname, String cPage) {
        Map<String, Object> map = new HashMap<>();
        int nowPage = 1;

        if (qname == null)
            qname = "q";

        if (cPage != null)
            nowPage = Integer.parseInt(cPage);

        int totalRecord = t_Service.count(qname);

        Paging2 page = new Paging2(
                nowPage, totalRecord, 7, 5);

        nowPage = page.getNowPage();
        // 페이징에 필요한 HTML코드를 받아낸다.
        String pageCode = page.getSb().toString();
        // ---------------------------------------------------

        // 뷰페이지에서 표현할 목록 가져오기
        String begin = String.valueOf(page.getBegin());
        String end = String.valueOf(page.getEnd());
        QnaVO[] ar = t_Service.getList(qname, begin, end);

        // ModelAndView에 뷰페이지에서 필요한 정보들을 저장한다.
        map.put("ar", ar);
        map.put("page", page);
        map.put("pageCode", pageCode);
        map.put("totalRecord", totalRecord);
        map.put("nowPage", nowPage);
        map.put("qname", qname);
        map.put("blockList", page.getBlockList());

        return map;
    }

    @RequestMapping("/qna/view")
    public Map<String, Object> view(String qna_idx, String cPage, String qname) {
        Map<String, Object> map = new HashMap<>();

        HttpSession session = request.getSession(true);

        // 세션에 read_list라는 이름으로 등록된 ArrayList<BbsVO>를 얻어낸다.
        Object obj = session.getAttribute("read_list");
        ArrayList<QnaVO> list = null;
        if (obj != null)
            list = (ArrayList<QnaVO>) obj;
        else
            list = new ArrayList<>();

        // 받은 인자들 중 b_idx가 기본키이므로 게시물 얻어내는
        // 조건으로 사용하자!
        QnaVO vo = t_Service.getqna(qna_idx);

        // 이미 읽었던 게시물인지? 확인하자!
        boolean chk = false;
        for (QnaVO qvo : list) {
            if (qvo.getQna_idx().equals(qna_idx)) {
                chk = true;
                break;// 탈출
            }
        } // for의 끝

        // chk가 true이면 이미 읽었던 게시물이다. 즉 할일이 없다.
        // if (!chk) {
        // int hit = Integer.parseInt(vo.getHit()) + 1;
        // vo.setHit(String.valueOf(hit));

        // // b_Service.updateHit(vo); //DB수정
        // }

        map.put("vo", vo);

        return map;
    }

    @RequestMapping("/qna/del")
    public Map<String, Object> del(String qna_idx) {

        Map<String, Object> map = new HashMap<>();

        int cnt = t_Service.del(qna_idx);
        map.put("res", cnt);
        return map;
    }

    @RequestMapping("/qna/edit")
    public Map<String, Object> edit(QnaVO vo) {

        Map<String, Object> map = new HashMap<>();

        int cnt = t_Service.edit(vo);
        map.put("res", cnt);
        System.out.println(cnt);
        return map;
    }

    @RequestMapping("/qna/comm")
    public Map<String, Object> comm(CommVO vo) {

        Map<String, Object> map = new HashMap<>();

        int cnt = t_Service.addComm(vo);
        map.put("res", cnt);

        return map;
    }

    @RequestMapping("/qna/commList")
    public Map<String, Object> commList(String qna_idx) {

        Map<String, Object> map = new HashMap<>();

        CommVO[] ar = t_Service.cList(qna_idx);

        map.put("ar", ar);

        return map;

    }

}