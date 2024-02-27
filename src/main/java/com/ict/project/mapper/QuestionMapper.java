package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.QuestionVO;

public interface QuestionMapper {
    
    List<QuestionVO> list();
    QuestionVO getOne(String qt_idx);
    int add(QuestionVO vo);
    int edit(QuestionVO vo);

}
