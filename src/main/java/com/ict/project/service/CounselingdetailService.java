package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.CounselingdetailMapper;
import com.ict.project.vo.CounselingdetailVO;

@Service
public class CounselingdetailService {

    @Autowired
    private CounselingdetailMapper cd_mapper;

    public CounselingdetailVO[] getCounselingdetailList() {
        CounselingdetailVO[] ar = null;

        List<CounselingdetailVO> list = cd_mapper.all();
        if(list != null && list.size() > 0) {
            ar = new CounselingdetailVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }
}
