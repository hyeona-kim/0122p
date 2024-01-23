package com.ict.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.StaffMapper;
import com.ict.project.vo.StaffVO;

@Service
public class LoginService {
    
    @Autowired
    private StaffMapper s_mapper;

    // 관리자로 로그인해서 관리자의 VO를 반환하는 기능
    public StaffVO login_admin(String u_id, String u_pw) {
        return s_mapper.login_admin(u_id, u_pw);
    }
    
    // 교,강사로 로그인해서 교,강사의 VO를 반환하는 기능
    public StaffVO login_teacher(String u_id, String u_pw) {
        return s_mapper.login_teacher(u_id, u_pw);
    }

}
