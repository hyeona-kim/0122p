package com.ict.project.control.front;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.ict.project.service.TestService;
import com.ict.project.vo.CourseTypeVO;
import com.ict.project.vo.CourseVO;
import com.ict.project.vo.MemberVO;
import com.ict.project.vo.StaffVO;
import com.ict.project.vo.AskcounselingVO;

@RestController
@RequestMapping("/login")
public class TestController {
    @Autowired
    private TestService t_Service;

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
    public Map<String, Object> write(MemberVO vo) {
        
        Map<String, Object> map = new HashMap<>();

        int cnt = t_Service.qnawrite(vo);
        map.put("res", cnt);
System.out.println(cnt);
        return map;
    }

    @RequestMapping("/getmemberVO")
    public Map<String,Object> getmember(String m_id){
        

        Map<String,Object> map = new HashMap<>();

        MemberVO[] ar = t_Service.getmember(m_id);
        map.put("ar", ar);
System.out.println(ar);
        return map;
        
    }
}