package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.GradeCheckMapper;
import com.ict.project.vo.GradeCheckVO;

@Service
public class GradeCheckService {

    @Autowired
    private GradeCheckMapper gc_mapper;

    public GradeCheckVO[] list(String tr_idx) {
        GradeCheckVO[] ar = null;

        List<GradeCheckVO> list = gc_mapper.list(tr_idx);
        if (list != null && list.size() > 0) {
            ar = new GradeCheckVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    public GradeCheckVO getOne(String gc_idx) {
        return gc_mapper.getOne(gc_idx);
    }

    public int add(GradeCheckVO vo) {
        return gc_mapper.add(vo);
    }

    public int staff_edit(String gc_idx, String gc_score, String gc_memo) {
        return gc_mapper.staff_edit(gc_idx, gc_score, gc_memo);
    }

    public int trainee_edit(String gc_idx, String gc_answer) {
        return gc_mapper.trainee_edit(gc_idx, gc_answer);
    }

    public int set_grade(String gc_idx) {
        return gc_mapper.set_grade(gc_idx);
    }

    public int all_grade(String es_idx, String tr_idx) {
        return gc_mapper.all_grade(es_idx, tr_idx);
    }
}
