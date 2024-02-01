package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.FormDownVO;

public interface FormDownMapper {
    int addFormDown(FormDownVO vo);
    int deleteFormDown(String fd_idx);
    List<FormDownVO> getFormList(String begin, String end);
    int editFormDown(FormDownVO vo);
    FormDownVO getFormData(String fd_idx);
    int cntAllForm();
    int searchBothCnt(String fd_subject);
    List<FormDownVO> searchBothForm(String fd_subject, String begin, String end);
}
