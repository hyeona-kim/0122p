package com.ict.project.control;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.jasper.tagplugins.jstl.core.Set;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.util.IOUtils;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.CourseService;
import com.ict.project.service.CourseTypeService;
import com.ict.project.service.FileService;
import com.ict.project.service.RoomService;
import com.ict.project.service.SkillService;
import com.ict.project.service.StaffService;
import com.ict.project.service.SubjectService;
import com.ict.project.util.DateStatic;
import com.ict.project.util.ExelFileReader;
import com.ict.project.util.FileRenameUtil;
import com.ict.project.util.Paging;
import com.ict.project.vo.CourseTypeVO;
import com.ict.project.vo.CourseVO;
import com.ict.project.vo.DayVO;
import com.ict.project.vo.FileVO;
import com.ict.project.vo.RoomVO;
import com.ict.project.vo.SkillVO;
import com.ict.project.vo.StaffVO;
import com.ict.project.vo.SubjectVO;
import com.ict.project.vo.TimeVO;
import com.ict.project.vo.WeekVO;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	SkillService sk_Service;
	@Autowired
	FileService f_Service;
	@Autowired
	SubjectService sb_Service;

	@RequestMapping("head")
	public String requestMethodName() {
		return "/jsp/admin/main2";
	}

	@RequestMapping("main_course")
	public ModelAndView main_course(String cPage) {
		ModelAndView mv = new ModelAndView();
		if (cPage == null || cPage.length() == 0)
			cPage = "1";
		Paging page = new Paging();
		page.setTotalRecord(c_Service.getSearchCount(null, null, null));
		page.setNowPage(Integer.parseInt(cPage));
		mv.addObject("page", page);
		CourseVO[] ar = c_Service.searchCourse(null, null, null, String.valueOf(page.getBegin()),
				String.valueOf(page.getEnd()));
		mv.addObject("c_ar", ar);
		mv.setViewName("/jsp/admin/main_ajax");
		return mv;
	}

	@RequestMapping("course")
	public ModelAndView course(String listSelect, String upskill, String c_idx) {
		ModelAndView mv = new ModelAndView();
		String viewPath = null;
		if (listSelect.equals("1")) {
			viewPath = "/jsp/admin/courseReg/courselog";
			RoomVO[] ar = r_Service.getList();
			mv.addObject("r_length", ar.length);
		} else if (listSelect.equals("2"))
			viewPath = "/jsp/admin/courseReg/serve";
		else if (listSelect.equals("3"))
			viewPath = "/jsp/admin/courseReg/maketime";

		mv.setViewName(viewPath);

		return mv;
	}

	@RequestMapping("addCourse")
	public String addCourse(CourseVO cvo, String cPage, String select, String num, String year, String value) {
		c_Service.addCourse(cvo);
		// System.out.println(cPage+"/"+select+"/"+num+"/"+year+"/"+value);
		return "redirect:course?listSelect=1&cPage=" + cPage + "&select=" + select + "&num=" + num + "&year=" + year
				+ "&value=" + value;
	}

	@RequestMapping("delCourse")
	public String delCourse(String c_idx, String cPage) {
		if (cPage == null)
			cPage = "1";
		int cnt = c_Service.deleteCourse(c_idx);

		return "redirect:course?listSelect=1&cPage=" + cPage;
	}

	@RequestMapping("editCourse")
	public ModelAndView editCourse(CourseVO cvo, String edit, String cPage) {
		ModelAndView mv = new ModelAndView();
		if (edit == null) {
			CourseVO vo = c_Service.getCourse(cvo.getC_idx());
			request.setAttribute("edit_cvo", vo);
			CourseTypeVO[] ct_ar = ct_Service.getList();
			RoomVO[] r_ar = r_Service.getList();
			StaffVO[] s_ar = s_Service.getList();

			mv.addObject("c_ar", ct_ar);
			mv.addObject("r_ar", r_ar);
			mv.addObject("s_ar", s_ar);
			mv.addObject("r_idx", vo.getR_idx());
			mv.addObject("sf_idx", vo.getSf_idx());
			mv.addObject("ct_idx", vo.getCt_idx());
			if (vo.getC_day() != null) {
				if (vo.getC_day().contains("월"))
					mv.addObject("monday", true);
				if (vo.getC_day().contains("화"))
					mv.addObject("tuesday", true);
				if (vo.getC_day().contains("수"))
					mv.addObject("wednesday", true);
				if (vo.getC_day().contains("목"))
					mv.addObject("thursday", true);
				if (vo.getC_day().contains("금"))
					mv.addObject("friday", true);
				if (vo.getC_day().contains("토"))
					mv.addObject("saturday", true);
				if (vo.getC_day().contains("일"))
					mv.addObject("sunday", true);
			}
			mv.setViewName("/jsp/admin/courseReg/editCourse_ajax");
		} else {
			int cnt = c_Service.editCourse(cvo);
			mv.setViewName("redirect:course?listSelect=1&cPage=" + cPage);
		}
		return mv;
	}

	@RequestMapping("viewCourse")
	public String viewCourse(String c_idx) {
		String viewPath = null;

		// c_idx를 기반으로 CourseVO 객체 가져오기
		CourseVO vo = c_Service.getCourse(c_idx);

		request.setAttribute("select_vo", vo);

		viewPath = "redirect:course&listSelect=1";

		return viewPath;
	}

	@RequestMapping("searchCourse")
	public ModelAndView searchCourse(String num, String year, String select, String value, String listSelect,
			String cPage) {
		// System.out.println(value);

		if (value == null || value.trim().length() == 0) {
			value = null;
			select = null;
		}

		if (year.equals("년도선택") || year.trim().length() == 0)
			year = null;
		if (num.equals("표시개수"))
			num = null;
		ModelAndView mv = new ModelAndView();
		Paging page = null;
		if (num != null && num.length() > 0)
			page = new Paging(Integer.parseInt(num), 5);
		else
			page = new Paging();

		page.setTotalRecord(c_Service.getSearchCount(select, value, year));
		page.setNowPage(Integer.parseInt(cPage));
		CourseVO[] ar = null;

		ar = c_Service.searchCourse(select, value, year, String.valueOf(page.getBegin()),
				String.valueOf(page.getEnd()));

		mv.addObject("ar", ar);
		mv.addObject("page", page);

		// 비동기 통신할 jsp로 보내기
		if (listSelect.equals("1"))
			mv.setViewName("/jsp/admin/courseReg/courseLog_ajax");
		else if (listSelect.equals("2"))
			mv.setViewName("/jsp/admin/courseReg/serve_ajax");

		else if (listSelect.equals("3"))
			mv.setViewName("/jsp/admin/courseReg/makeTime_ajax");
		return mv;
	}

	@RequestMapping("addCourseType")
	public ModelAndView addCourseType(String[] name, String[] text, String listSelect, String cPage) {
		ModelAndView mv = new ModelAndView();
		String[] ct_name = name;
		String[] ct_color = text;
		CourseTypeVO vo = new CourseTypeVO();

		if (ct_name != null && !ct_name.equals("")) {
			for (int i = 0; i < ct_name.length; i++) {
				if (ct_name[i] != null && !ct_name[i].isEmpty()) {
					vo.setCt_name(ct_name[i]);
					vo.setCt_color(ct_color[i]);
					vo.setCt_idx(Integer.toString(i + 1));
					ct_Service.addCourseType(vo);
				}

			}
		}
		mv.setViewName("redirect:course?listSelect=" + listSelect + "&cPage=" + cPage);
		return mv;
	}

	@RequestMapping("courseMain")
	public ModelAndView courseMain(String listSelect, String cPage) {
		ModelAndView mv = new ModelAndView();
		if (cPage == null) {
			cPage = "1";
		}
		// cPage와 listSelect를 받아서 이를 통해 paging객체 만들기.
		Paging page = new Paging();
		page.setTotalRecord(c_Service.getCount());
		page.setNowPage(Integer.parseInt(cPage));
		CourseVO[] ar = null;
		ar = c_Service.getCourseList(String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
		mv.addObject("ar", ar);
		mv.addObject("page", page);

		if (listSelect.equals("1"))
			mv.setViewName("/jsp/admin/courseReg/courseLog_ajax");
		else if (listSelect.equals("2"))
			mv.setViewName("/jsp/admin/courseReg/serve_ajax");
		else if (listSelect.equals("3"))
			mv.setViewName("/jsp/admin/courseReg/makeTime_ajax");
		else
			mv.setViewName("/jsp/admin/courseReg/courseLog_ajax");

		return mv;
	}

	@RequestMapping("addRoom")
	public String addRoom(String[] className, String[] roomSep, String[] use, String listSelect, String cPage) {

		String[] r_name = className;
		String[] r_sep = roomSep;
		String[] r_status = use;
		RoomVO vo = new RoomVO();

		if (r_name != null && !r_name.equals("")) {
			for (int i = 0; i < r_name.length; i++) {
				if (r_name[i] != null && !r_name[i].isEmpty()) {
					vo.setR_name(r_name[i]);
					vo.setR_sep(r_sep[i]);
					vo.setR_status(r_status[i]);
					vo.setR_idx(Integer.toString(i + 1));
					r_Service.addRoom(vo);
				}

			}
		}
		return "redirect:course?listSelect=" + listSelect + "&cPage=" + cPage;
	}

	@RequestMapping("c_dialog")
	public ModelAndView c_dialog(String c_select, String c_idx) {
		ModelAndView mv = new ModelAndView();

		CourseTypeVO[] ct_ar = ct_Service.getList();
		RoomVO[] r_ar = r_Service.getList();

		StaffVO[] s_ar = s_Service.getList();
		mv.addObject("c_ar", ct_ar);
		mv.addObject("r_ar", r_ar);
		mv.addObject("s_ar", s_ar);

		if (c_select.equals("addCourse"))
			mv.setViewName("/jsp/admin/courseReg/addCourse_ajax");
		else if (c_select.equals("addCourseType"))
			mv.setViewName("/jsp/admin/courseReg/addCourseType_ajax");
		else if (c_select.equals("addRoom"))
			mv.setViewName("/jsp/admin/courseReg/addRoom_ajax");
		else if (c_select.equals("editCourse"))
			mv.setViewName("/jsp/admin/courseReg/editCourse_ajax");
		else if (c_select.equals("addUpskill"))
			mv.setViewName("/jsp/admin/courseReg/addUpskill_ajax");
		else if (c_select.equals("updateSubject")) {
			// 교과목에 대한 정보를 가지고 온다.
			SubjectVO[] ar = sb_Service.getList(Integer.parseInt(c_idx));
			mv.addObject("sb_ar", ar);
			if (ar != null)
				mv.addObject("sb_length", ar.length);
			mv.setViewName("/jsp/admin/courseReg/subject");

		}
		CourseVO cvo = c_Service.getCourse(c_idx);
		mv.addObject("cvo", cvo);
		return mv;

	}

	@RequestMapping("upskill")
	public ModelAndView upskill(String skill, String listSelect, String cPage, String select, String value, String year,
			String num, String c_idx, String s_idx) {
		ModelAndView mv = new ModelAndView();
		if (skill == null) {
			SubjectVO[] ar = null;
			ar = sb_Service.getList(Integer.parseInt(c_idx));
			// 과목은 각 과목의 기본키를 가지고 있다. 그렇다면 과목이 skill의 배열을 가지고 그 배열을 반복문 돌려서 그에 맞는 skillV를 찾아
			// 주어야 한다.
			mv.addObject("ar", ar);
			mv.setViewName("/jsp/admin/courseReg/upskill");
		} else {
			SkillVO[] ar = null;
			ar = sk_Service.getSkillList(s_idx);
			mv.addObject("ar", ar);
			mv.addObject("c_idx", c_idx);
			mv.addObject("s_idx", s_idx);
			if (ar != null) {
				mv.addObject("sk_length", ar.length);
			} else
				mv.addObject("sk_length", 0);
			mv.setViewName("/jsp/admin/courseReg/addUpskill_ajax");
		}
		return mv;
	}

	@RequestMapping("skillAdd")
	public ModelAndView skillAdd(String c_idx, String s_idx, String[] sk_idx, String[] sk_name, String upskill) {
		ModelAndView mv = new ModelAndView();
		SkillVO[] ar = new SkillVO[sk_idx.length];
		for (int i = 0; i < ar.length; i++) {
			ar[i] = new SkillVO();
			ar[i].setS_idx(s_idx);
			ar[i].setSk_idx(sk_idx[i]);
			ar[i].setSk_name(sk_name[i]);
		}
		// 1. sk_idx가 있는경우는 edit// 2.sk_name이 있는데 sk_idx가 없는 경우는 add// 3.sk_name도없고,idx도
		// 없다면pass
		for (SkillVO skvo : ar) {
			if (skvo.getSk_idx() != null && skvo.getSk_idx().length() > 0) {

				sk_Service.editSkill(skvo);
			} else {
				// sk_name이 있다면 수정하기
				if (skvo.getSk_name() != null && skvo.getSk_name().length() != 0) {
					int cnt = sk_Service.addSkill(skvo);
				}
			}
		}
		mv.setViewName("redirect:course?listSelect=1&cPage=1&upskill=" + upskill + "&c_idx=" + c_idx);
		// 사실상 능력 단위요소 페이지로 갈 수 있게 해주어야 한다.아니면 비동기 통신으로 추가만해주고 결과는 없는데 대신 다이얼로그를 종료 해주는
		// 방식으로 해야한다.

		return mv;
	}

	@RequestMapping("downloadSubject")
	public String download() {
		// b_idx, cPage, file_name, bname 이 넘어온다
		// 파일들이 위치하는 곳
		String realPath = application.getRealPath("sample.xls");
		// System.out.println(realPath);
		File f = new File(realPath);
		if (f.exists() && f.isFile()) {
			// 파일이 존재 할 경우.
			// System.out.println(realPath);
			byte[] buf = new byte[4069];
			int size = -1;
			// 다운로드의 필요한 스트림 준비 !
			BufferedInputStream bis = null;
			FileInputStream fis = null;
			BufferedOutputStream bos = null;
			ServletOutputStream sos = null;

			try {
				// 접속자 화면에 다운로드창
				response.setContentType("application/vnd.ms-excel");
				response.setHeader("Content-Disposition",
						"attachment;filename=" + new String("sample.xls".getBytes(), "8859_1"));
				// 스트림 초기화
				bis = new BufferedInputStream(fis = new FileInputStream(f));
				bos = new BufferedOutputStream(sos = response.getOutputStream());
				while ((size = bis.read(buf)) != -1) {
					bos.write(buf, 0, size);
					bos.flush();
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (fis != null)
						fis.close();
					if (bis != null)
						bis.close();
					if (sos != null)
						sos.close();
					if (bos != null)
						bos.close();
				} catch (Exception e) {
				}
			}
		}
		return null;
	}

	@RequestMapping("course_file")
	public ModelAndView course_file(FileVO fvo, String listSelect, String cPage) {
		ModelAndView mv = new ModelAndView();
		String encType = request.getContentType();
		if (encType.startsWith("application")) {
			CourseVO cvo = c_Service.getCourse(fvo.getC_idx());

			FileVO[] ar = f_Service.getList(fvo.getC_idx());
			mv.addObject("fvo", ar);
			mv.addObject("cvo", cvo);
			mv.setViewName("/jsp/admin/courseReg/courseFile_ajax");
		} else if (encType.startsWith("multipart")) {
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

			if (fvo.getF_idx() == null || fvo.getF_idx().length() == 5) {
				// 파일이 존재하지 않는 경우

				for (int i = 0; i < f_info.length; i++) {
					if (f_ar[i].getSize() > 0) {
						String fname = FileRenameUtil.checkSameFileName(f_ar[i].getOriginalFilename(), realPath);

						try {
							f_ar[i].transferTo(new File(realPath, fname));// 파일 업로드
						} catch (Exception e) {
							e.printStackTrace();
						}
						fvo.setF_name(fname);
					}
					fvo.setF_info(f_info[i]);
					f_Service.addFile(fvo);
					// fvo가 이전의 파일명을 가지고 또 저장하기때문에 중복되는걸 막고자 fvo를 초기화 한다.
					fvo = new FileVO();
					fvo.setC_idx(c_idx);
					if (i < f_info.length - 1)
						fvo.setF_info(f_info[i + 1]);
				}
			} else {
				// 파일 존재
				String[] f_idx = fvo.getF_idx().split(",");
				for (int i = 0; i < f_info.length; i++) {

					if (f_ar[i].getSize() > 0) {
						String fname = FileRenameUtil.checkSameFileName(f_ar[i].getOriginalFilename(), realPath);
						try {
							f_ar[i].transferTo(new File(realPath, fname)); // 파일 업로드
						} catch (Exception e) {
							e.printStackTrace();
						}
						fvo.setF_idx(f_idx[i]);
						fvo.setF_name(fname);
						f_Service.editFile(fvo);
					}
				}
			}
			mv.setViewName("redirect:course?listSelect=" + listSelect + "&cPage=" + cPage);
		}

		return mv;
	}

	@RequestMapping("coursefileDown")
	public String coursefileDown(FileVO fvo) {
		String filename = fvo.getF_name();
		String realPath = request.getServletContext().getRealPath("upload_courseFile");
		// System.out.println(realPath);
		String fullPath = realPath + System.getProperty("file.separator") + filename;

		File f = new File(fullPath);
		if (f.exists() && f.isFile()) {
			byte[] buf = new byte[2048];

			BufferedInputStream bis = null;
			BufferedOutputStream bos = null;
			FileInputStream fis = null;
			ServletOutputStream sos = null;
			try {
				response.setContentType("application/x-msdownload");
				response.setHeader("Content-Disposition",
						"attachment;filename=" + new String(filename.getBytes(), "8859_1"));
				fis = new FileInputStream(f);
				bis = new BufferedInputStream(fis);
				// 응답 객체를 통해 output스트림 생성
				sos = response.getOutputStream();
				bos = new BufferedOutputStream(sos);
				int size = -1;
				while ((size = bis.read(buf)) != -1) {
					bos.write(buf, 0, size);
					bos.flush();
				}

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (fis != null)
						fis.close();
					if (bis != null)
						bis.close();
					if (sos != null)
						sos.close();
					if (bos != null)
						bos.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}

		}
		return null;
	}

	@RequestMapping("exelAdd")
	public ModelAndView exelAdd(String select, String c_idx) {
		ModelAndView mv = new ModelAndView();
		if (select.equals("SRS")) {
			CourseVO cvo = c_Service.getCourse(c_idx);

			SubjectVO[] s_ar = sb_Service.getList(Integer.parseInt(c_idx));

			// 과정에 따른 강의실 출력해주기
			List<String> r_name = new ArrayList<>();
			for (int i = 0; i < s_ar.length; i++) {
				r_name.add(s_ar[i].getR_name());
			}
			java.util.Set<String> set = new HashSet<>(r_name);
			List<String> sList = new ArrayList<>(set);
			List<RoomVO> rList = new ArrayList<>();
			for (String str : sList) {
				RoomVO rvo = r_Service.searchList(str);
				switch (rvo.getR_sep()) {
					case "0":
						rvo.setR_sep("실습");
						break;
					case "1":
						rvo.setR_sep("이론");
						break;
					case "2":
						rvo.setR_sep("겸용");
						break;
				}
				rList.add(rvo);
			}

			// 과정에 맞는 강사 출력해주기.

			List<String> sf_name = new ArrayList<>();
			for (int i = 0; i < s_ar.length; i++) {
				sf_name.add(s_ar[i].getSf_name());
			}
			java.util.Set<String> set2 = new HashSet<>(sf_name);
			List<String> sList2 = new ArrayList<>(set2);
			List<StaffVO> sfList = new ArrayList<>();
			for (String str : sList2) {
				StaffVO sfvo = s_Service.searchList(str);
				sfList.add(sfvo);
			}
			// 교과목 중복 갯수 세기
			List<String> s_title = new ArrayList<>();
			for (int i = 0; i < s_ar.length; i++) {
				s_title.add(s_ar[i].getS_title());
			}
			java.util.Set<String> set3 = new HashSet<>(s_title);
			List<String> sList3 = new ArrayList<>(set3);
			SubjectVO[] ar = new SubjectVO[sList3.size()];
			for (int i = 0; i < ar.length; i++) {
				ar[i] = new SubjectVO();
				ar[i].setS_title(sList3.get(i));
			}

			mv.addObject("s_ar", s_ar);
			mv.addObject("sf_ar", sfList);
			mv.addObject("r_ar", rList);
			mv.addObject("cvo", cvo);
		}
		mv.setViewName("/jsp/admin/courseReg/exelAdd_ajax");
		return mv;
	}

	@RequestMapping("addExelfile")
	public String addExelfile(MultipartFile c_file, String c_idx) {

		String realPath = application.getRealPath("time_Exel");
		Map<String, Integer> map = new HashMap<>();
		if (c_file != null && c_file.getSize() > 0) {
			String filename = c_file.getOriginalFilename();

			if (filename.lastIndexOf(".") != -1) {
				filename = filename.substring(filename.lastIndexOf("."), filename.length());

				if (c_file.getSize() > 0) {
					String fname = FileRenameUtil.checkSameFileName(c_idx + "timeExel" + filename,
							realPath);
					try {
						c_file.transferTo(new File(realPath, fname)); // 파일 업로드
					} catch (Exception e) {
						e.printStackTrace();
					}
					int cnt = c_Service.time_exel(c_idx, fname);
					map.put("update", cnt);
					// System.out.println(fname);
				}
			}
		}
		return "redirect:course?cPage=1&listSelect=3";
	}

	@RequestMapping("weekTime")
	public ModelAndView weekTime(String listSelect, String c_idx) {
		ModelAndView mv = new ModelAndView();
		CourseVO cvo = c_Service.getCourse2(c_idx);
		SubjectVO[] s_ar = cvo.getSb_ar();
		String[] sf_name = new String[s_ar.length];
		int i = 0;
		for (SubjectVO svo : s_ar) {
			sf_name[i] = svo.getSf_name();
			i++;
		}
		java.util.Set<String> set = new HashSet<String>(Arrays.asList(sf_name));
		sf_name = set.toArray(new String[0]);
		String str = "";
		for (i = 0; i < sf_name.length; i++) {
			if (i == sf_name.length - 1) {
				str += sf_name[i];
			} else {
				str += sf_name[i] + ",";
			}
		}
		cvo.setSf_idx(str);
		mv.addObject("cvo", cvo);
		mv.setViewName("/jsp/admin/courseReg/weekTime_ajax");
		return mv;
	}

	@RequestMapping("getTime")
	@ResponseBody
	public Map<String, Object> getTime(String c_idx, String listSelect, String cPage) throws ParseException {
		Map<String, Object> map = new HashMap<>();
		CourseVO cvo = c_Service.getCourse2(c_idx);
		// 스태틱으로 선언한 액셀의 저장된 총 정보 가지고오기
		List<TimeVO> list = ExelFileReader.exel(cvo, application);
		map.put("w_list", list);

		/******** 여기서부터 테이블에 표시할 정보 *********/
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		// 내가 원하는 주차의 정보만 가지고오기
		// new Date(formatter.parse(ar[i].getStart_date()).getTime());
		// System.out.println("----------------");

		int totalWeek = totalWeek(list.get(0).getTraining_date(), list.get(list.size() - 1).getTraining_date());
		String[] w_name = new String[totalWeek];

		int pp = 0;
		for (TimeVO tvo : list) {
			tvo.setWeek(getCurrentWeekOfMonth(
					new Date(formatter.parse(tvo.getTraining_date()).getTime())));// 5월 1주차 -->0501형식으로 표기
			if (pp == 0) {
				w_name[pp] = tvo.getWeek();
				pp++;
			} else {
				boolean b = false;
				for (int i = 0; i < pp; i++) {
					if (w_name[i].equals(tvo.getWeek())) {
						b = true;
						break;
					}
				}
				if (!b) {
					w_name[pp] = tvo.getWeek();
					if (pp < 29)
						pp++;
				}
			}
		}
		// 페이징을 위한 객체생성
		Paging page = new Paging(1, 1);
		page.setTotalRecord(totalWeek);
		page.setNowPage(Integer.parseInt(cPage));
		map.put("page", page);

		List<String> d_name = day(list.get(0).getTraining_date(), list.get(list.size() - 1).getTraining_date());

		// 주를 계산하는 배열을 생성한다 ( 해당 주에는 dayvo의 배열을 가지고 해당 주의 정보를 가지고 있다 )
		// WeekVO > DayVO >TimeVO 같은 형식
		WeekVO[] week_ar = new WeekVO[totalWeek];
		int day_length = 0;
		for (int k = 0; k < week_ar.length; k++) {// 29번도는 반복문
			DayVO[] day_ar = new DayVO[7];
			week_ar[k] = new WeekVO();
			week_ar[k].setWeekcount(w_name[k]);
			for (int i = 0; i < 7; i++) {// 7번도는 반복문 week_ar[k].getDay_ar[i] -->총 29X7개 == 203개
				day_ar[i] = new DayVO();
				// 여기에 list에서 해당 날짜를 출력해준다
				if (k == 0) {
					// 첫주차는 요일을 계산
					int dayOfWeek = DateStatic.dayOfWeek(list.get(0).getTraining_date());// 월요일
					if (dayOfWeek == 7) // 일요일이면 0으로 세팅
						dayOfWeek = 0;
					if (i >= dayOfWeek) {
						day_ar[i].setDay(d_name.get(day_length));
						day_length++;
					}
				} else {
					if (day_length < d_name.size()) {
						day_ar[i].setDay(d_name.get(day_length));
						day_length++;
					}
				}
				week_ar[k].setDay_ar(day_ar);
			}
		}
		for (int k = 0; k < week_ar.length; k++) {
			// 주에대한 정보
			for (int i = 0; i < 7; i++) {
				// 일에대한 정보
				List<TimeVO> t_list = new ArrayList<>();

				for (TimeVO ttvo : list) {
					if (ttvo.getTraining_date().equals(week_ar[k].getDay_ar()[i].getDay())) {
						t_list.add(ttvo);
					}
				}
				// System.out.println(t_list.size());
				TimeVO[] t_ar = null;
				if (t_list.size() > 0) {
					t_ar = new TimeVO[t_list.size()];
					t_list.toArray(t_ar);
				}
				week_ar[k].getDay_ar()[i].setTime_ar(t_ar);
			}
		}
		map.put("week_ar", week_ar);
		return map;
	}

	public List<String> day(String startDate, String endDate) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd"); // 년월일 표시

		Calendar cal = Calendar.getInstance();
		int i = 0;

		int year = Integer.parseInt(startDate.substring(0, 4));
		int month = Integer.parseInt(startDate.substring(4, 6)) - 1;
		int date = Integer.parseInt(startDate.substring(6));
		cal.set(year, month, date);

		List<String> s_list = new ArrayList<>();
		while (!startDate.equals(endDate)) { // 다르다면 실행, 동일 하다면 빠져나감

			if (i == 0) { // 최초 실행 출력
				s_list.add(dateFormat.format(cal.getTime()));
			}

			// cal.add(Calendar.MONTH, 1); // 1달 더해줌
			cal.add(Calendar.DATE, 1); // 1일 더해줌
			startDate = dateFormat.format(cal.getTime()); // 비교를 위한 값 셋팅

			// +1달 출력
			// System.out.println(dateFormat.format(cal.getTime()));
			s_list.add(dateFormat.format(cal.getTime()));
			i++;

		}
		return s_list;

	}

	// 총 주차수 구하기
	public int totalWeek(String start_date, String end_date) {
		Calendar startDate = Calendar.getInstance();
		Calendar endDate = Calendar.getInstance();
		int year = Integer.parseInt(start_date.substring(0, 4));
		int month = Integer.parseInt(start_date.substring(4, 6)) - 1;
		int date = Integer.parseInt(start_date.substring(6));
		startDate.set(year, month, date);

		year = Integer.parseInt(end_date.substring(0, 4));
		month = Integer.parseInt(end_date.substring(4, 6)) - 1;
		date = Integer.parseInt(end_date.substring(6));
		endDate.set(year, month, date);

		int startDayOfWeek = startDate.get(Calendar.DAY_OF_WEEK);
		int endDayOfWeek = endDate.get(Calendar.DAY_OF_WEEK);

		int periodWeek = 0;

		while (!endDate.before(startDate)) {
			startDate.add(Calendar.DATE, 7);
			periodWeek++;
		}

		if (endDayOfWeek - startDayOfWeek < 0) {
			periodWeek = periodWeek + 1;
		}

		return periodWeek;
	}

	// 몇주차인지 구하는 함수
	public String getCurrentWeekOfMonth(Date date) {
		Calendar calendar = Calendar.getInstance(Locale.KOREA);
		calendar.setTime(date);
		int month = calendar.get(Calendar.MONTH) + 1; // calendar에서의 월은 0부터 시작
		int day = calendar.get(Calendar.DATE);

		// 한 주의 시작은 월요일이고, 첫 주에 4일이 포함되어있어야 첫 주 취급 (목/금/토/일)
		calendar.setFirstDayOfWeek(Calendar.MONDAY);
		calendar.setMinimalDaysInFirstWeek(4);

		int weekOfMonth = calendar.get(Calendar.WEEK_OF_MONTH);

		// 첫 주에 해당하지 않는 주의 경우 전 달 마지막 주차로 계산
		if (weekOfMonth == 0) {
			calendar.add(Calendar.DATE, -day); // 전 달의 마지막 날 기준
			return getCurrentWeekOfMonth(calendar.getTime());
		}

		// 마지막 주차의 경우
		if (weekOfMonth == calendar.getActualMaximum(Calendar.WEEK_OF_MONTH)) {
			calendar.set(Calendar.DATE, calendar.getActualMaximum(Calendar.DATE)); // 이번 달의 마지막 날
			int lastDaysDayOfWeek = calendar.get(Calendar.DAY_OF_WEEK); // 이번 달 마지막 날의 요일

			// 마지막 날이 월~수 사이이면 다음달 1주차로 계산
			if (lastDaysDayOfWeek >= Calendar.MONDAY && lastDaysDayOfWeek <= Calendar.WEDNESDAY) {
				calendar.add(Calendar.DATE, 1); // 마지막 날 + 1일 => 다음달 1일
				return getCurrentWeekOfMonth(calendar.getTime());
			}
		}
		return (month < 10) ? "0" + month + "0" + weekOfMonth : month + "0" + weekOfMonth;
	}

	@RequestMapping("add_subject")
	public ModelAndView add_subject(String year, String select, String listSelect, String num, String value,
			String cPage, MultipartFile s_file, String c_idx) {
		ModelAndView mv = new ModelAndView();
		String realPath = application.getRealPath("subject_ex_upload");
		if (s_file.getSize() > 0) {
			String fname = s_file.getOriginalFilename();
			fname = FileRenameUtil.checkSameFileName(fname, realPath);
			try {
				File f = new File(realPath, fname);
				s_file.transferTo(f);
				FileInputStream fis = new FileInputStream(f.getAbsolutePath());
				IOUtils.setByteArrayMaxOverride(Integer.MAX_VALUE);
				XSSFWorkbook workbook = new XSSFWorkbook(fis);
				XSSFSheet sheet = workbook.getSheetAt(0);

				Iterator<Row> it = sheet.iterator();
				List<SubjectVO> list = new ArrayList<SubjectVO>();
				while (it.hasNext()) {
					Row row = it.next();
					// 첫번째 행은 머릿글이므로 제외
					if (row.getRowNum() == 0)
						continue;
					// cell들을 한번에 반복자로 얻어낸다.
					Iterator<Cell> it2 = row.cellIterator();
					SubjectVO vo = new SubjectVO();
					int i = 0;
					while (it2.hasNext()) {
						// 하나의 cell을 얻어낸다
						Cell cell = it2.next();
						String val = null;
						// System.out.println("cell.getCellType():"+cell.getCellType());
						switch (cell.getCellType()) {
							case NUMERIC:
								val = String.valueOf(cell.getNumericCellValue());
								break;
							case STRING:
								val = cell.getStringCellValue();
								break;
							case BLANK:
								val = null;
							default:
								val = null;
								break;
						}// switch문의 끝

						switch (i) {
							case 0:
								vo.setS_title(val);
								break;
							case 1:
								vo.setUs_name(val);
								break;
							case 2:
								vo.setS_type(val);
								break;
							case 3:
								vo.setSf_name(val);
								break;
							case 4:
								vo.setS_category_num(val);
								break;
							case 5:
								vo.setHour(val);
								break;
							case 6:
								vo.setR_name(val);
								break;
							default:
								break;
						}
						i++;
					} // 열반복의 끝
					vo.setC_idx(c_idx);
					// 어떤 과정에 대한 과목을 추가하는 것이기 때문에 그 기본키를 가지고 있을것이다
					if (vo.getS_title() != null)
						list.add(vo); // 리스트에 저장
				} // 행 반복의 끝
					// 리스트에 있는 정보들을 db에 저장하기위해

				HashMap<String, List<SubjectVO>> map = new HashMap<>();
				map.put("list", list);
				sb_Service.addSubject(map);

				fis.close();
				workbook.close();
				f.delete(); // 파일 삭제
				// if문의 끝, file이 null이 아닐때
			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		if (cPage == null)
			cPage = "1";
		mv.setViewName("redirect:course?year=" + year + "&select=" + select + "&listSelect=" + listSelect + "&num="
				+ num + "&value=" + value + "&cPage=" + cPage);
		return mv;
	}

	@RequestMapping("add_subject_form")
	public ModelAndView add_subject_form(String[] s_idx, String[] s_title, String[] us_name, String[] s_type,
			String[] sf_name,
			String[] s_category_num, String[] hour, String[] r_name, String c_idx, String[] s_status) {
		ModelAndView mv = new ModelAndView();
		SubjectVO[] ar = new SubjectVO[s_title.length];

		for (int i = 0; i < ar.length; i++) {
			ar[i] = new SubjectVO();
			ar[i].setS_idx(s_idx[i]);
			ar[i].setC_idx(c_idx);
			ar[i].setS_title(s_title[i]);
			ar[i].setUs_name(us_name[i]);
			if (s_type[i].equals("NONCS")) {
				s_type[i] = "기초소양";
			}
			ar[i].setS_type(s_type[i]);
			ar[i].setSf_name(sf_name[i]);
			ar[i].setS_category_num(s_category_num[i]);
			ar[i].setHour(hour[i]);
			ar[i].setR_name(r_name[i]);
			ar[i].setS_status(s_status[i]);
		}
		List<SubjectVO> list = new ArrayList<>();
		for (SubjectVO svo : ar) {
			if (svo.getS_idx() != null && svo.getS_idx().length() > 0) {
				int cnt = sb_Service.editSubject(svo);
			} else {
				if (svo.getS_title() != null && svo.getUs_name() != null && svo.getS_title().length() > 0
						&& svo.getUs_name().length() > 0) {
					list.add(svo);
				}
			}
		}
		if (list.size() > 0) {
			Map<String, List<SubjectVO>> map = new HashMap<>();
			map.put("list", list);
			sb_Service.addSubject(map);
		}
		mv.setViewName("redirect:course?cPage=1&listSelect=1");
		return mv;
	}

	@RequestMapping("del_skill")
	public String del_skill(String sk_idx, String c_idx, String skill, String s_idx) {
		int cnt = sk_Service.delSkill(sk_idx);
		return "redirect:upskill?skill=" + skill + "&c_idx=" + c_idx + "&s_idx=" + s_idx;
	}

	@RequestMapping("staffCourse")
	@ResponseBody
	public Map<String, Object> staffCourse(String sf_idx) {
		Map<String, Object> map = new HashMap<>();
		if (c_Service.staffCourse_count(sf_idx) == 0) {
			map.put("c_ar", null);
		} else {
			CourseVO[] c_ar = c_Service.staffCourse(sf_idx, "0", String.valueOf(c_Service.staffCourse_count(sf_idx)));
			map.put("c_ar", c_ar);
		}

		return map;
	}

}
