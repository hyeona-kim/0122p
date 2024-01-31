package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.CounselingdetailVO;
import com.ict.project.vo.CourseVO;


public interface CounselingdetailMapper {

    List<CounselingdetailVO> all();
    int add(CounselingdetailVO vo);
    List<CounselingdetailVO> list();
    CounselingdetailVO getCounselingDetail(String cd_idx);
    CounselingdetailVO getCounselingDetail2(String cd_idx);
	int edit(CounselingdetailVO cvo);
    }
 