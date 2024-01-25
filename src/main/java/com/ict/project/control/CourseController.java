package com.ict.project.control;


import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.mapper.SkillMapper;
import com.ict.project.service.CourseService;
import com.ict.project.service.CourseTypeService;
import com.ict.project.service.FileService;
import com.ict.project.service.RoomService;
import com.ict.project.service.SkillService;
import com.ict.project.service.StaffService;
import com.ict.project.service.UpskillService;
import com.ict.project.util.LmsBean;
import com.ict.project.util.FileRenameUtil;
import com.ict.project.util.Paging;
import com.ict.project.vo.CourseTypeVO;
import com.ict.project.vo.CourseVO;
import com.ict.project.vo.FileVO;
import com.ict.project.vo.RoomVO;
import com.ict.project.vo.SkillVO;
import com.ict.project.vo.StaffVO;
import com.ict.project.vo.UpSkillVO;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;





@Controller
public class CourseController {
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
	CourseTypeService ct_Service;
	@Autowired
	RoomService r_Service;
	@Autowired
	StaffService s_Service;
	@Autowired
	UpskillService us_Service;
	@Autowired
	SkillService sk_Service;
	@Autowired
	FileService f_Service;

    @RequestMapping("course")
    public String course(String listSelect) {
        String viewPath = null;
        if(listSelect.equals("1"))
            viewPath= "/jsp/admin/courseReg/courselog";
        else if(listSelect.equals("2"))
            viewPath="/jsp/admin/courseReg/serve";
        else if(listSelect.equals("3"))
            viewPath= "/jsp/admin/courseReg/maketime";
        
        return viewPath;
    }

    @RequestMapping("addCourse")
    public String addCourse( CourseVO cvo) {
        c_Service.addCourse(cvo);
              
        return "redirect:course?listSelect=1&cPage=1";
    }
     @RequestMapping("delCourse")
    public String delCourse(String c_idx,String cPage) {
		if(cPage == null)
			cPage = "1";
		int cnt = c_Service.deleteCourse(c_idx);
		
		return "redirect:course?listSelect=1&cPage="+cPage;
    }
    
    @RequestMapping("editCourse")
    public ModelAndView editCourse(CourseVO cvo,String edit) {
		ModelAndView mv = new ModelAndView();
		
        if(edit == null) {
			CourseVO vo = c_Service.getCourse(cvo.getC_idx());
			request.setAttribute("edit_cvo", vo);
			CourseTypeVO[] ct_ar = ct_Service.getList();
			RoomVO[] r_ar = r_Service.getList();
			StaffVO[] s_ar = s_Service.getList();
			
			mv.addObject("c_ar", ct_ar);
			mv.addObject("r_ar", r_ar);
			mv.addObject("s_ar", s_ar);
			mv.addObject("r_idx",vo.getR_idx());
			mv.addObject("sf_idx",vo.getSf_idx());
			mv.addObject("ct_idx",vo.getCt_idx());
			if(vo.getC_day()!= null){
				if(vo.getC_day().contains("월"))
					mv.addObject("monday",true);
				if(vo.getC_day().contains("화"))	
					mv.addObject("tuesday",true);
				if(vo.getC_day().contains("수"))	
					mv.addObject("wednesday",true);
				if(vo.getC_day().contains("목"))	
					mv.addObject("thursday",true);
				if(vo.getC_day().contains("금"))	
					mv.addObject("friday",true);
				if(vo.getC_day().contains("토"))	
					mv.addObject("saturday",true);
				if(vo.getC_day().contains("일"))	
					mv.addObject("sunday",true);
			}		
			mv.setViewName("/jsp/admin/courseReg/editCourse_ajax");
        }else{
            int cnt =c_Service.editCourse(cvo);
            mv.setViewName("redirect:course?listSelect=1&cPage=1");
        }
		return mv;
    }
    
