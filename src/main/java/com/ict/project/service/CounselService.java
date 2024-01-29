package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.CounselMapper;
import com.ict.project.vo.CounselVO;
import com.ict.project.vo.TraineeVO;

@Service
public class CounselService {
    
    @Autowired
    private CounselMapper c_mapper;


      
    // 상담 검색하는 기능
    public CounselVO[] searchCounsel(String select, String value, String year, String begin, String end) {
        CounselVO[] ar = null;

        List<CounselVO> list = c_mapper.search(select, value, year, begin, end);
        if(list != null && list.size() > 0) {
            ar = new CounselVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    // 상담 목록을 배열로 반환하는 기능
    public CounselVO[] getCounselList(String begin, String end) {
        CounselVO[] ar = null;

        List<CounselVO> list = c_mapper.list(begin, end);
        if(list != null && list.size() > 0) {
            ar = new CounselVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    // 상담 추가하는 기능
    public int addCounsel(CounselVO vo) {
        return c_mapper.add(vo);
    }

    // 상담명을 출력하기 위해 해당 상담의 정보를 가져오는 기능
    public CounselVO getCounsel(String so_idx) {
        return c_mapper.getCounsel(so_idx);
    }

    // 상담 삭제하는 기능
    public int deleteCounsel(String so_idx) {
        return c_mapper.del(so_idx);
    }

    // 상담 수정하는 기능
    public int editCounsel(CounselVO vo) {
        return c_mapper.edit(vo);
    }

    // 전체 상담수를 반환하는 기능
    public int getCount() {
        return c_mapper.count();
    }

    // 검색 결과에서의 Paging기법을 위해
    // 다시 totalRecord를 검색하는 기능
    public int getSearchCount(String select, String value, String year) {
        return c_mapper.search_count(select, value, year);
 
   }
   public CounselVO[] counselList(String tr_idx){
            CounselVO[] ar = null;
        List<CounselVO> list = c_mapper.counselList(tr_idx);
        if(list != null && list.size() > 0) {
            ar = new CounselVO[list.size()];
            list.toArray(ar);
        }
        return ar;

}
    public int counselCount(String tr_idx){
        return c_mapper.counselCount(tr_idx);
    }

}