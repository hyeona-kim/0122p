package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.StaffVO;

public interface StaffMapper {
    List<StaffVO> all();
    StaffVO login_admin(String u_id,String u_pw);
    StaffVO login_teacher(String u_id,String u_pw);
    List<String> search_sfCode();
    int add(StaffVO vo);
    StaffVO search(String sf_name);
    int delete(String sf_idx);
    StaffVO for_edit(String sf_idx);
    int editStaff(StaffVO vo);
}
