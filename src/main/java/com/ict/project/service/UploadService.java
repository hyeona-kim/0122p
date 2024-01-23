package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.UploadMapper;
import com.ict.project.vo.TrainuploadVO;

@Service
public class UploadService {
    @Autowired
    private UploadMapper u_mapper;

    // 훈련생 관련 서류를 배열로 반환하는 기능
    public TrainuploadVO[] getList(String begin, String end) {
        TrainuploadVO[] ar = null;

        List<TrainuploadVO> list = u_mapper.getlist(begin, end);
        if(list != null && list.size() > 0){
            ar = new TrainuploadVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    // trainupload테이블의 Record 개수를 반환하는 기능
    public int getCount() {
        return u_mapper.count();
    }

    // 추가하는 기능
    public int add(TrainuploadVO vo) {
        return u_mapper.add(vo);
    }

    // Record 하나만 가져오는 기능
    public TrainuploadVO getUpload(String tn_idx) {
        return u_mapper.getUpload(tn_idx);
    }

    // 서류 내용을 보기 위해 VO객체 1개 가져오는 기능
    public TrainuploadVO view(String tn_idx) {
        return u_mapper.getUpload(tn_idx);
    }

    // 수정하는 기능
    public int edit(TrainuploadVO vo) {
        return u_mapper.update(vo);
    }

    // 삭제하는 기능
    public int delete(String tn_idx) {
        return u_mapper.del(tn_idx);
    }
}
