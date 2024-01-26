package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.SkillVO;

public interface SkillMapper {
    List<SkillVO> getList(String s_idx);
    int add(SkillVO svo);
}
