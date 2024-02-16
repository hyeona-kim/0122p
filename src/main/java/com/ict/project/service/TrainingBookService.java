package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.TrainingBookMapper;
import com.ict.project.vo.TrainingBookVO;

@Service
public class TrainingBookService {

    @Autowired
    private TrainingBookMapper tb_Mapper;

    // 훈련교재현황에 처음 들어왔을 때 list를 배열로 반환하는 기능
    public TrainingBookVO[] list(String begin, String end) {
        TrainingBookVO[] ar = null;

        List<TrainingBookVO> list = tb_Mapper.list(begin, end); // begin, end 넣어줘야함
        if (list != null && !list.isEmpty()) {
            ar = new TrainingBookVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    // Paging을 위해 totalRecord를 구하는 기능
    public int getTotalRecord() {
        return tb_Mapper.getTotalRecord();
    }

    // 훈련교재 삭제하는 기능
    public int delBook(String tb_idx) {
        return tb_Mapper.delBook(tb_idx);
    }

    // 훈련교재 추가하는 기능
    public int addBook(TrainingBookVO vo) {
        return tb_Mapper.addBook(vo);
    }
}
