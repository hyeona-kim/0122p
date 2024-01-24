package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.SkillMapper;
import com.ict.project.mapper.UpSkillMapper;
import com.ict.project.vo.SkillVO;
import com.ict.project.vo.UpSkillVO;

@Service
public class SkillService {

    @Autowired
    private SkillMapper sk_mapper;

    public SkillVO[] getSkillList() {
        SkillVO[] ar = null;

        List<SkillVO> list = sk_mapper.all();
        if(list != null && list.size() > 0) {
            ar = new SkillVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }
}
