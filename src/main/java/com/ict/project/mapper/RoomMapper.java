package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.RoomVO;

public interface RoomMapper {
    List<RoomVO> all();
    int key(String r_idx);
    int add(RoomVO vo);
    int update(RoomVO vo);
    RoomVO search(String r_name);
}
