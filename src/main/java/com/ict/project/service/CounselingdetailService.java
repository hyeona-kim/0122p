package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.CounselingdetailMapper;
import com.ict.project.vo.CounselVO;
import com.ict.project.vo.CounselingdetailVO;
import com.ict.project.vo.CourseVO;

@Service
public class CounselingdetailService {

    @Autowired
    private CounselingdetailMapper cd_mapper;

    public CounselingdetailVO[] getCounselingdetailList() {
        CounselingdetailVO[] ar = null;

        List<CounselingdetailVO> list = cd_mapper.all();
        if (list != null && list.size() > 0) {
            ar = new CounselingdetailVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    public int add(CounselingdetailVO vo) {
        return cd_mapper.add(vo);
    }

    public CounselingdetailVO[] getList() {
        CounselingdetailVO[] ar = null;

        List<CounselingdetailVO> list = cd_mapper.list();
        if (list != null && list.size() > 0) {
            ar = new CounselingdetailVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    public CounselingdetailVO getCounselingDetail(String cd_idx) {
        return cd_mapper.getCounselingDetail(cd_idx);
    }

    public CounselingdetailVO getCounselingDetail2(String cd_idx) {
        return cd_mapper.getCounselingDetail2(cd_idx);
    }

    public int editCounselingDetail(CounselingdetailVO cvo) {
        return cd_mapper.edit(cvo);
    }

    public int deletetCounselingDetail(String cd_idx) {
        return cd_mapper.del(cd_idx);
    }

    public int getSearchCount(String select, String value, String year, String c_idx, String ct_idx) {
        return cd_mapper.search_count(select, value, year, c_idx, ct_idx);
    }

    public CounselingdetailVO[] searchCounseldetail(String select, String value, String year, String begin,
            String end, String c_idx, String ct_idx) {
        CounselingdetailVO[] ar = null;

        List<CounselingdetailVO> list = cd_mapper.search(select, value, year, begin, end, c_idx, ct_idx);
        if (list != null && list.size() > 0) {
            ar = new CounselingdetailVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }
}
