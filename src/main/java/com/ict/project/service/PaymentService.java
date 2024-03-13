package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.PaymentMapper;
import com.ict.project.vo.PaymentDTO;

@Service
public class PaymentService {
 @Autowired
    private PaymentMapper p_mapper;

    // 과정 검색하는 기능
    public PaymentDTO[] todayPayments(String p_date, String begin, String end) {
        PaymentDTO[] ar = null;

        List<PaymentDTO> list = p_mapper.todayPayment(p_date, begin, end);
        if (list != null && list.size() > 0) {
            ar = new PaymentDTO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }   

    public PaymentDTO[] getTotalPay(String beforedate,String enddate) {
        PaymentDTO[] ar = null;

        List<PaymentDTO> list = p_mapper.getTotalPay(beforedate, enddate);
        if (list != null && list.size() > 0) {
            ar = new PaymentDTO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }   
    
    public int add(PaymentDTO dto){
        return p_mapper.add(dto);
    }
    public PaymentDTO[] paymentsList(String begin, String end) {
        PaymentDTO[] ar = null;
        
        List<PaymentDTO> list = p_mapper.paymentList(begin, end);
        if (list != null && list.size() > 0) {
            ar = new PaymentDTO[list.size()];
            list.toArray(ar);
        }
        
        return ar;
    }   
    public int todayCount(String p_date){
        return p_mapper.todayCount(p_date);
    }
    public int allCount(){
        return p_mapper.allCount();
    }
}
