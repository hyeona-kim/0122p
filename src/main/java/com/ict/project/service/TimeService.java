package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.TimeMapper;
import com.ict.project.vo.TimeVO;

@Service
public class TimeService {
    @Autowired
    private TimeMapper t_mapper;

    // 시간표 목록을 배열로 반환하는 기능
    public TimeVO[] getList() {
        TimeVO[] ar = null;

        List<TimeVO> list = t_mapper.all();
        if(list != null && list.size() > 0) {
            ar = new TimeVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }
}
