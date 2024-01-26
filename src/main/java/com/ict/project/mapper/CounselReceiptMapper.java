package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.CounselReceiptVO;


public interface CounselReceiptMapper {
    List<CounselReceiptVO> all();
    CounselReceiptVO getCounselReceipt(String cr_idx);
    int add(CounselReceiptVO vo);
    int edit(CounselReceiptVO vo);
    int del(String c_idx);
}
