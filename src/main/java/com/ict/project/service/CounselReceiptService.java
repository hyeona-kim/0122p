package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.CounselReceiptMapper;
import com.ict.project.vo.CounselReceiptVO;

@Service
public class CounselReceiptService {

    @Autowired
    private CounselReceiptMapper cr_mapper;


    public CounselReceiptVO[] getCounselReceiptList() {
        CounselReceiptVO[] ar = null;

        List<CounselReceiptVO> list = cr_mapper.all();
        if(list != null && list.size() > 0) {
            ar = new CounselReceiptVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }
}
