package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.CheckExamFileVO;

public interface CheckExamFileMapper {
    List<CheckExamFileVO> getFile(String es_idx);

    int add(CheckExamFileVO cefvo);

    int edit(CheckExamFileVO cefvo);

    CheckExamFileVO getFile2(String es_idx);
}
