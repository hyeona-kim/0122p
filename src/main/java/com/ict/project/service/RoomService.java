package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.RoomMapper;
import com.ict.project.vo.RoomVO;

@Service
public class RoomService {
    
    @Autowired
    private RoomMapper r_mapper;

    // 강의실 목록을 배열로 반환하는 기능
    public RoomVO[] getList() {
        RoomVO[] ar = null;

        List<RoomVO> list = r_mapper.all();
        if(list != null && list.size() > 0){
            ar = new RoomVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    // 강의실 이름으로 검색하는 기능
    public RoomVO searchList(String r_name) {

        return r_mapper.search(r_name);
    }

    // 강의실 추가하는 기능
    public int addRoom(RoomVO vo) {
        int key = r_mapper.key(vo.getR_idx());

        if(key == 0) {
            key = r_mapper.add(vo);
        }else {
            key = r_mapper.update(vo);
        }

        return key;
    }
}
