package com.ict.project.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CheckExamFileVO {
    private String cef_idx, cef_name, es_idx;
    MultipartFile file1;
}
