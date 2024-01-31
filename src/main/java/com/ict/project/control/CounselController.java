package com.ict.project.control;

import java.io.File;
import java.io.FileInputStream;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.util.IOUtils;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.CounselAddService;
import com.ict.project.service.CounselService;
import com.ict.project.service.CourseService;

import com.ict.project.service.StaffService;

import com.ict.project.service.TraineeService;
import com.ict.project.util.FileRenameUtil;
import com.ict.project.util.Paging;
import com.ict.project.vo.CounselAddVO;
import com.ict.project.vo.CounselVO;
import com.ict.project.vo.CourseVO;


import com.ict.project.vo.TraineeVO;


import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class CounselController {
    @Autowired
    HttpServletRequest request;
    @Autowired
    HttpSession session;
    @Autowired
    ServletContext application;
    @Autowired
    CounselService cs_Service;
    @Autowired
    CounselAddService ca_Service;
    @Autowired
    CourseService c_Service;
    @Autowired
    StaffService s_service;
    @Autowired
    TraineeService t_Service;
    




    @RequestMapping("counsel")
    public String counsel(String listSelect) {
        String viewPath = null;
        if(listSelect.equals("1"))
            viewPath= "/jsp/admin/counselManage/counselTypeList";
        else if(listSelect.equals("2"))
            viewPath="/jsp/admin/counselManage/counselDateList";
        else if(listSelect.equals("3")){
            viewPath= "/jsp/admin/counselManage/counselTraineeSearch";
        } else if(listSelect.equals("4"))
            viewPath= "/jsp/admin/counselManage/counselTraineeInput";
        
        return viewPath;
    }

    @RequestMapping("addCounselFile")
    public ModelAndView addCounsel(MultipartFile addFile) {
		ModelAndView mv = new ModelAndView();
		String realPath = application.getRealPath("subject_ex_upload");
		if(addFile.getSize()>0){
			String fname = addFile.getOriginalFilename();
			fname = FileRenameUtil.checkSameFileName(fname, realPath);
			try {
				File f = new File(realPath,fname);
				addFile.transferTo(f);
				FileInputStream fis = new FileInputStream(f.getAbsolutePath());
				IOUtils.setByteArrayMaxOverride(Integer.MAX_VALUE);
				XSSFWorkbook workbook = new XSSFWorkbook(fis);
				XSSFSheet sheet = workbook.getSheetAt(0);
				
				Iterator<Row> it = sheet.iterator();
				List<CounselVO> list = new ArrayList<CounselVO>();
					while(it.hasNext()) {
						Row row = it.next();
						// 첫번째 행은 머릿글이므로 제외
						if(row.getRowNum()==0)
							continue;
						//cell들을 한번에 반복자로 얻어낸다.
						Iterator<Cell> it2 = row.cellIterator();
						CounselVO vo = new CounselVO();
						int i=0;
						while(it2.hasNext()) {
							//하나의 cell을 얻어낸다 
							Cell cell = it2.next();
							String val = null;
							switch (cell.getCellType()) {
								case NUMERIC:
                                    if(DateUtil.isCellDateFormatted(cell))			
                                        val = new SimpleDateFormat("yyyy-MM-dd").format(cell.getDateCellValue());			
                                    else
									    val = String.valueOf((int)cell.getNumericCellValue());
									break;
								case STRING:
									val = cell.getStringCellValue();
									break;
								case BLANK:
									val = null;
								default:
									val = null;
									break;
							}//switch문의 끝

							switch(i) {
								case 0:
									vo.setC_idx(val); // 과정코드
									break;
								case 1:
									vo.setTr_idx(val); // 훈련생코드
									break;
								case 2:
									vo.setSo_day(val); // 상담일    
									break;
								case 3:
									vo.setSo_tname(val); // 상담자
									break;
								case 4:
									vo.setSo_menu(val); // 상담종류
									break;
								case 5:
                                    vo.setSo_pd(val); // 상담목적
                                    break;
								case 6:
                                    vo.setSo_subject(val); // 상담내용
									break;
                                case 7:
                                    vo.setSo_pp(val);
								default:
									break;
                            }
                            i++;
                        }// 열반복의 끝
                        vo.setSf_idx(c_Service.getCourse(vo.getC_idx()).getSf_idx());
                        if(vo.getSo_day() != null  && vo.getSo_day().trim().length() > 0) { // 상담일(필수값)의 값이 들어있지 않다면 list에 저장할 필요가 x
                            t_Service.setCounsel_date(vo.getTr_idx(), vo.getSo_day(), Integer.toString(cs_Service.counselCount(vo.getTr_idx()))); // 상담일 최신화
                            list.add(vo); //리스트에 저장
                        }
					}//행 반복의 끝
					// 리스트에 있는 정보들을 db에 저장하기위해

					HashMap<String,List<CounselVO>> map = new HashMap<>();
					map.put("list", list);
					cs_Service.addCounselFile(map);
					

					fis.close();
					workbook.close();
					f.delete(); //파일 삭제
			} catch (Exception e) {
				e.printStackTrace();
			}
				
		}
		mv.setViewName("redirect:counsel?listSelect=1&cPage=1"); // 첫 화면으로 돌아가기
        return mv;
    
    }
     @RequestMapping("delCounsel")
    public String delCounsel(String so_idx,String cPage) {
      
      cs_Service.deleteCounsel(so_idx);
      
      return "redirect:counsel?listSelect=2&cPage="+cPage;
    }
    
    @RequestMapping("editCounsel")
    public String editCounsel(CounselVO vo,String listSelect, String cPage) {
        String viewName = "";
        if(vo.getSo_day() != null && vo.getSo_day().trim().length() > 0){
            if(listSelect.equals("3")) {
                cs_Service.editCounsel(vo);
                viewName =  "redirect:searchCounsel?listSelect=3";
            }else{
                cs_Service.editCounsel(vo);
                viewName = "redirect:counsel?listSelect=4&cPage="+cPage+"&c_idx="+vo.getC_idx();
            }
        } else {
            viewName = "redirect:counsel?listSelect=1&cPage=1";
        }

        return viewName;
    }


    @RequestMapping("counselTraineeInput")
    public ModelAndView counselTraineeInput(String c_idx){
        ModelAndView mv = new ModelAndView();

        mv.addObject("c_idx", c_idx);
        mv.setViewName("/jsp/admin/counselManage/counselTraineeInput");

        return mv;
    }


    //상담결과보고 리스트 
    @RequestMapping("counselAddMain")
    public ModelAndView counselAddMain(String c_idx) {
        ModelAndView mv = new ModelAndView();
        
        CourseVO cvo = c_Service.getCourse2(c_idx);
        CounselAddVO[] ar = ca_Service.list(c_idx);
        mv.addObject("c_idx", c_idx);
        mv.addObject("ar", ar);
        if(ar != null)
            mv.addObject("ss_cnt", ar.length);
        mv.addObject("cvo", cvo);
        mv.setViewName("jsp/admin/counselManage/counselAddMain_ajax");
       
        return mv;
    }
    
    @RequestMapping("counselsave")
    public ModelAndView counselsave(CounselAddVO vo,MultipartFile ss_img1, String ss_day1, String ss_day2) {
        ModelAndView mv = new ModelAndView();
        String realPath = application.getRealPath("counselimg");
        if(ss_img1 != null && ss_img1.getSize() > 0){

            String f_name = FileRenameUtil.checkSameFileName(ss_img1.getOriginalFilename(), realPath);//이름바꿔준거 
            try {//파일업로드 
                ss_img1.transferTo(new File(realPath,f_name));
    
            } catch (Exception e) {
                 e.printStackTrace();
            }
            vo.setSs_img(f_name);
        }
        if(vo.getSs_mday() !=null && vo.getSs_mday().trim().length() >0 && vo.getSs_cnt() !=null && vo.getSs_cnt().trim().length()>0){

            vo.setSs_day(ss_day1 + "~" + ss_day2);
            int cnt = ca_Service.add(vo);

        }
      mv.setViewName("redirect:counsel?listSelect=1&cPage=1");

        
        return mv;
    }

    //보고서등록버튼, 상담결과보고서등록페이지 이동
    @RequestMapping("counselA")
    public ModelAndView counselA(String c_idx){
        ModelAndView mv = new ModelAndView();
        CounselAddVO[] vo = ca_Service.list(c_idx);
        CourseVO cvo = c_Service.getCourse2(c_idx);
        if(vo !=null && vo.length >0)
            mv.addObject("ss_cnt",vo.length);
        else
            mv.addObject("ss_cnt",0); 
        mv.addObject("vo", vo);
        mv.addObject("cvo", cvo);
        mv.setViewName("/jsp/admin/counselManage/counselAdd");
        
        return mv;  
    }

    
    @RequestMapping("searchCounsel")
    public ModelAndView searchCourse(String num,String year,String select,String value,String listSelect,String cPage, String c_idx){
        if(cPage == null || cPage.trim().length() < 1)
            cPage = "1";
      if(value.trim().length()==0){
         value= null;
      }
      if(year.equals("년도선택"))
         year = null;
      if(num.equals("표시개수"))
         num = null;
      ModelAndView mv = new ModelAndView();
      Paging page = null;
      if(num!=null && num.length()>0 ) {
            page = new Paging(Integer.parseInt(num),5);
        }
      else {
            page = new Paging();
        }
      

      if(value == null || value.length()<1) {
        value = null;
        select = null;
      }
      if(select == null || select.length()<1){
         select = null;
      }
      
      if(year == null || year.length()==0) {
          year = null;
        }
        //비동기 통신할 jsp로 보내기
        if(listSelect.equals("1")) {
            
            mv.setViewName("/jsp/admin/counselManage/counselTypeList_ajax");
            CourseVO[] ar = null;
            if(value == null){
                page.setTotalRecord(c_Service.getCount());
                page.setNowPage(Integer.parseInt(cPage));
                ar= c_Service.getCourseList(String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
            }else{
                page.setTotalRecord(c_Service.getSearchCount(select, value, year));
                page.setNowPage(Integer.parseInt(cPage));
                ar = c_Service.searchCourse(select,value,year,String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
            }
            
            mv.addObject("ar", ar);
            mv.addObject("page", page);
        } else if(listSelect.equals("2")){
            mv.setViewName("/jsp/admin/counselManage/counselDateList_ajax");
            page.setTotalRecord(cs_Service.getSearchCount(select, value, year));
            page.setNowPage(Integer.parseInt(cPage));
            CounselVO[] ar = cs_Service.searchCounsel(select,value,year,String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
            
            mv.addObject("ar", ar);
            mv.addObject("page", page);
        } else if(listSelect.equals("3")) {
            mv.setViewName("/jsp/admin/counselManage/counselTraineeSearch_ajax");
            TraineeVO[] ar = null;
            if(c_idx != null && value == null){
                page.setTotalRecord(t_Service.getCourseTraineeCount(c_idx));
                page.setNowPage(Integer.parseInt(cPage));
                ar = t_Service.getCourseTraineeList(c_idx, String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
                mv.addObject("ar", ar);
                mv.addObject("page", page);
                mv.addObject("c_idx", c_idx);
            } else {
                page.setTotalRecord(t_Service.getCourseSearchCount(select, value, year));
                page.setNowPage(Integer.parseInt(cPage));
                ar = t_Service.getCourseTraineeSearchList(select,value,year,String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
        
                mv.addObject("ar", ar);
                mv.addObject("page", page);

            }
        }  else if(listSelect.equals("4")) {
            mv.setViewName("/jsp/admin/counselManage/counselTraineeInput_ajax");
            TraineeVO[] ar = null;
            page.setTotalRecord(t_Service.getCourseSearchValueCount(c_idx, select, value, year));
            page.setNowPage(Integer.parseInt(cPage));
            ar = t_Service.getCourseTraineeSearchValueList(c_idx, select,value,year,String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
    
            mv.addObject("ar", ar);
            mv.addObject("page", page);
            mv.addObject("c_idx", c_idx);
        }
        return mv;
   }

    @RequestMapping("counselMain")
    public ModelAndView counselMain(String listSelect, String cPage, String c_idx) {
        ModelAndView mv = new ModelAndView();
      if(cPage == null)
            cPage = "1";
      // cPage와 listSelect를 받아서 이를 통해 paging객체 만들기.
        
        
      Paging page = new Paging();
      if(listSelect.equals("1")) {
            mv.setViewName("/jsp/admin/counselManage/counselTypeList_ajax");
            page.setTotalRecord(c_Service.getCount());
            page.setNowPage(Integer.parseInt(cPage));
            CourseVO[] ar = null;
            ar = c_Service.getCourseList(String.valueOf(page.getBegin()),String.valueOf(page.getEnd()));
            
            mv.addObject("ar", ar);
            mv.addObject("page", page);
            
        }
      else if(listSelect.equals("2")){
            mv.setViewName("/jsp/admin/counselManage/counselDateList_ajax");
            page.setTotalRecord(cs_Service.getCount());
            page.setNowPage(Integer.parseInt(cPage));
            CounselVO[] ar = cs_Service.getCounselList(String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
            mv.addObject("ar", ar);
            mv.addObject("page", page);
        }
        else if(listSelect.equals("3")){
            mv.setViewName("/jsp/admin/counselManage/counselTraineeSearch_ajax");
            TraineeVO[] ar = null;
            if(c_idx != null){
                
                page.setTotalRecord(t_Service.getCourseTraineeCount(c_idx));
                page.setNowPage(Integer.parseInt(cPage));
                ar = t_Service.getCourseTraineeList(c_idx, String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
                mv.addObject("ar", ar);
                mv.addObject("page", page);
                mv.addObject("c_idx", c_idx);
            } else {
                ar = null;
                mv.addObject("ar", ar);
            }
            
        }else if(listSelect.equals("4")){
            mv.setViewName("/jsp/admin/counselManage/counselTraineeInput_ajax");
            TraineeVO[] ar = null;
            page.setTotalRecord(t_Service.getCourseTraineeCount(c_idx));
            page.setNowPage(Integer.parseInt(cPage));
            ar = t_Service.getCourseTraineeList(c_idx, String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
            mv.addObject("ar", ar);
            mv.addObject("page", page);
            mv.addObject("c_idx", c_idx);
        }else
            mv.setViewName("/jsp/admin/counselManage/counselTypeList_ajax");   
        
        return mv;
    }
    
    @RequestMapping("ss_dialog")
    public ModelAndView ss_dialog(String select,String c_idx, String tr_idx, String so_idx){
        ModelAndView mv = new ModelAndView();
        

        if(select.equals("addCounselFile"))
            mv.setViewName("/jsp/admin/counselManage/addCounselFile_ajax");
        else if(select.equals("counselAddMain"))
            mv.setViewName("/jsp/admin/counselManage/counselAddMain_ajax"); 
        else if(select.equals("uploadAllCounsel")) {
            mv.setViewName("/jsp/admin/counselManage/uploadAllCounsel_ajax");       
            CourseVO cvo = c_Service.getCourse2(c_idx);
            mv.addObject("cvo", cvo);
            TraineeVO[] vo = t_Service.clist(c_idx, null, null);
            mv.addObject("ar", vo);
        }
        else if(select.equals("counselList")){
            mv.setViewName("/jsp/admin/counselManage/counselList_ajax");
            CourseVO cvo = c_Service.getCourse2(c_idx);
            TraineeVO tvo = t_Service.view(tr_idx);
            CounselVO[] ar = cs_Service.counselList(tr_idx);    
            tvo.setSs_num(Integer.toString(cs_Service.counselCount(tr_idx)));
            mv.addObject( "cvo", cvo);
            mv.addObject("tvo", tvo);
            mv.addObject("ar", ar);
            
        }
        else if(select.equals("counselListAdd")){

        mv.setViewName("/jsp/admin/counselManage/counselListAdd_ajax");
        CourseVO cvo = c_Service.getCourse2(c_idx);
        TraineeVO tvo = t_Service.view(tr_idx);
        tvo.setSs_num(Integer.toString(cs_Service.counselCount(tr_idx)));
        mv.addObject("tvo",tvo);
        mv.addObject("cvo",cvo );
       

            mv.setViewName("/jsp/admin/counselManage/counselListAdd_ajax");

      } else if(select.equals("editCounsel")){
            mv.setViewName("/jsp/admin/counselManage/counselEdit_ajax");


            CounselVO vo = cs_Service.getCounsel(so_idx);
            mv.addObject("ss_num", cs_Service.counselCount(tr_idx));
            mv.addObject("vo", vo);
      }

        return mv;
    }
        

    
        
    
  
    @RequestMapping("counselTraineeSearch")
    public ModelAndView counselTraineeSearch(String value){
        ModelAndView mv = new ModelAndView();
        if(value == null || value.trim().length() < 1)
            value = null;
        mv.addObject("value", value);
        mv.setViewName("/jsp/admin/counselManage/counselTraineeSearch");

        return mv;
    }


    @RequestMapping("counselDateSearch")
    public ModelAndView counselDateSearch(String value){
        ModelAndView mv = new ModelAndView();
        if(value == null || value.trim().length() < 1)
            value = null;
        mv.addObject("value", value);
        mv.setViewName("/jsp/admin/counselManage/counselDateList");

        return mv;
    }

    @RequestMapping("uploadAllCounsel")
    public ModelAndView addAllCounsel(String[] date, String[] sf_name, String[] sf_idx, String[] select, String[] so_pp, String[] so_subject, String[] so_pd, String c_idx, String[] tr_idx){
        ModelAndView mv = new ModelAndView();
        CounselVO vo = new CounselVO();
        String ss_end;
        String ss_num;
        if(date != null && date.length > 0){
            for(int i = 0;i < date.length; i++){
                if(date[i] != null && date[i].trim().length() > 0){
                    vo.setC_idx(c_idx);
                    vo.setSo_day(date[i]);
                    vo.setTr_idx(tr_idx[i]);
                    vo.setSo_menu(select[i]);
                    vo.setSo_pp(so_pp[i]);
                    vo.setSo_subject(so_subject[i]);
                    vo.setSo_pd(so_pd[i]);
                    vo.setSo_tname(sf_name[i]);
                    vo.setSf_idx(sf_idx[i]);
                    cs_Service.addCounsel(vo);
                    ss_end = date[i];
                    ss_num = Integer.toString(cs_Service.counselCount(tr_idx[i]));
                    t_Service.setCounsel_date(tr_idx[i], ss_end, ss_num); //(1, 2024-01-01)
                }
            }
        }
        mv.setViewName("redirect:counsel?listSelect=4&cPage=1&c_idx="+c_idx);
        return mv;

    }

    @RequestMapping("counselListAdd")
    public ModelAndView counselListAdd(CounselVO vo, String ss_num){
        ModelAndView mv = new ModelAndView();
        
        if(vo.getSo_day() != null && vo.getSo_day().trim().length() >0){
        
         cs_Service.addCounsel(vo);

         t_Service.setCounsel_date(vo.getTr_idx(), vo.getSo_day(),ss_num);

        }
        mv.setViewName("redirect:counsel?listSelect=4&cPage=1&c_idx=7");
        return mv;
    }
}
