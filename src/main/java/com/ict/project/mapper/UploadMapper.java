package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.TrainuploadVO;

public interface UploadMapper {
    int count();
    List<TrainuploadVO> getlist(String begin,String end);
    int add(TrainuploadVO vo);
    TrainuploadVO getUpload(String tn_idx);    
    TrainuploadVO view(String tn_idx);   
    int update(TrainuploadVO vo);
    int del(String tn_idx);
    List<TrainuploadVO> all();

}
