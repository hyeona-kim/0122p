package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.UpSkillMapper;
import com.ict.project.vo.UpSkillVO;

@Service
public class UpskillService {

    @Autowired
    private UpSkillMapper us_mapper;

    public UpSkillVO[] getUpskillList() {
        UpSkillVO[] ar = null;

        List<UpSkillVO> list = us_mapper.all();
        if(list != null && list.size() > 0) {
            ar = new UpSkillVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }
}
