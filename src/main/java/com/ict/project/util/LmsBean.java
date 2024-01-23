package com.ict.project.util;

import org.springframework.beans.factory.annotation.Autowired;

import com.ict.project.service.CourseTypeService;
import com.ict.project.service.RoomService;
import com.ict.project.service.StaffService;
import com.ict.project.service.TimeService;
import com.ict.project.vo.CourseTypeVO;
import com.ict.project.vo.RoomVO;
import com.ict.project.vo.StaffVO;
import com.ict.project.vo.SuggestionVO;
import com.ict.project.vo.TimeVO;

public class LmsBean {
	@Autowired
	TimeService t_Service;
	@Autowired
	StaffService sf_Service;
	@Autowired
	CourseTypeService ct_Service;
	@Autowired
	RoomService r_Service;
	
	public TimeVO searchTime(String ti_idx) {
		TimeVO tvo = null;
		TimeVO[] ar = t_Service.getList();
		for(TimeVO vo : ar) {
			if(vo.getTi_idx().equalsIgnoreCase(ti_idx)) {
				tvo = vo;
				break;
			}
		}
		return tvo;
	}
	
	public StaffVO searchStaff(String t_idx) {
		StaffVO tvo = null;
		StaffVO[] ar = sf_Service.getList();
		for(StaffVO vo : ar) {
			if(vo.getSf_idx().equals(t_idx)) {
				tvo= vo;
				break;
			}
		}
		return tvo;
	}
	
	public CourseTypeVO searchCourseType(String ct_idx) {
		CourseTypeVO cvo= null;
		CourseTypeVO[] ar = ct_Service.getList();
		for(CourseTypeVO vo : ar) {
			if(vo.getCt_idx().equals(ct_idx)) {
				cvo = vo;
				break;
			}
		}
		return cvo;
	}
	
	public RoomVO searchRoom(String r_idx) {
		RoomVO rvo  = null;
		RoomVO[] ar = r_Service.getList();
		for(RoomVO vo : ar) {
			if(vo.getR_idx().equals(r_idx)) {
				rvo = vo;
				break;
			}
		}
		return rvo;
	}
	
	public StaffVO searchStaff2(String t_name) {
		StaffVO ar = null;
		ar = sf_Service.searchList(t_name);
		
		return ar;
	}
	
	public CourseTypeVO searchCourseType2(String ct_name) {
		CourseTypeVO ar = null;
		ar = ct_Service.SearchList(ct_name);
		
		return ar;
	}
	
	public RoomVO searchRoom2(String r_name) {
		RoomVO ar = null;
		ar = r_Service.searchList(r_name);
		
		return ar;
	}
}
