package com.ict.project.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class FormDownVO {
    private String fd_idx, fd_subject, fd_fname, fd_oname;
    private MultipartFile file;
}
