package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.CheckExamFileMapper;
import com.ict.project.vo.CheckExamFileVO;

@Service
public class CheckExamFileService {
    @Autowired
    CheckExamFileMapper cef_Mapper;

    public CheckExamFileVO[] getList(String es_idx) {
        CheckExamFileVO[] ar = null;
        List<CheckExamFileVO> list = cef_Mapper.getFile(es_idx);
        if (list != null && !list.isEmpty()) {
            ar = new CheckExamFileVO[list.size()];
            list.toArray(ar);
        }
        return ar;
    }

    public int addFile(CheckExamFileVO cefvo) {
        return cef_Mapper.add(cefvo);
    }

    public int editFile(CheckExamFileVO cefvo) {
        return cef_Mapper.edit(cefvo);
    }

    public CheckExamFileVO getFile2(String es_idx) {
        return cef_Mapper.getFile2(es_idx);
    }
}
