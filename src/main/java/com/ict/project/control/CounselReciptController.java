package com.ict.project.control;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.security.auth.Subject;

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
    CourseService c_Service;
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
        }else if(listSelect.equals("3"))
           mv.setViewName("/jsp/admin/counselReceipt/dailyReceipt");
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
        System.out.println("에러");
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

    @RequestMapping("dailyReceipt")
    public ModelAndView requestMethodName(String listSelect,String year) {
        ModelAndView mv = new ModelAndView();
        CourseVO[] ar = c_Service.reg_search("2024");
       
        List<String> ct_idx = new ArrayList<>();
        for(int i =0; i<ar.length; i++){
            ct_idx.add(ar[i].getCtvo().getCt_idx());
        }
        Set<String> set = new HashSet<>(ct_idx);
        ct_idx = new ArrayList<>(set);
        
        List<String> ct_name = new ArrayList<>();
        for(int i =0; i<ar.length; i++){
            ct_name.add(ar[i].getCtvo().getCt_name());
        }
        Set<String> set2 = new HashSet<>(ct_name);
        ct_name = new ArrayList<>(set2);
        

        int[] size = new int[ct_idx.size()];

        for(int i=0; i<ct_idx.size();i++){
            size[i] =0;
            for(int k=0; k<ar.length; k++){
                if(ct_idx.get(i).equals(ar[k].getCtvo().getCt_idx()))
                   size[i]++;
            }
        }
        System.out.println(size[0]);
        System.out.println(size[1]);
        mv.addObject("ct_size", size);
        mv.addObject("ct_name", ct_name);
        //모집중,교육중 구분하기 
        
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String now = formatter.format(new Date(System.currentTimeMillis()));
        try {
            Date today = new Date(formatter.parse(now).getTime());
            for(int i=0;i<ar.length;i++){
                Date ar_date = new Date(formatter.parse(ar[i].getStart_date()).getTime());
                int cm =ar_date.compareTo(today);
                if(cm >0){//모집중
                    ar[i].setC_reg(true);
                }else{ //교육중
                    ar[i].setC_reg(false);
                }
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        mv.addObject("c_ar", ar);
        //시수 구하기 
        for(int i=0; i<ar.length;i++){
            int hour = 0;
           if(ar[i].getSb_ar().length>0){
             for( int k=0; k<ar[i].getSb_ar().length;k++){
                hour += Integer.parseInt(ar[i].getSb_ar()[k].getHour());
             }
             ar[i].setTotal_hour(hour);
           }
        }
        mv.setViewName("/jsp/admin/counselReceipt/dailyReceipt_ajax");
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
}
