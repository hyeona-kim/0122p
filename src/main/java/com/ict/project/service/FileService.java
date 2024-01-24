package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.FileMapper;
import com.ict.project.vo.FileVO;

@Service
public class FileService {
    @Autowired
    FileMapper f_Mapper;

    public FileVO[] getList(String c_idx){
        FileVO[] ar = null;
        List<FileVO> list = f_Mapper.getFile(c_idx);
        if(list != null && !list.isEmpty()){
            ar = new FileVO[list.size()];
            list.toArray(ar);
        }
        return ar;
    }
    public int addFile(FileVO fvo){
        return f_Mapper.add(fvo);
    }
    public int editFile(FileVO fvo){
        return f_Mapper.edit(fvo);
    }
}
