package com.ict.project.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberVO {
    private String m_idx, m_id, m_pw, m_email, m_phone, m_name, m_addr,m_title,m_content,m_write_date,status;
    private String tr_idx;
}
