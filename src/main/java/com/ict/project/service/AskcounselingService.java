package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.AskcounselingMapper;
import com.ict.project.vo.AskcounselingVO;

@Service
public class AskcounselingService {
    @Autowired
    private AskcounselingMapper as_mapper;
    
    public AskcounselingVO[] getASK(String beforedate,String enddate,String type,String c_idx){
        AskcounselingVO[] ar = null;

        List<AskcounselingVO> list = as_mapper.getASK(beforedate, enddate, type,c_idx);
        if(list != null && !list.isEmpty()){
            ar = new AskcounselingVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }
    public AskcounselingVO selectASK(String ac_idx){
        return as_mapper.selectASK(ac_idx);
    }
    public int updateASK(String ac_idx,String ac_answer_date,String ac_answer){
        return as_mapper.updateASK(ac_idx, ac_answer_date, ac_answer);
    }
    public AskcounselingVO[] todayconsult(String today){
        AskcounselingVO[] ar = null;

        List<AskcounselingVO> list = as_mapper.todayconsult(today);
        if(list != null && !list.isEmpty()){
            ar = new AskcounselingVO[list.size()];
            list.toArray(ar);
        }
        return ar;
    }
}
