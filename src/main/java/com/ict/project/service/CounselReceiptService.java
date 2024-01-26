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
    public CounselReceiptVO getCounselReceipt(String cr_idx) {
        return cr_mapper.getCounselReceipt(cr_idx);
    }

    public int addCounselReceipt(CounselReceiptVO vo) {
        return cr_mapper.add(vo);
    }
    public int editCounselReceipt(CounselReceiptVO vo) {
        return cr_mapper.edit(vo);
    }
    public int deleteCounselReceipt(String cr_idx) {
        return cr_mapper.del(cr_idx);
    }

}
