package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.SuggestionVO;

public interface SuggestionMapper {
    
	List<SuggestionVO> all(String begin,String end);
    int add(SuggestionVO vo);
	int addReply(SuggestionVO vo);
	int count();
    List<SuggestionVO> search(String subject,String begin,String end);
    int reCount(String sg_subject);
    SuggestionVO view(String sg_idx);
    List<SuggestionVO> checkNotice(String begin, String end);
    int cntNonNotice();
    int addHit(String sg_idx);
}
