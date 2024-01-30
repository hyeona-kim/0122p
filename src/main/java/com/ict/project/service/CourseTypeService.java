package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.CourseTypeMapper;
import com.ict.project.vo.CourseTypeVO;

@Service
public class CourseTypeService {
    
    @Autowired
    private CourseTypeMapper ct_mapper;

    // 과정타입 추가하는 기능
    public int addCourseType(CourseTypeVO vo) {
        int key = ct_mapper.key(vo.getCt_idx());
        if (key == 0) {
            key = ct_mapper.add(vo);
        }else {
            key = ct_mapper.update(vo);
        }
        return key;
    }

    // 과정타입 전체 목록을 배열로 반환하는 기능
    public CourseTypeVO[] getList() {
        CourseTypeVO[] ar = null;

        List<CourseTypeVO> list = ct_mapper.all();
        if(list != null && list.size() > 0) {
            ar = new CourseTypeVO[list.size()];
            list.toArray(ar);
        }
        
        return ar;
    }

    // 과정타입 검색하는 기능
    public CourseTypeVO SearchList(String ct_name) {
        return ct_mapper.search(ct_name);
    }
    
}
