package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.FormDownMapper;
import com.ict.project.vo.FormDownVO;

@Service
public class FormDownService {
    @Autowired
    private FormDownMapper fd_mapper;

    // 서식파일을 등록하는 기능
    public int addFormDown(FormDownVO vo) {
        return fd_mapper.addFormDown(vo);
    }

    // 서식파일을 삭제하는 기능
    public int deleteFormDown(String fd_idx) {
        return fd_mapper.deleteFormDown(fd_idx);
    }

    // 서식파일의 전체 목록을 반환하는 기능
    public FormDownVO[] getFormList(String begin, String end) {
        FormDownVO[] ar = null;

        List<FormDownVO> list = fd_mapper.getFormList(begin, end);
        if(list != null && list.size() > 0) {
            ar = new FormDownVO[list.size()];
            list.toArray(ar);
        }
        return ar;
    }

    // 서식파일을 수정하는 기능
    public int editFormDown(FormDownVO vo){
        return fd_mapper.editFormDown(vo);
    }

    // 서식파일 1개의 정보를 반환하는 기능
    public FormDownVO getFormData(String fd_idx) {
        return fd_mapper.getFormData(fd_idx);
    }

    // 서식파일의 총 totalRecord를 반환하는 기능
    public int cntAllForm() {
        return fd_mapper.cntAllForm();
    }

    // 표시갯수를 변경하거나 제목으로 검색했을 때 totalRecord를 구하는 기능
    public int searchBothCnt(String fd_subject) {
        return fd_mapper.searchBothCnt(fd_subject);
    }

    // 표시갯수를 변경하거나 제목으로 검색했을 때 검색목록을 구하는 기능
    public FormDownVO[] searchBothForm(String fd_subject, String begin, String end) {
        FormDownVO[] ar = null;

        List<FormDownVO> list = fd_mapper.searchBothForm(fd_subject, begin, end);
        if(list != null && list.size() > 0) {
            ar = new FormDownVO[list.size()];
            list.toArray(ar);
        }
        return ar;
    }
    
}
