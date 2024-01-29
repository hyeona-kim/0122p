package com.ict.project.control;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.CounselReceiptService;
import com.ict.project.service.CounselingdetailService;
import com.ict.project.service.EvaluationFactorService;
import com.ict.project.service.InflowPathService;
import com.ict.project.util.Paging;
import com.ict.project.vo.CounselReceiptVO;
import com.ict.project.vo.EvaluationFactorVO;
import com.ict.project.vo.InflowPathVO;
import com.ict.project.vo.RoomVO;
import com.ict.project.vo.CounselingdetailVO;

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

    @Autowired
    CounselingdetailService cd_Service;

    @Autowired
    InflowPathService id_Service;



    @RequestMapping("counselReceipt")
    public ModelAndView counselReceipt(String listSelect) {
        ModelAndView mv = new ModelAndView();

        LocalDate now = LocalDate.now();
        mv.addObject("now", now);


        if(listSelect.equals("1"))
             mv.setViewName("/jsp/admin/counselReceipt/counselReceipt");
        else if(listSelect.equals("2")){
             mv.setViewName("/jsp/admin/counselReceipt/counselingDetail");
             InflowPathVO[] ar = id_Service.getList();
             mv.addObject("id_length", ar.length);
        }
        else if(listSelect.equals("3"))
             mv.setViewName("/jsp/admin/counselReceipt/");

        
        return mv;
    }

     @RequestMapping("counselReceiptMain")
    public ModelAndView courseReceipt(String listSelect) {
        ModelAndView mv = new ModelAndView();
		
		CounselReceiptVO[] ar = null;
		ar = cr_Service.getCounselReceiptList();
		mv.addObject("ar", ar);
		if(listSelect.equals("1"))
        mv.setViewName("/jsp/admin/counselReceipt/counselReceipt_ajax");
		else if(listSelect.equals("2")){
            mv.setViewName("/jsp/admin/counselReceipt/counselingDetail_ajax");

            CounselingdetailVO[] ar2 = null;
            ar2 = cd_Service.getCounselingdetailList();
            mv.addObject("ar", ar2);
            
        }
		else if(listSelect.equals("3"))
            mv.setViewName("/jsp/admin/counselReceipt/"); 
        return mv;
    }

    @RequestMapping("cr_dialog")
    public ModelAndView c_dialog(String select,String cr_idx) {
        ModelAndView mv = new ModelAndView();
		
	
		CounselReceiptVO[] ar = cr_Service.getCounselReceiptList();
        EvaluationFactorVO[] ar2 = ef_Service.getEvaluationFactorList();
        InflowPathVO[] ar3 = id_Service.getList();

		mv.addObject("ar", ar);
		mv.addObject("ar", ar2);
		mv.addObject("ar", ar3);

		
		if(select.equals("addCounselReceipt"))
			mv.setViewName("/jsp/admin/counselReceipt/addCounselReceipt_ajax");
		else if(select.equals("editCounselReceipt"))
            mv.setViewName("/jsp/admin/counselReceipt/editCounselReceipt_ajax");
        else if(select.equals("counselReceipt_file"))
            mv.setViewName("/jsp/admin/counselReceipt/counselReceiptFile_ajax");
        else if(select.equals("evaluationFactor"))
            mv.setViewName("/jsp/admin/counselReceipt/evaluationFactor_ajax");
        else if(select.equals("addInflowPath"))
            mv.setViewName("/jsp/admin/counselReceipt/addInflowPath_ajax");
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

    @RequestMapping("addInflowPath")
    public ModelAndView addInflowPath(String[] InflowPathName, String listSelect) {
        ModelAndView mv = new ModelAndView();

        String[] id_name = InflowPathName;
		InflowPathVO vo = new InflowPathVO();
	System.out.println("id_name="+id_name);
	System.out.println("id_name.length="+id_name.length);
		if(id_name != null && !id_name.equals("")) {
			for(int i = 0; i < id_name.length;i++) {
				if(id_name[i] != null && !id_name[i].isEmpty()) {
					vo.setId_name(id_name[i]);
					vo.setId_idx(Integer.toString(i+1));
					id_Service.addInflowPath(vo);
				}
				
			}
		}
        InflowPathVO[] id_ar = id_Service.getList();
		mv.addObject("id_ar", id_ar);
        mv.setViewName("redirect:counselReceipt?listSelect=2&cPage=1");
		return mv;
    }

    
}
