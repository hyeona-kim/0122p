package com.ict.project.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.PaymentService;
import com.ict.project.service.TrainingBookService;
import com.ict.project.util.Paging;
import com.ict.project.vo.PaymentDTO;
import com.ict.project.vo.TrainingBookVO;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class TrainingBookController {
    @Autowired
    private TrainingBookService tb_Service;
    @Autowired 
    private PaymentService p_service;
    // 처음 [훈련교재현황] 으로 들어올 때 이동
    @RequestMapping("trainingBook")
    public String trainingBook(String cPage) {
        return "/jsp/admin/etcList/trainingBook/list";
    }

    // [훈련교재현황]으로 이동해서 비동기 통신으로 list를 반환
    @RequestMapping("trainingBookMain")
    public ModelAndView trainingBookMain(String cPage) {
        ModelAndView mv = new ModelAndView();

        Paging page = new Paging();
        page.setTotalRecord(tb_Service.getTotalRecord());

        if (cPage == null || cPage.equals("undefined")) {
            page.setNowPage(1);
        } else {
            int nowPage = Integer.parseInt(cPage);
            page.setNowPage(nowPage);
        }

        TrainingBookVO[] ar = tb_Service.list(String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));

        mv.addObject("ar", ar);
        mv.addObject("page", page);

        mv.setViewName("/jsp/admin/etcList/trainingBook/list_ajax");

        return mv;
    }

    // [삭제]를 클릭했을 때 해당 교재를 비활성화 처리
    @RequestMapping("delBook")
    public String delBook(String tb_idx) {
        tb_Service.delBook(tb_idx);
        return "/jsp/admin/etcList/trainingBook/list";
    }

    // [훈련교재 등록]을 클릭했을 때 등록 폼을 비동기식 통신으로 반환
    @RequestMapping("addTrainingBookAjax")
    public String addTrainingBookAjax() {
        return "/jsp/admin/etcList/trainingBook/addBook_ajax";
    }
    
    
    
    // 기타관리 [교재결제내역] 비동기식 통신
    @RequestMapping("bookList_ajax")
    public ModelAndView requestMethodName(String cPage) {
        ModelAndView mv = new ModelAndView();
        if (cPage == null || cPage.length() == 0)
            cPage = "1";
        Paging page = new Paging();
        page.setTotalRecord(p_service.allCount()); // 5개만 표현해야 함
        page.setNowPage(Integer.parseInt(cPage));
        PaymentDTO[] p_ar = p_service.paymentsList(String.valueOf(page.getBegin()),
        String.valueOf(page.getEnd()));
        mv.addObject("p_ar", p_ar);
        mv.addObject("page", page);
        mv.setViewName("/jsp/admin/etcList/book/bookList_ajax");
        return mv;
    }

}
