package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.FileVO;

public interface FileMapper {
    List<FileVO> getFile(String c_idx);
    int add(FileVO fvo);
    int edit(FileVO fvo);
}
