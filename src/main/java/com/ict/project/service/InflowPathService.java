package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.InflowPathMapper;
import com.ict.project.vo.InflowPathVO;

@Service
public class InflowPathService {
    
    @Autowired
    private InflowPathMapper id_mapper;

    // 강의실 목록을 배열로 반환하는 기능
    public InflowPathVO[] getList() {
        InflowPathVO[] ar = null;

        List<InflowPathVO> list = id_mapper.all();
        if(list != null && list.size() > 0){
            ar = new InflowPathVO[list.size()];
            list.toArray(ar);
        }
        return ar;
    }

    // 강의실 이름으로 검색하는 기능
    public InflowPathVO searchList(String id_name) {

        return id_mapper.search(id_name);
    }

    // 강의실 추가하는 기능
    public int addInflowPath(InflowPathVO vo) {
        int key = id_mapper.key(vo.getId_idx());
        System.out.println("id_idx="+vo.getId_idx());
        System.out.println("key="+key);
        if(key == 0) {
            key = id_mapper.add(vo);
        }else {
            key = id_mapper.update(vo);
        }

        return key;
    }

    public int deleteInflowPath(String id_idx) {
        return id_mapper.del(id_idx);
    }
}
