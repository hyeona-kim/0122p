package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.PaymentDTO;

public interface PaymentMapper {
    
    int add(PaymentDTO dto);
    List<PaymentDTO> todayPayment(String p_date, String begin, String end);
    List<PaymentDTO> paymentList(String begin, String end);
    int todayCount(String p_date);
    int allCount();
}
