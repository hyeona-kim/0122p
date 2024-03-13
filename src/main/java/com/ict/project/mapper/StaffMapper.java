package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.StaffVO;

public interface StaffMapper {
    List<StaffVO> all();

    List<StaffVO> paging(String begin, String end);

    StaffVO login_admin(String u_id, String u_pw);

    StaffVO login_teacher(String u_id, String u_pw);

    List<String> search_sfCode();

    int add(StaffVO vo);

    StaffVO search(String sf_name);

    int delete(String sf_idx);

    int editStaff(StaffVO vo);

    StaffVO getStaff(String sf_idx);

    int login_block(String sf_id);

    int login_unblock(String sf_id);

    String sf_link(String sf_id);

    int unblockStaff(String sf_idx);

    int editPass(String sf_idx, String sf_pwd);

    int editMe(String sf_idx, String sf_id, String sf_email, String sf_phone);

    int editCareer(String sf_idx, String sf_career, String img_path);
}
