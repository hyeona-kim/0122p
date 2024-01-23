package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.SuggestionMapper;
import com.ict.project.vo.SuggestionVO;

@Service
public class SuggestionService {

    @Autowired
    private SuggestionMapper s_mapper;

    // 건의사항 전체 목록 출력하는 기능
    public SuggestionVO[] getSuggList(String begin, String end) {
        SuggestionVO[] ar = null;

        List<SuggestionVO> list = s_mapper.all(begin, end);
        if(list != null && list.size() > 0) {
            ar = new SuggestionVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }
    
    // 건의사항 추가하는 기능
    public int addSugg(SuggestionVO vo) {
        return s_mapper.add(vo);
    }

    // 건의사항 답변 추가하는 기능
    public int addReply(SuggestionVO vo) {
        return s_mapper.addReply(vo);
    }

    // Paging객체 생성을 위해 totalRecord를 구하는 기능
    public int getTotalRecord() {
        return s_mapper.count();
    }

    // 검색 후 Paging객체를 다시 생성하기 위해
    // totalRecord를 다시 구하는 기능
    public int reGetTotalRecord(String sg_subject) {
        return s_mapper.reCount(sg_subject);
    }

}
