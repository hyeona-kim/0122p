package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.QcVO;

public interface QcMapper {


    int qedit(QcVO qvo);

    List<QcVO> list(String tr_idx);
    int editWrite(QcVO qvo);
    int addWrite(QcVO qvo);
    int add(QcVO qvo);

}
