package com.ict.project.control;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonCreator.Mode;
import com.ict.project.service.ConfirmService;
import com.ict.project.service.TrainConfirmService;
import com.ict.project.service.TraineeCurrentService;
import com.ict.project.service.TraineeService;
import com.ict.project.service.UploadService;
import com.ict.project.util.FileRenameUtil;
import com.ict.project.util.Paging;
import com.ict.project.vo.CourseVO;
import com.ict.project.vo.TraineeVO;
import com.ict.project.vo.TrainuploadVO;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;



@Controller
public class TraineeController {
     @Autowired
    HttpServletRequest request;
    @Autowired
    HttpSession session;
    @Autowired
    ServletContext application;
    @Autowired
    HttpServletResponse response;
	@Autowired
	TraineeCurrentService tc_Service;
	@Autowired
	UploadService u_Service;
	@Autowired
	TraineeService t_Service;
	@Autowired
	ConfirmService cu_Service;

     @RequestMapping("traincurrent")
    public String traincurrent(String cPage) {
        Paging page = new Paging();
		
		page.setTotalRecord(tc_Service.getCount());
		
		if(cPage == null)
			page.setNowPage(1);
		else {
			int nowPage = Integer.parseInt(cPage);
			page.setNowPage(nowPage);
			
		}
		
		CourseVO[] ar = tc_Service.getList(String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
		
		request.setAttribute("page", page);
		request.setAttribute("ar", ar);
		
		return "jsp/admin/schoolRecord/TraineeCurrent";
    }
    
    @RequestMapping("trainupload")
    public String trainupload(String cPage) {
        Paging page = new Paging(5,5);
		
		page.setTotalRecord(u_Service.getCount());
		
		if(cPage == null || cPage.length()==0 )
			page.setNowPage(1);
		else {
			int nowPage = Integer.parseInt(cPage);
			page.setNowPage(nowPage);
		}
		TrainuploadVO[] ar = u_Service.getList(String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
		
		request.setAttribute("page", page);
		request.setAttribute("ar", ar);
		
		return "jsp/admin/schoolRecord/trainupload";
    }

    @RequestMapping("uploadwrite")
    public String requestMethodName(TrainuploadVO tvo,MultipartFile file){
        String viewPath = null;
		String enc_type = request.getContentType();
		
		if(enc_type == null)
			viewPath = "jsp/admin/schoolRecord/uploadwrite";
		else if(enc_type.startsWith("multipart")) {
			viewPath = "redirect:trainupload";
			try {
				
				String realPath = application.getRealPath("/ictedu_upload");
                String fname = null;
                String oname = null;
				if(file.getSize()>0){
                    oname =file.getOriginalFilename();
                    fname = FileRenameUtil.checkSameFileName(oname, realPath);
                    try {
                        file.transferTo(new File(realPath, fname));
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
				tvo.setFile_name(fname);
				tvo.setOri_name(oname);
				int cnt = u_Service.add(tvo);
	
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		return viewPath;
    }

    @RequestMapping("trainuploadedit")
    public ModelAndView trainuploadedit(TrainuploadVO tvo, MultipartFile file) {
        ModelAndView mv = new ModelAndView();
        String enc_type = request.getContentType();
        String viewPath = null;
    
        if(enc_type !=null && enc_type.startsWith("application")) {
            TrainuploadVO vo = u_Service.getUpload(tvo.getTn_idx());// tn_idx
        if(vo !=null)
            request.setAttribute("vo3", vo);
            viewPath="jsp/admin/schoolRecord/TrainuploadEdit";
        }else if(enc_type !=null && enc_type.startsWith("multipart")){             
            String realPath = application.getRealPath("/ictedu_upload");
            String fname = null;
            String oname = null;
            
            if(file.getSize()>0){
                oname = file.getOriginalFilename();
                fname = FileRenameUtil.checkSameFileName(oname, realPath);
                try {
                    
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
			tvo.setFile_name(fname);
			tvo.setOri_name(oname);
            int cnt = u_Service.edit(tvo);
            viewPath ="redirect:trainupload?tn_idx="+tvo.getTn_idx();
		}

        mv.setViewName(viewPath);
		return mv;
    }
    @RequestMapping("trainuploaddel")
    public ModelAndView requestMethodName(String tn_idx ) {
        ModelAndView mv = new ModelAndView();
		
		int cnt = u_Service.delete(tn_idx);
		mv.setViewName("redirect:trainupload");
        return mv;
    }
    @RequestMapping("trainconfirm")
    public ModelAndView trainconfirm(String cPage) {
        ModelAndView mv = new ModelAndView();
        Paging page = new Paging();
		
		page.setTotalRecord(u_Service.getCount());
		
		if(cPage == null)
			page.setNowPage(1);
		else {
			int nowPage = Integer.parseInt(cPage);
			page.setNowPage(nowPage);
			
		}
		
		CourseVO[] ar = tc_Service.getList(String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
		
		mv.addObject("page", page);
		mv.addObject("ar", ar);
		mv.setViewName("jsp/admin/schoolRecord/Trainconfirm");
        return mv;
    }
    @RequestMapping("confirm")
    public ModelAndView confirm() {
        ModelAndView mv = new ModelAndView();
        TraineeVO[] ar =t_Service.getTraineeList();
		if(ar !=null)
			mv.addObject("ar", ar);

		mv.setViewName("/jsp/admin/schoolRecord/confirm_ajax"); 
        return mv;
    }
    @RequestMapping("trainuploadview")
    public ModelAndView trainuploadview(String tn_idx) {
        ModelAndView mv = new ModelAndView();
		
		TrainuploadVO vo = u_Service.view(tn_idx);
		if(vo !=null) {
			mv.addObject("vo6", vo);
            mv.setViewName("jsp/admin/schoolRecord/trainuploadview");
		}

		return mv;
    }
    @RequestMapping("traindownload")
    public String traindownload(String fname) {
		String realPath = application.getRealPath("/ictedu_upload/"+fname);
		
		File f = new File(realPath);
		
		if(f.exists()) {
			byte[] buf = new byte[4096];
			int size = -1;
			
			
			BufferedInputStream bis = null;
			FileInputStream fis = null;
			
			BufferedOutputStream bos = null;
			
			ServletOutputStream sos = null;
			
			try {
				
				response.setContentType("application/x-msdownload");
				response.setHeader("Content-Disposition", "attachment;filename="+new String(fname.getBytes(),"8859_1"));
				
				sos = response.getOutputStream();
				bos = new BufferedOutputStream(sos);
				
				while((size =bis.read(buf)) != -1) {
					bos.write(buf,0,size);
					bos.flush();
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				try {
					if(fis !=null)
						fis.close();
					if(bis !=null)
						bis.close();
					if(sos !=null)
						sos.close();
					if(bos !=null)
						bos.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
			
		}
		return null;

    }
    @RequestMapping("traineecurrentbt1")
    public ModelAndView traineecurrentbt1(String cPage) {
        ModelAndView mv = new ModelAndView();
       Paging page = new Paging();
		
		//page.setTotalRecord(cu.getCount());
		
		if(cPage == null || cPage.length()==0) {
			page.setNowPage(1);
		}else {
			int nowPage = Integer.parseInt(cPage);
			page.setNowPage(nowPage);
			
		}
		
		//TraineeVO[] ar = t_Service.(String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
		
		request.setAttribute("page", page);
		//request.setAttribute("ar", ar);
        mv.setViewName( "jsp/admin/schoolRecord/traineecurrentbt1");
		return mv;
    }
    
}
