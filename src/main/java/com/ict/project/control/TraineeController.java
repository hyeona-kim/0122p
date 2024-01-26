package com.ict.project.control;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.ConfirmService;
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

	private String editor_img =	"/editor_img";
	private String upload_file = "/upload_file";


 /* 과정별 훈련생 현황 메뉴 */
	@RequestMapping("traincurrent")
	public ModelAndView traincurrent(String cPage) {
		ModelAndView mv = new ModelAndView();
		Paging page = new Paging();

		page.setTotalRecord(tc_Service.getCount());

		if(cPage == null)
			page.setNowPage(1);
		else{
			int nowPage = Integer.parseInt(cPage);
			page.setNowPage(nowPage);
		}

		CourseVO[] ar = tc_Service.getList(String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));

		mv.addObject("page", page);
		mv.addObject("ar", ar);

		mv.setViewName("jsp/admin/schoolRecord/TraineeCurrent");

		return mv;
	}
	
	
/* 훈련생 확인 서류 등록 메뉴 */
	@RequestMapping("trainupload")
	public ModelAndView trainupload(String cPage){
		ModelAndView mv = new ModelAndView();
		Paging page = new Paging(5,5);

		page.setTotalRecord(u_Service.getCount());

		if(cPage == null || cPage.length()==0 )
			page.setNowPage(1);
		else {
			int nowPage = Integer.parseInt(cPage);
			page.setNowPage(nowPage);
		}
		TrainuploadVO[] ar = u_Service.getList(String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));

		mv.addObject("page", page);
		mv.addObject("ar", ar);

		mv.setViewName("jsp/admin/schoolRecord/trainupload");

		return mv;

	}

		
/* 훈련생 서류 파일 등록 */
    @RequestMapping("uploadwrite")
    public String requestMethodName(TrainuploadVO tvo,MultipartFile file){
        String viewPath = null;
		String enc_type = request.getContentType();
		
		if(enc_type == null)
			viewPath = "jsp/admin/schoolRecord/uploadwrite";
		else if(enc_type.startsWith("multipart")) {
			viewPath = "redirect:trainupload";
			try {
				
				String realPath = application.getRealPath("/upload_file");
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
/* 
	@RequestMapping("trainuploadedit")
    public ModelAndView edit(TrainuploadVO tvo , String cPage){
        ModelAndView mv = new ModelAndView();

        String c_type = request.getContentType();

        if(c_type.startsWith("app")){
            
		    TrainuploadVO vo2 =u_Service.getUpload(tvo.getTn_idx());
		
		    mv.addObject("vo",vo2);
		
        }else if(c_type.startsWith("multipart")){
            MultipartFile f = tvo.getFile();
			
			if(f != null && f.getSize() >0 ) {
				
				String realPath = application.getRealPath(upload_file);
				
				String fname = f.getOriginalFilename();
				tvo.setOri_name(fname);
				
				fname = FileRenameUtil.checkSameFileName(fname, realPath);
				
				try {
					f.transferTo(new File(realPath, fname));
					tvo.setFile_name(fname);
					
				} catch (Exception e) {
					e.printStackTrace();
				}
        }
        tvo.setIp(request.getRemoteAddr());

        u_Service.edit(tvo);

        mv.setViewName("redirect:/TrainuploadEdit?tn_idx="+tvo.getTn_idx()+"&cPage="+cPage);


        
    }
        return mv;
    }

*/


	/* 훈련생 확인 서류 수정 */
    @RequestMapping("trainuploadedit")
    public ModelAndView trainuploadedit(TrainuploadVO tvo) {
        ModelAndView mv = new ModelAndView();
        String enc_type = request.getContentType();
		System.out.println("enc_type:----"+enc_type);
        String viewPath = null;
	
    
        if(enc_type !=null && enc_type.startsWith("application")) {
            TrainuploadVO vo = u_Service.getUpload(tvo.getTn_idx());// tn_idx
			mv.addObject("vo", vo);
            viewPath="jsp/admin/schoolRecord/TrainuploadEdit";

        }else if(enc_type !=null && enc_type.startsWith("multipart")){       
			MultipartFile f = tvo.getFile();       

				if(f != null && f.getSize() > 0){
            		String realPath = application.getRealPath(upload_file);
					String 	fname = f.getOriginalFilename();
					tvo.setOri_name(fname);

					fname = FileRenameUtil.checkSameFileName(fname, realPath);

					try {
						f.transferTo(new File(realPath, fname));
						tvo.setFile_name(fname);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				tvo.setIp(request.getRemoteAddr());
				int cnt =u_Service.edit(tvo);
				System.out.println(cnt);
            viewPath =("redirect:trainupload");
		}
		System.out.println(enc_type);
        mv.setViewName(viewPath);
		return mv;
    }
	

	/* 훈련생 확인 서류 삭제 */
    @RequestMapping("trainuploaddel")
    public ModelAndView trainuploaddel(String tn_idx ) {
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
        TrainuploadVO[] ar =u_Service.all();
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
    public ResponseEntity<Resource> traindownload(String fname) {
		String realPath = application.getRealPath("/upload_file/"+fname);
		
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
				
				fis = new FileInputStream(f);
				bis = new BufferedInputStream(fis);
				
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
		
		page.setTotalRecord(t_Service.getCount());
		
		if(cPage == null || cPage.length()==0) {
			page.setNowPage(1);
		}else {
			int nowPage = Integer.parseInt(cPage);
			page.setNowPage(nowPage);
			
		}
		
		TraineeVO[] tv = t_Service.getTraineeList(String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
		
		mv.addObject("ar", tv);
		mv.addObject("page", page);

        mv.setViewName( "jsp/admin/schoolRecord/traineecurrentbt1");
		return mv;
    }

	@RequestMapping("traineewrite")
	public ModelAndView traineewrite(String tr_idx){
		ModelAndView mv = new ModelAndView();

		TraineeVO vo = t_Service.view(tr_idx);
		
		mv.addObject("vo8", vo);
		
		mv.setViewName("jsp/admin/schoolRecord/Traineewrite");
		return mv;
	}


	@RequestMapping("traineeEdit")
	public ModelAndView traineeEdit(){
		ModelAndView mv = new ModelAndView();


		mv.setViewName("jsp/admin/schoolRecord/traineeEdit");

		return mv;
	}
	
	




    
}
