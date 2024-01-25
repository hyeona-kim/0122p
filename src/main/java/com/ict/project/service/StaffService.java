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
        if(list != null && list.size() > 0) {
            ar = new StaffVO[list.size()];
            list.toArray(ar);
        }
        return ar;
    }

    // 교직원 추가
    public int addStaff(StaffVO vo) {
        return s_mapper.add(vo);
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
        if(list != null && list.size() > 0) {
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
    public int block(String sf_id){
        return s_mapper.login_block(sf_id);
    }
    public int unblock(String sf_id){
        return s_mapper.login_unblock(sf_id);
    }
    public String sf_link(String sf_id){
        return s_mapper.sf_link(sf_id);
    }
}
