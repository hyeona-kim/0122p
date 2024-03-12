package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.StaffMapper;
import com.ict.project.vo.StaffVO;

@Service
public class StaffService {

    @Autowired
    private StaffMapper s_mapper;

    // 교직원 목록을 배열로 반환
    public StaffVO[] getList() {
        StaffVO[] ar = null;

        List<StaffVO> list = s_mapper.all();
        if (list != null && list.size() > 0) {
            ar = new StaffVO[list.size()];
            list.toArray(ar);
        }
        return ar;
    }

    public StaffVO[] getList2(String begin, String end) {
        StaffVO[] ar = null;

        List<StaffVO> list = s_mapper.paging(begin, end);
        if (list != null && list.size() > 0) {
            ar = new StaffVO[list.size()];
            list.toArray(ar);
        }
        return ar;
    }

    // 교직원 추가
    public int addStaff(StaffVO vo) {
        return s_mapper.add(vo);
    }

    public int editPass(String sf_idx, String sf_pwd) {
        return s_mapper.editPass(sf_idx, sf_pwd);
    }

    public int editMe(String sf_idx, String sf_id, String sf_email, String sf_phone) {
        return s_mapper.editMe(sf_idx, sf_id, sf_email, sf_phone);
    }

    // 교직원 검색
    public StaffVO searchList(String sf_name) {
        return s_mapper.search(sf_name);
    }

    // 교직원 삭제(실제 DB에서 삭제는 아님)
    public int deleteStaff(String sf_idx) {
        return s_mapper.delete(sf_idx);
    }

    // 교직원 등록시 교수코드 중복확인을 위해 교수코드들을 배열로 반환하는 기능
    public String[] searchSfCode() {
        String[] ar = null;

        List<String> list = s_mapper.search_sfCode();
        if (list != null && list.size() > 0) {
            ar = new String[list.size()];
            list.toArray(ar);
        }
        return ar;
    }

    // 교직원 1명 검색하는 기능
    public StaffVO getStaff(String sf_idx) {
        return s_mapper.getStaff(sf_idx);
    }

    // 교직원 수정하는 기능
    public int editStaff(StaffVO vo) {
        return s_mapper.editStaff(vo);
    }

    // 로그인 5회 실패시 차단하는 기능
    public int block(String sf_id) {
        return s_mapper.login_block(sf_id);
    }

    // 로그인 차단을 해제하는 기능(로그인 성공시)
    public int unblock(String sf_id) {
        return s_mapper.login_unblock(sf_id);
    }

    // 로그인 성공시 차단을 해제하기 위해 sf_link값을 검색하는 기능
    public String sf_link(String sf_id) {
        return s_mapper.sf_link(sf_id);
    }

    // 로그인 차단을 해제하는 기능(차단해제 버튼 클릭시)
    public int unblockStaff(String sf_idx) {
        return s_mapper.unblockStaff(sf_idx);
    }

    public int editCareer(String sf_idx, String sf_career, String img_path) {
        return s_mapper.editCareer(sf_idx, sf_career, img_path);
    }
}
