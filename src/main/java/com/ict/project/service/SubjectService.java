package com.ict.project.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.SubjectMapper;
import com.ict.project.vo.SubjectVO;

@Service
public class SubjectService {
    @Autowired
    SubjectMapper sb_mapper;

    public SubjectVO[] getList(int c_idx) {
        SubjectVO[] ar = null;
        List<SubjectVO> list = sb_mapper.list(c_idx);
        if (list != null && !list.isEmpty()) {
            ar = new SubjectVO[list.size()];
            list.toArray(ar);
        }
        return ar;
    }

    public int addSubject(Map<String, List<SubjectVO>> map) {
        return sb_mapper.add(map);
    }

    public int editSubject(SubjectVO sfvo) {
        return sb_mapper.edit_sb(sfvo);
    }

}
