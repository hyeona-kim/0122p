package com.ict.project.control;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.CounselReceiptService;
import com.ict.project.service.CounselingdetailService;
import com.ict.project.service.CourseService;
import com.ict.project.service.CourseTypeService;
import com.ict.project.service.EvaluationFactorService;
import com.ict.project.service.InflowPathService;
import com.ict.project.service.NextscheduledService;
import com.ict.project.service.StaffService;
import com.ict.project.util.Paging;
import com.ict.project.vo.CounselReceiptVO;
import com.ict.project.vo.EvaluationFactorVO;
import com.ict.project.vo.InflowPathVO;
import com.ict.project.vo.NextscheduledVO;
import com.ict.project.vo.RoomVO;
import com.ict.project.vo.StaffVO;
import com.ict.project.vo.CounselingdetailVO;
import com.ict.project.vo.CourseTypeVO;
import com.ict.project.vo.CourseVO;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


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

    @Autowired
    NextscheduledService ns_Service;

    @Autowired
	StaffService s_Service;

    @Autowired
    CourseTypeService ct_Service;

    @Autowired
    CourseService c_Service;

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
             NextscheduledVO[] ar2 = ns_Service.getList();
             mv.addObject("ns_length", ar2.length);
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

        System.out.println("안들어옴"+listSelect);
        
		if(listSelect.equals("1"))
        mv.setViewName("/jsp/admin/counselReceipt/counselReceipt_ajax");
		else if(listSelect.equals("2")){
            System.out.println("들어옴");
            CounselingdetailVO[] cd_ad = null;
            cd_ad = cd_Service.getList();
            mv.addObject("cd_ad", cd_ad);
            mv.setViewName("/jsp/admin/counselReceipt/counselingDetail_ajax");
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
        NextscheduledVO[] ar4 = ns_Service.getList();
        StaffVO[] s_ar = s_Service.getList();
        CourseTypeVO[] ct_ar = ct_Service.getList();
        CourseVO[] c_ar = c_Service.getList();

		mv.addObject("ar", ar);
		mv.addObject("ar2", ar2);
		mv.addObject("ar3", ar3);
		mv.addObject("ar", ar4);
        mv.addObject("ct_ar", ct_ar);
        mv.addObject("s_ar", s_ar);
        mv.addObject("c_ar", c_ar);
		
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
        else if(select.equals("addNextscheduled"))
            mv.setViewName("/jsp/admin/counselReceipt/addNextscheduled_ajax");
        else if(select.equals("addCounselingDetail"))
            mv.setViewName("/jsp/admin/counselReceipt/addCounselingDetail_ajax");
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
		int cnt = cr_Service.deleteCounselReceipt(cr_idx);
		
		return "redirect:counselReceipt?listSelect=1&cPage=1";
    }

    @RequestMapping("delInflowPath")
    public String delInflowPath(String id_idx) {
		int cnt = id_Service.deleteInflowPath(id_idx);
		
		return "redirect:counselReceipt?listSelect=2&cPage=1";
    }

    @RequestMapping("delNextscheduled")
    public String delNextscheduled(String ns_idx) {
		int cnt = ns_Service.deleteNS(ns_idx);
		
		return "redirect:counselReceipt?listSelect=2&cPage=1";
    }

    @RequestMapping("addInflowPath")
    public ModelAndView addInflowPath(String[] InflowPathName, String listSelect) {
        ModelAndView mv = new ModelAndView();

        String[] id_name = InflowPathName;
		InflowPathVO vo = new InflowPathVO();
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

    
    @RequestMapping("addNextscheduled")
    public ModelAndView addNextscheduled(String[] nextscheduledName, String listSelect) {
        ModelAndView mv = new ModelAndView();

        String[] ns_name = nextscheduledName;
		NextscheduledVO vo = new NextscheduledVO();
		if(ns_name != null && !ns_name.equals("")) {
			for(int i = 0; i < ns_name.length;i++) {
				if(ns_name[i] != null && !ns_name[i].isEmpty()) {
					vo.setNs_name(ns_name[i]);
					vo.setNs_idx(Integer.toString(i+1));
					ns_Service.addNextscheduled(vo);
				}
				
			}
		}
        NextscheduledVO[] ns_ar = ns_Service.getList();
		mv.addObject("ns_ar", ns_ar);
        mv.setViewName("redirect:counselReceipt?listSelect=2&cPage=1");
		return mv;
    }

    @RequestMapping("addCounselingDetail")
    public String addCounselingDetail(CounselingdetailVO dvo) {
        cd_Service.add(dvo);
        
        return "redirect:counselReceipt?listSelect=2&cPage=1";
    }
    
    @RequestMapping("viewCounselingDetail")
    public String viewCounselingDetail(String cd_idx) {
        String viewPath = null;

        // c_idx를 기반으로 CourseVO 객체 가져오기
        CounselingdetailVO cvo = cd_Service.getCounselingDetail(cd_idx);

        request.setAttribute("select_cvo", cvo);

        viewPath ="redirect:counselReceipt&listSelect=2";

        return viewPath;
    }

    @RequestMapping("editCounselingDetail")
    public ModelAndView editCounselingDetail(CounselingdetailVO cvo, String edit, String cd_idx) {
        ModelAndView mv = new ModelAndView();

        
            if(edit == null){
                CounselingdetailVO vo = cd_Service.getCounselingDetail(cd_idx);
                StaffVO[] s_ar = s_Service.getList();
                CourseTypeVO[] ct_ar = ct_Service.getList();
                CourseVO[] c_ar = c_Service.getList();
                NextscheduledVO[] ns_ar = ns_Service.getList();
                InflowPathVO[] id_ar = id_Service.getList();
        
                mv.addObject("c_idx",vo.getC_idx());
                mv.addObject("sf_idx",vo.getSf_idx());
                mv.addObject("ns_idx",vo.getNs_idx());
                mv.addObject("id_idx",vo.getId_idx());
                
                mv.addObject("ct_ar", ct_ar);
                mv.addObject("s_ar", s_ar);
                mv.addObject("c_ar", c_ar);
                mv.addObject("ns_ar", ns_ar);
                mv.addObject("id_ar", id_ar);
            request.setAttribute("edit_cdvo", vo);
            
            mv.setViewName("/jsp/admin/counselReceipt/editCounselingDetail_ajax");
        }else{

            System.out.println(cvo.getCd_idx() + "/" + cd_idx);
            int cnt =cd_Service.editCounselingDetail(cvo);

            mv.setViewName("redirect:counselReceipt?listSelect=2&cPage=1");
        }
		return mv;
    }

}
