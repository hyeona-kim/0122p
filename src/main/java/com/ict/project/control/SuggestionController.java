package com.ict.project.control;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.SuggestionService;
import com.ict.project.service.TestService;
import com.ict.project.util.FileRenameUtil;
import com.ict.project.util.Paging;
import com.ict.project.vo.CommVO;
import com.ict.project.vo.QnaVO;
import com.ict.project.vo.SuggestionVO;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class SuggestionController {
	@Autowired
	HttpServletResponse response;
	@Autowired
	HttpServletRequest request;
	@Autowired
	HttpSession session;
	@Autowired
	ServletContext application;
	@Autowired
	SuggestionService s_Service;

	@Autowired
	TestService t_Service;

	private List<SuggestionVO> sg_r_list;

	// 메인페이지로 이동시 고충 및 건의사항 전체 목록을 반환하는 기능
	@RequestMapping("suggMain")
	public ModelAndView requestMethodName(String cPage, String qname,String c_check) {
		ModelAndView mv = new ModelAndView();
		Paging page = null;

		QnaVO[] ar = t_Service.getList(qname,
				"0",
				String.valueOf(t_Service.count(qname)));
		

		List<QnaVO> list = new ArrayList<>();
		if(ar != null){
			for(int i =0; i<ar.length; i++){
				boolean b = false;
				if(ar[i].getC_list().size() >0){
					b = true;
					ar[i].setC_check(b);
				}else{
					list.add(ar[i]);
					ar[i].setC_check(b);
				}
			}
		}
		if(c_check.equals("1")){
			//미답변인경우에는 리스트 뽑기
			if(list != null && !list.isEmpty()){
				ar = new QnaVO[list.size()];
				list.toArray(ar);
			}
			mv.addObject("ar", ar);
		}else{
			//전체인 경우에는 페이징
			page = new Paging();
			page.setTotalRecord(t_Service.count(qname));
			page.setNowPage(Integer.parseInt(cPage));
			mv.addObject("page", page);
			ar = t_Service.getList(qname, String.valueOf(page.getBegin()),String.valueOf(page.getEnd()));
			if(ar != null){
				for(int i =0; i<ar.length; i++){
					boolean b = false;
					if(ar[i].getC_list().size() >0){
						b = true;
					}
					ar[i].setC_check(b);

				}
			}
			mv.addObject("ar", ar);
		}
		mv.setViewName("/jsp/admin/schoolRecord/suggList_ajax");
		return mv;
	}

	@RequestMapping("viewSugg_s")
	public ModelAndView viewSugg_s(String qna_idx) {
		ModelAndView mv = new ModelAndView();
		QnaVO vo = t_Service.getqna(qna_idx);
		mv.addObject("svo", vo);
		//System.out.println(vo.getC_list().size());
		mv.setViewName("/jsp/admin/schoolRecord/view_ajax");
		return mv;
	}


	// 고충 및 건의사항 메뉴 클릭시 메인페이지로 이동
	@RequestMapping("suggestionList")
	public String suggestionList() {
		return "/jsp/admin/schoolRecord/suggestionList";
	}

	@RequestMapping("addComm")
	@ResponseBody
	public Map<String,Integer> addComm(CommVO cvo) {
		Map<String,Integer> map = new HashMap<>();
		
		return map;
	}
	
}
