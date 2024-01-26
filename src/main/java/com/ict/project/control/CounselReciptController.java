package com.ict.project.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.CounselReceiptService;
import com.ict.project.service.EvaluationFactorService;
import com.ict.project.util.Paging;
import com.ict.project.vo.CounselReceiptVO;
import com.ict.project.vo.CourseVO;
import com.ict.project.vo.EvaluationFactorVO;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class CounselReciptController {
    @Autowired
    HttpServletRequest request;
	@Autowired
	HttpServletResponse response;
    @Autowired
    HttpSession session;

    @Autowired
    ServletContext application;

    @Autowired
    CounselReceiptService cr_Service;

    @Autowired
    EvaluationFactorService ef_Service;



    @RequestMapping("counselReceipt")
    public String counselReceipt(String listSelect) {
        String viewPath = null;
        if(listSelect.equals("1"))
            viewPath= "/jsp/admin/counselReceipt/counselReceipt";
        else if(listSelect.equals("2"))
            viewPath="/jsp/admin/counselReceipt/";
        else if(listSelect.equals("3"))
            viewPath= "/jsp/admin/counselReceipt/";
        
        return viewPath;
    }

     @RequestMapping("counselReceiptMain")
    public ModelAndView courseReceipt(String listSelect) {
        ModelAndView mv = new ModelAndView();
		
		CounselReceiptVO[] ar = null;
		ar = cr_Service.getCounselReceiptList();
		mv.addObject("ar", ar);
		if(listSelect.equals("1"))
			mv.setViewName("/jsp/admin/counselReceipt/counselReceipt_ajax");
		else if(listSelect.equals("2"))
            mv.setViewName("/jsp/admin/courseReg/");
		else if(listSelect.equals("3"))
            mv.setViewName("/jsp/admin/courseReg/"); 
        return mv;
    }

    @RequestMapping("cr_dialog")
    public ModelAndView c_dialog(String select,String cr_idx) {
        ModelAndView mv = new ModelAndView();
		
	
		CounselReceiptVO[] ar = cr_Service.getCounselReceiptList();
        EvaluationFactorVO[] ar2 = ef_Service.getEvaluationFactorList();
		mv.addObject("ar", ar);
		mv.addObject("ar", ar2);

		
		if(select.equals("addCounselReceipt"))
			mv.setViewName("/jsp/admin/counselReceipt/addCounselReceipt_ajax");
		else if(select.equals("editCounselReceipt"))
            mv.setViewName("/jsp/admin/counselReceipt/editCounselReceipt_ajax");
        else if(select.equals("counselReceipt_file"))
            mv.setViewName("/jsp/admin/counselReceipt/counselReceiptFile_ajax");
        else if(select.equals("evaluationFactor"))
            mv.setViewName("/jsp/admin/counselReceipt/evaluationFactor_ajax");

            CounselReceiptVO cro = cr_Service.getCounselReceipt(cr_idx);
            mv.addObject("cro",cro);
            return mv;
                
	}

    @RequestMapping("addCounselReceipt")
    public String addCounselReceipt(CounselReceiptVO cvo) {
        cr_Service.addCounselReceipt(cvo);
              
        return "redirect:counselReceipt?listSelect=1&cPage=1";
    }

    @RequestMapping("editCounselReceipt")
    public ModelAndView editCounselReceipt(CounselReceiptVO cvo, String edit, String cr_idx) {
        ModelAndView mv = new ModelAndView();
        if(edit == null){
            CounselReceiptVO vo = cr_Service.getCounselReceipt(cr_idx);
            request.setAttribute("edit_crvo", vo);
            
            mv.setViewName("/jsp/admin/counselReceipt/editCounselReceipt_ajax");
        }else{
            int cnt =cr_Service.editCounselReceipt(cvo);

            mv.setViewName("redirect:counselReceipt?listSelect=1&cPage=1");
        }
		return mv;
    }

    @RequestMapping("delCounselReceipt")
    public String delCounselReceipt(String cr_idx) {
        System.out.println("에러");
		int cnt = cr_Service.deleteCounselReceipt(cr_idx);
		
		return "redirect:counselReceipt?listSelect=1&cPage=1";
    }
}
