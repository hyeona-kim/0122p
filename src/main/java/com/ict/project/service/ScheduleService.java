package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.ScheduleMapper;
import com.ict.project.vo.ScheduleVO;

@Service
public class ScheduleService {
    @Autowired
    ScheduleMapper sc_mapper;

    public ScheduleVO[] all() {
        ScheduleVO[] ar = null;

        List<ScheduleVO> list = sc_mapper.getList();
        if (list != null && !list.isEmpty()) {
            ar = new ScheduleVO[list.size()];
            list.toArray(ar);
        }
        return ar;
    }
}
