package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.CounselingdetailVO;
import com.ict.project.vo.CourseVO;


public interface CounselingdetailMapper {

    List<CounselingdetailVO> all();
    int add(CounselingdetailVO vo);
    }
