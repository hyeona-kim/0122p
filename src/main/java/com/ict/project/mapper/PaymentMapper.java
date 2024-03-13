package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.PaymentDTO;

public interface PaymentMapper {
    
    int add(PaymentDTO dto);
    List<PaymentDTO> todayPayment(String p_date);
}
