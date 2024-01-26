package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.SkillMapper;
import com.ict.project.vo.SkillVO;

@Service
public class SkillService {

    @Autowired
    private SkillMapper sk_mapper;

    public SkillVO[] getSkillList(String s_idx) {
        SkillVO[] ar = null;

        List<SkillVO> list = sk_mapper.getList(s_idx);
        if(list != null && list.size() > 0) {
            ar = new SkillVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }
    public int addSkill(SkillVO svo){
        return sk_mapper.add(svo);
    }
    public int editSkill(SkillVO skvo){
        return sk_mapper.edit_sk(skvo);
    }
    public int delSkill(String sk_idx){
        return sk_mapper.del_sk(sk_idx);
    }
}
