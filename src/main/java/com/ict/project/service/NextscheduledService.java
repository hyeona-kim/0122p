package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.NextscheduledMapper;
import com.ict.project.vo.NextscheduledVO;

@Service
public class NextscheduledService {
    
    @Autowired
    private NextscheduledMapper ns_mapper;

    public NextscheduledVO[] getList() {
        NextscheduledVO[] ar = null;

        List<NextscheduledVO> list = ns_mapper.all();
        if(list != null && list.size() > 0){
            ar = new NextscheduledVO[list.size()];
            list.toArray(ar);
        }
        return ar;
    }

    public NextscheduledVO searchList(String ns_name) {

        return ns_mapper.search(ns_name);
    }
    public int addNextscheduled(NextscheduledVO vo) {
        int key = ns_mapper.key(vo.getNs_idx());
        if(key == 0) {
            key = ns_mapper.add(vo);
        }else {
            key = ns_mapper.update(vo);
        }

        return key;
    }

    public int deleteNS(String ns_idx) {
        return ns_mapper.del(ns_idx);
    }
}