    @RequestMapping("viewCourse")
    public String viewCourse(String c_idx) {
        String viewPath = null;

        // c_idx를 기반으로 CourseVO 객체 가져오기
        CourseVO vo = c_Service.getCourse(c_idx);
      
        request.setAttribute("select_vo", vo);

        viewPath ="redirect:course&listSelect=1";

        return viewPath;
    }

    @RequestMapping("searchCourse")
    public ModelAndView searchCourse(String num,String year,String select,String value,String listSelect,String cPage){
		if(value.trim().length()==0){
			value= null;
		}
		if(year.equals("년도선택"))
			year = null;
		if(num.equals("표시개수"))
			num = null;
		ModelAndView mv = new ModelAndView();
		Paging page = null;
		if(num!=null && num.length()>0 )
			page = new Paging(Integer.parseInt(num),5);
		else 
			page = new Paging();
		

		if(value == null || value.length()<1) {
			value = null;
		}
		if(select == null || select.length()<1){
			select = null;
		}
		
		if(year == null || year.length()==0) {
			year = null;
		}
		page.setTotalRecord(c_Service.getSearchCount(select, value, year));
		page.setNowPage(Integer.parseInt(cPage));
		
		CourseVO[] ar = c_Service.searchCourse(select,value,year,String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
	
		mv.addObject("ar", ar);
		mv.addObject("page", page);

		
		//비동기 통신할 jsp로 보내기
		if(listSelect.equals("1"))
            mv.setViewName("/jsp/admin/courseReg/courseLog_ajax");
		else if(listSelect.equals("2"))
            mv.setViewName("/jsp/admin/courseReg/serve_ajax");

		else if(listSelect.equals("3"))
            mv.setViewName("/jsp/admin/courseReg/makeTime_ajax");
        return mv;
	}

    @RequestMapping("addCourseType")
    public ModelAndView addCourseType(String[] name,String[] text, String listSelect) {
        ModelAndView mv = new ModelAndView();
        String[] ct_name = name;
		String[] ct_color =text;
		CourseTypeVO vo = new CourseTypeVO();
		
		if(ct_name != null && !ct_name.equals("")) {
			for(int i = 0; i < ct_name.length;i++) {
				if(ct_name[i] != null && !ct_name[i].isEmpty()) {
					vo.setCt_name(ct_name[i]);
					vo.setCt_color(ct_color[i]);
					vo.setCt_idx(Integer.toString(i+1));
					ct_Service.addCourseType(vo);
				}
				
			}
		}
		mv.setViewName("redirect:course?listSelect="+listSelect);
        return mv;
    }
    @RequestMapping("courseMain")
    public ModelAndView courseMain(String listSelect, String cPage) {
        ModelAndView mv = new ModelAndView();
		if(cPage == null){
			cPage = "1";
		}
		// cPage와 listSelect를 받아서 이를 통해 paging객체 만들기.
		Paging page = new Paging();
		page.setTotalRecord(c_Service.getCount());
		page.setNowPage(Integer.parseInt(cPage));
		CourseVO[] ar = null;
		ar = c_Service.getCourseList(String.valueOf(page.getBegin()),String.valueOf(page.getEnd()));
		mv.addObject("ar", ar);
		mv.addObject("page", page);
		if(listSelect.equals("1"))
			mv.setViewName("/jsp/admin/courseReg/courseLog_ajax");
		else if(listSelect.equals("2"))
            mv.setViewName("/jsp/admin/courseReg/serve_ajax");
		else if(listSelect.equals("3"))
            mv.setViewName("/jsp/admin/courseReg/makeTime_ajax"); 
		else
            mv.setViewName("/jsp/admin/courseReg/courseLog_ajax");	
		
        return mv;
    }
    @RequestMapping("addRoom")
    public String addRoom(String[] className,String[] roomSep,String[] use,String listSelect) {
       
        String[] r_name = className;
		String[] r_sep = roomSep;
		String[] r_status = use;
		RoomVO vo = new RoomVO();
		
		if(r_name != null && !r_name.equals("")) {
			for(int i = 0; i < r_name.length;i++) {
				if(r_name[i] != null && !r_name[i].isEmpty()) {
					vo.setR_name(r_name[i]);
					vo.setR_sep(r_sep[i]);
					vo.setR_status(r_status[i]);
					vo.setR_idx(Integer.toString(i+1));
					r_Service.addRoom(vo);
				}
				
			}
		}
		return "redirect:course&listSelect="+listSelect;
    }
    @RequestMapping("c_dialog")
    public ModelAndView c_dialog(String select,String c_idx) {
        ModelAndView mv = new ModelAndView();
		
	
		CourseTypeVO[] ct_ar = ct_Service.getList();
		RoomVO[] r_ar = r_Service.getList();

		StaffVO[] s_ar = s_Service.getList();
		mv.addObject("c_ar", ct_ar);
		mv.addObject("r_ar", r_ar);
		mv.addObject("s_ar", s_ar);
		
		if(select.equals("addCourse"))
			mv.setViewName("/jsp/admin/courseReg/addCourse_ajax");
		else if(select.equals("addCourseType"))
            mv.setViewName("/jsp/admin/courseReg/addCourseType_ajax");
		else if(select.equals("addRoom"))
            mv.setViewName("/jsp/admin/courseReg/addRoom_ajax");
		else if(select.equals("editCourse"))
            mv.setViewName("/jsp/admin/courseReg/editCourse_ajax");
		else if(select.equals("addUpskill"))
            mv.setViewName("/jsp/admin/courseReg/addUpskill_ajax");

    else if(select.equals("updateSubject"))
            mv.setViewName("/jsp/admin/courseReg/subject");
    CourseVO cvo = c_Service.getCourse(c_idx);
    mv.addObject("cvo",cvo);
    return mv;
		
	}
@RequestMapping("upskill")
    public ModelAndView upskill(String skill) {
        ModelAndView mv = new ModelAndView();
		if(skill == null){
			UpSkillVO[] ar = null;
			ar = us_Service.getUpskillList();
			mv.addObject("ar", ar);
			mv.setViewName("/jsp/admin/courseReg/upskill");
			
		}else{
			SkillVO[] ar2 = null;
			ar2 = sk_Service.getSkillList();
			
			System.out.println(ar2.length);
			
			mv.addObject("ar2", ar2);
			mv.setViewName("/jsp/admin/courseReg/addUpskill_ajax");

		}


        return mv;
    }

    @RequestMapping("downloadSubject")
	public String download() {
		//b_idx, cPage, file_name, bname 이 넘어온다 
		//파일들이 위치하는 곳 
		String realPath = application.getRealPath("sample.xls");
		System.out.println(realPath);
		File f = new File(realPath);
		if(f.exists() && f.isFile()){
			//파일이 존재 할 경우.
			//System.out.println(realPath);
			byte[] buf = new byte[4069];
			int size = -1;
			//다운로드의 필요한 스트림 준비 !
			BufferedInputStream bis = null;
			FileInputStream fis = null;
			BufferedOutputStream bos  = null;
			ServletOutputStream sos = null;

			try {
				//접속자 화면에 다운로드창 
				response.setContentType("application/vnd.ms-excel");
				response.setHeader("Content-Disposition", 
							"attachment;filename="+new String("sample.xls".getBytes(),"8859_1"));
				//스트림 초기화 
				bis = new BufferedInputStream(fis = new FileInputStream(f));
				bos = new BufferedOutputStream(sos= response.getOutputStream());
				while((size= bis.read(buf))!= -1) {
					bos.write(buf, 0, size);
					bos.flush();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally{
				try{
					if(fis != null)
						fis.close();
					if(bis != null)
						bis.close();
					if(sos != null)
						sos.close();
					if(bos != null)
						bos.close();
				}catch(Exception e){}
			}
		}
		return null;
	}
    @RequestMapping("course_file")
    public ModelAndView course_file(FileVO fvo,String listSelect){
        ModelAndView mv = new ModelAndView();
		String encType = request.getContentType();
		if(encType.startsWith("application")){
			CourseVO cvo = c_Service.getCourse(fvo.getC_idx());

			FileVO[] ar =  f_Service.getList(fvo.getC_idx());
			mv.addObject("fvo",ar);
			mv.addObject("cvo",cvo);
			mv.setViewName("/jsp/admin/courseReg/courseFile_ajax");
		}else if(encType.startsWith("multipart")){
			String realPath = application.getRealPath("upload_courseFile");
			String c_idx = fvo.getC_idx();
			
			String[] f_info = fvo.getF_info().split(",");
			
			MultipartFile[] f_ar = new MultipartFile[6];
			f_ar[0] = fvo.getFile1();
			f_ar[1] = fvo.getFile2();
			f_ar[2] = fvo.getFile3();
			f_ar[3] = fvo.getFile4();
			f_ar[4] = fvo.getFile5();
			f_ar[5] = fvo.getFile6();

			if(fvo.getF_idx() == null || fvo.getF_idx().length()==5){
				//파일이 존재하지 않는 경우
				
				for(int i =0; i<f_info.length; i++){
					if(f_ar[i].getSize() > 0){
						String fname = FileRenameUtil.checkSameFileName(f_ar[i].getOriginalFilename(),realPath);

						try {
							f_ar[i].transferTo(new File(realPath,fname));//파일 업로드 
						} catch (Exception e) {
							e.printStackTrace();
						}
						fvo.setF_name(fname);
					}
						fvo.setF_info(f_info[i]);
						f_Service.addFile(fvo);
						//fvo가 이전의 파일명을 가지고 또 저장하기때문에 중복되는걸 막고자 fvo를 초기화 한다.
						fvo = new FileVO();
						fvo.setC_idx(c_idx);
						if(i<f_info.length-1)
							fvo.setF_info(f_info[i+1]);
				}		
			}else{
				//파일 존재 
				String[] f_idx = fvo.getF_idx().split(",");
				for(int i =0; i<f_info.length; i++){
	
					
					if(f_ar[i].getSize()>0){
						String fname = FileRenameUtil.checkSameFileName(f_ar[i].getOriginalFilename(),realPath);
						try {
							f_ar[i].transferTo(new File(realPath,fname)); //파일 업로드 
						} catch (Exception e) {
							e.printStackTrace();
						}
						fvo.setF_idx(f_idx[i]);
						fvo.setF_name(fname);
						f_Service.editFile(fvo);
					}
				}
			}
			mv.setViewName("redirect:course?listSelect="+listSelect+"&cPage=1");
		}

		return mv;
    }
	@RequestMapping("coursefileDown")
	public String coursefileDown(FileVO fvo) {
		String filename = fvo.getF_name();
		String realPath = request.getServletContext().getRealPath("upload_courseFile");
		//System.out.println(realPath);
		String fullPath = realPath+System.getProperty("file.separator")+filename;
		
		File f= new File(fullPath);
		if(f.exists() && f.isFile()){
			byte[] buf = new byte[2048];
			
			BufferedInputStream bis = null;
			BufferedOutputStream bos =null;
			FileInputStream fis = null;
			ServletOutputStream sos  = null;
			try {
				response.setContentType("application/x-msdownload");
				response.setHeader("Content-Disposition", "attachment;filename=" +new String(filename.getBytes(),"8859_1"));
				fis = new FileInputStream(f);
				bis = new BufferedInputStream(fis);
				// 응답 객체를 통해 output스트림 생성
				sos = response.getOutputStream();
				bos = new BufferedOutputStream(sos);
				int size = -1;
				while((size = bis.read(buf)) != -1) {
					bos.write(buf,0,size);
					bos.flush();
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				try {
					if(fis!= null)
						fis.close();
					if(bis != null) 
						bis.close();
					if(sos != null)
						sos.close();
					if(bos != null)
						bos.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}

		}
		return null;
	}
    
}
