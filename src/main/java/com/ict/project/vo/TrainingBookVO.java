package com.ict.project.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TrainingBookVO {
    private String tb_idx, tb_title, tb_writer, tb_publisher, tb_pub_date, tb_price, tb_comments, fr_img_fname,
            bk_img_fname, li_img_fname, tb_type, tb_provide_type, tb_status;
}
