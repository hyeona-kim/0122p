package com.ict.project.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class QnaVO {
    private String qna_idx,qna_title,qna_content,qna_write_date, m_id,status,qna_writer,qname;
    
    private List<CommVO> c_list;
    private boolean c_check;
    
}
