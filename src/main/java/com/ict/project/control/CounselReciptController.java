package com.ict.project.control;

import java.io.File;
import java.io.FileInputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.security.auth.Subject;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.util.IOUtils;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
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
import com.ict.project.service.TraineeService;
import com.ict.project.util.FileRenameUtil;
import com.ict.project.util.Paging;
import com.ict.project.vo.CounselReceiptVO;
import com.ict.project.vo.EvaluationFactorVO;
import com.ict.project.vo.InflowPathVO;
import com.ict.project.vo.NextscheduledVO;
import com.ict.project.vo.RoomVO;
import com.ict.project.vo.StaffVO;
import com.ict.project.vo.SubjectVO;
import com.ict.project.vo.TraineeVO;
import com.ict.project.vo.CounselingdetailVO;
import com.ict.project.vo.CourseTypeVO;
import com.ict.project.vo.CourseVO;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;



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
    TraineeService tn_Service;


    @RequestMapping("counselReceipt")
    public ModelAndView counselReceipt(String listSelect) {
        ModelAndView mv = new ModelAndView();

        
        CourseTypeVO[] ct_ar1 = ct_Service.getList();
        CourseVO[] c_ar1 = c_Service.getList();
        LocalDate now = LocalDate.now();

        mv.addObject("c_ar1", c_ar1);
        mv.addObject("ct_ar1", ct_ar1);
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
        else if(listSelect.equals("4")){
            mv.setViewName("/jsp/admin/counselReceipt/traineeRegReceipt");
            CourseTypeVO[] ct_ar = ct_Service.getList();
            mv.addObject("ct_ar", ct_ar);
            int totalCourse =c_Service.getSearchCount(null, null, null);
            CourseVO[] c_ar = c_Service.searchCourse(null, null, null, "1", String.valueOf(totalCourse));
            mv.addObject("c_ar", c_ar);
        }
        else if(listSelect.equals("5"))
            mv.setViewName("/jsp/admin/counselReceipt/traineeReceipt");
        return mv;
     
    }

     @RequestMapping("counselReceiptMain")
    public ModelAndView courseReceipt(String listSelect) {
        ModelAndView mv = new ModelAndView();
		
		CounselReceiptVO[] ar = null;
		mv.addObject("ar2", ar);
		ar = cr_Service.getCounselReceiptList();

        System.out.println("안들어옴"+listSelect);
        
		if(listSelect.equals("1"))
        mv.setViewName("/jsp/admin/counselReceipt/counselReceipt_ajax");
		else if(listSelect.equals("2")){
            System.out.println("들어옴");
            CounselingdetailVO[] cd_ad = null;
            cd_ad = cd_Service.getList();
            mv.addObject("cd_ad", cd_ad);
            System.out.println(cd_ad.length);
            mv.setViewName("/jsp/admin/counselReceipt/counselingDetail_ajax");
        }
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

        mv.addObject("c_ar", c_ar);
        mv.addObject("ct_ar", ct_ar);
		mv.addObject("ar", ar);
		mv.addObject("ar2", ar2);
		mv.addObject("ar3", ar3);
		mv.addObject("ar", ar4);
        mv.addObject("s_ar", s_ar);
		
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

    @RequestMapping("dailyReceipt")
    public ModelAndView requestMethodName(String listSelect,String year,String select) {
        //모집중,교육중 구분하기 
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String now = formatter.format(new Date(System.currentTimeMillis()));
        ModelAndView mv = new ModelAndView();
        CourseVO[] ar = c_Service.reg_search(now.substring(0,4)); //접수 취소한 인원은 sql문장에서 제거해주었다.
        //제적된 인원 구하기. 
        
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
        List<CourseVO> list = new ArrayList<>();
        if(select == null || select.equals("0"))
            mv.addObject("c_ar", ar);
        else if(select.equals("1")){
            for(int i=0; i<ar.length;i++){
                if(!ar[i].isC_reg())
                    list.add(ar[i]);
            }
            ar = null;
            if(list!= null && !list.isEmpty()){
                ar = new CourseVO[list.size()];
                list.toArray(ar);
            }
            mv.addObject("c_ar", ar);
        }else if(select.equals("2")){
            for(int i=0; i<ar.length;i++){
                if(ar[i].isC_reg())
                    list.add(ar[i]);
            }
            ar = null;
            if(list!= null && !list.isEmpty()){
                ar = new CourseVO[list.size()];
                list.toArray(ar);
            }
            mv.addObject("c_ar", ar);
        }
        //시수 구하기 
        if(ar!= null){
            for(int i=0; i<ar.length;i++){
                int hour = 0;
                if(ar[i].getSb_ar().length>0){
                    for( int k=0; k<ar[i].getSb_ar().length;k++){
                        hour += Integer.parseInt(ar[i].getSb_ar()[k].getHour());
                    }
                    ar[i].setTotal_hour(hour);
                }
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

    @RequestMapping("trainee")
    public ModelAndView trainee(String chk1,String num,String cPage,String c_idx,String year,String ct_idx,String select,String value){
        if(cPage ==null || cPage.length()<1){
            cPage="1";
        }
        if(c_idx== null || c_idx.length()<1 || c_idx.equals("0")){
            c_idx =null;
        }
        if(year == null ||year.length()<1|| year.equals("0"))
            year = null;
        if(ct_idx == null ||ct_idx.length()<1|| ct_idx.equals("0"))
            ct_idx = null;
        if(value == null ||value.length()<1|| value.equals("0"))
            select = null;
        //비동기통신 
        ModelAndView mv = new ModelAndView();
        String[] chk = chk1.split(",");
        boolean[] b_ar = new boolean[21];
        for(int i=0; i<b_ar.length;i++){
            b_ar[i] =false;
            for(int k=0; k<chk.length;k++){
                if(chk[k].equals(String.valueOf(i))){
                    b_ar[i] =true;
                    break;
                }
            }
        }
        mv.addObject("cols", b_ar.length);
        mv.addObject("b_ar", b_ar);
        //이름0,주민번호0,전화번호0,전화,과정0,결재일0,지원경로,개강일0,HRD등록일0,현재상태0,제적일,제적사유0,수료일0,전체교육비,카드유형0,우편번호,주소,메모,이전직장명,학생코드,과정타입(1~18)
        Paging page =new Paging(Integer.parseInt(num),5);
        page.setTotalRecord(tn_Service.getTCount(c_idx,year,ct_idx,select,value));
        page.setNowPage(Integer.parseInt(cPage));

        TraineeVO[] ar =tn_Service.getTList(String.valueOf(page.getBegin()),String.valueOf(page.getEnd()),c_idx,year,ct_idx,select,value);
        if(ar != null){
            for(TraineeVO tvo :ar){
                switch (tvo.getTr_nowstatus()) {
                    case "0":
                        tvo.setTr_nowstatus("접수");
                        break;
                    case "1":
                        tvo.setTr_nowstatus("예정");
                        break;
                    case "2":
                        tvo.setTr_nowstatus("수강");
                        break;
                    case "3":
                        tvo.setTr_nowstatus("조기수료");    
                        break;
                    case "4":
                        tvo.setTr_nowstatus("조기취업");    
                        break;
                    case "5":
                        tvo.setTr_nowstatus("수료");    
                        break;
                    case "6":
                        tvo.setTr_nowstatus("수강포기");    
                        break;
                    case "7":
                        tvo.setTr_nowstatus("미수료");    
                        break;
                    case "8":
                        tvo.setTr_nowstatus("제적");    
                        break;
                    case "9":
                        tvo.setTr_nowstatus("취소");    
                        break;
                    default:
                        break;
                }

            }
        }

        mv.addObject("page", page);
        mv.addObject("t_ar", ar);
        
        mv.setViewName("/jsp/admin/counselReceipt/trainee_ajax");
        return mv;
    }
    @RequestMapping("t_exelDown")
    public ModelAndView requestMethodName(MultipartFile t_file){
        ModelAndView mv = new ModelAndView();
        //System.out.println(t_file.getOriginalFilename());
        //성명	주민번호	연락처	전화	우편번호	주소	훈련과정명(코드값)	수강상태	전체교육비	상담메모	카드유형
        String realPath = application.getRealPath("subject_ex_upload");
		if(t_file.getSize()>0){
			String fname = t_file.getOriginalFilename();
			fname = FileRenameUtil.checkSameFileName(fname, realPath);
			try {
                //확장자가 xlsx이면 XSSFworkbook활용
				//그렇지 않고 xls면 HSSFworkbook활용
            
				File f = new File(realPath,fname);
				t_file.transferTo(f);
				FileInputStream fis = new FileInputStream(f.getAbsolutePath());
				IOUtils.setByteArrayMaxOverride(Integer.MAX_VALUE);
				HSSFWorkbook workbook = new HSSFWorkbook(fis);
				HSSFSheet sheet = workbook.getSheetAt(0);
				
				Iterator<Row> it = sheet.iterator();
				List<TraineeVO> list = new ArrayList<TraineeVO>();
					while(it.hasNext()) {
						Row row = it.next();
						// 첫번째 행은 머릿글이므로 제외
						if(row.getRowNum()==0)
							continue;
						//cell들을 한번에 반복자로 얻어낸다.
						Iterator<Cell> it2 = row.cellIterator();
						TraineeVO vo = new TraineeVO();
						int i=0;
						while(it2.hasNext()) {
							//하나의 cell을 얻어낸다 
							Cell cell = it2.next();
							String val = null;
							//System.out.println("cell.getCellType():"+cell.getCellType());
							switch (cell.getCellType()) {
								case NUMERIC:
									val = String.valueOf(cell.getNumericCellValue());
									break;
								case STRING:
									val = cell.getStringCellValue();
									break;
								case BLANK:
									val = "";
								default:
									val = "";
									break;
							}//switch문의 끝
                            System.out.println(val);
							switch(i) {
								case 0:
									vo.setTr_name(val);
									break;
								case 1:
									vo.setTr_rrn(val);
									break;
								case 2:
									vo.setTr_hp(val);
									break;
								case 3:
									vo.setTr_phone(val);
									break;
								case 4:
									vo.setTr_pos_code(val);
									break;
								case 5:
									vo.setTr_addr(val);
								case 6:
									vo.setC_idx("1");
									break;
                                case 7:
                                    vo.setTr_nowstatus(val);
									break;
                                case 8:
                                    vo.setTr_total_fee(val);
                                    break;
                                case 9:
                                   vo.setMemo(val);
                                    break;
                                case 10:
                                    vo.setTr_card(val);
                                    break;
								default:
									break;
                                    
							}
							i++;
						}// 열반복의 끝
						// 어떤 과정에 대한 과목을 추가하는 것이기 때문에 그 기본키를 가지고 있을것이다
                        if(vo.getTr_nowstatus().equals("접수")){
                            vo.setTr_nowstatus("0");
                        }else if(vo.getTr_nowstatus().equals("예정")){
                            vo.setTr_nowstatus("1");
                        }else if(vo.getTr_nowstatus().equals("수강")){
                            vo.setTr_nowstatus("2");
                        }else if(vo.getTr_nowstatus().equals("조기수료")){
                            vo.setTr_nowstatus("3");
                        }else if(vo.getTr_nowstatus().equals("조기취업")){
                            vo.setTr_nowstatus("4");
                        }else if(vo.getTr_nowstatus().equals("수료")){
                            vo.setTr_nowstatus("5");
                        }else if(vo.getTr_nowstatus().equals("수강포기")){
                            vo.setTr_nowstatus("6");
                        }else if(vo.getTr_nowstatus().equals("미수료")){
                            vo.setTr_nowstatus("7");
                        }else if(vo.getTr_nowstatus().equals("제적")){
                            vo.setTr_nowstatus("8");
                        }else if(vo.getTr_nowstatus().equals("취소")){
                            vo.setTr_nowstatus("9");
                        }else{
                            vo.setTr_nowstatus("0");
                        }
                        
                        if(vo.getTr_name()!=null && vo.getTr_name().length()>0 && vo.getTr_hp()!=null &&vo.getTr_hp().length()>0)
						    list.add(vo); //리스트에 저장
					}//행 반복의 끝
					// 리스트에 있는 정보들을 db에 저장하기위해
					HashMap<String,List<TraineeVO>> map = new HashMap<>();
					map.put("list", list);
					//훈련생에 추가하기/
					
                    tn_Service.addTrainee(map);

					fis.close();
					workbook.close();
					f.delete(); //파일 삭제
				//if문의 끝, file이 null이 아닐때

			} catch (Exception e) {
				e.printStackTrace();
			}
				
		}
		mv.setViewName("redirect:counselReceipt?listSelect=5");
        return mv;
    }

    @RequestMapping("delCounselingDetail")
    public String delCounselingDetail(String cd_idx) {
		int cnt = cd_Service.deletetCounselingDetail(cd_idx);
		
		return "redirect:counselReceipt?listSelect=2&cPage=1";
    }


    @RequestMapping("searchCounseldetail")
    public ModelAndView searchCounseldetail(String num,String year,String select,String value,String listSelect,String cPage){
		
		System.out.println(year);

		if(value== null || value.trim().length()==0){
			value= null;
			select=null;
		}

		if(year.equals("년도선택") || year.trim().length()==0)
			year = null;
		if(num.equals("표시개수"))
			num = null;
		ModelAndView mv = new ModelAndView();
		Paging page = null;
		if(num!=null && num.length()>0 )
			page = new Paging(Integer.parseInt(num),5);
		else 
			page = new Paging();
		
		page.setTotalRecord(cd_Service.getSearchCount(select, value, year));
		page.setNowPage(Integer.parseInt(cPage));
		CounselingdetailVO[] ar =null;
	
		ar = cd_Service.searchCounseldetail(select,value,year,String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
	
		mv.addObject("cd_ad", ar);
		mv.addObject("page", page);
	
		//비동기 통신할 jsp로 보내기
		if(listSelect.equals("1"))
            mv.setViewName("/jsp/admin/counselReceipt/counselReceipt_ajax");
		else if(listSelect.equals("2"))
            mv.setViewName("/jsp/admin/counselReceipt/counselingDetail_ajax");
        return mv;
	}
    
}
