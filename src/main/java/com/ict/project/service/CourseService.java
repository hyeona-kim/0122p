package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.CourseMapper;
import com.ict.project.vo.CourseVO;
import com.ict.project.vo.StaffVO;

@Service
public class CourseService {

    @Autowired
    private CourseMapper c_mapper;

    // 과정 검색하는 기능
    public CourseVO[] searchCourse(String select, String value, String year, String begin, String end) {
        CourseVO[] ar = null;

        List<CourseVO> list = c_mapper.search(select, value, year, begin, end);
        if (list != null && list.size() > 0) {
            ar = new CourseVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    // 과정 목록을 배열로 반환하는 기능
    public CourseVO[] getCourseList(String begin, String end) {
        CourseVO[] ar = null;

        List<CourseVO> list = c_mapper.list(begin, end);
        if (list != null && list.size() > 0) {
            ar = new CourseVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    public CourseVO[] getList() {
        CourseVO[] ar = null;

        List<CourseVO> list = c_mapper.all();
        if (list != null && list.size() > 0) {
            ar = new CourseVO[list.size()];
            list.toArray(ar);
        }
        return ar;
    }

    // 과정 추가하는 기능
    public int addCourse(CourseVO vo) {
        return c_mapper.add(vo);
    }

    // 과정명을 출력하기 위해 해당 과정의 정보를 가져오는 기능
    public CourseVO getCourse(String c_idx) {
        return c_mapper.getCourse(c_idx);
    }

    public CourseVO getCourse2(String c_idx) {
        return c_mapper.getCourse2(c_idx);
    }

    public CourseVO getCourse3(String c_idx) {
        return c_mapper.getCourse3(c_idx);
    }

    // 과정 삭제하는 기능
    public int deleteCourse(String c_idx) {
        return c_mapper.del(c_idx);
    }

    // 과정 수정하는 기능
    public int editCourse(CourseVO vo) {
        return c_mapper.edit(vo);
    }

    // 전체 과정수를 반환하는 기능
    public int getCount() {
        return c_mapper.count();
    }

    public int time_exel(String c_idx, String c_timeExel) {
        return c_mapper.time_exel(c_idx, c_timeExel);
    }

    // 검색 결과에서의 Paging기법을 위해
    // 다시 totalRecord를 검색하는 기능
    public int getSearchCount(String select, String value, String year) {
        return c_mapper.search_count(select, value, year);
    }

    public int reg_count(String year) {
        return c_mapper.reg_count(year);
    }

    public CourseVO[] reg_search(String year) {
        CourseVO[] ar = null;

        List<CourseVO> list = c_mapper.reg_search(year);
        if (list != null && list.size() > 0) {
            ar = new CourseVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    public int staffCourse_count(String sf_idx) {
        return c_mapper.staffCourse_count(sf_idx);
    }

    public CourseVO[] staffCourse(String sf_idx, String begin, String end) {
        CourseVO[] ar = null;

        List<CourseVO> list = c_mapper.staffCourse(sf_idx, begin, end);
        if (list != null && list.size() > 0) {
            ar = new CourseVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    public int tnadd(String tn_idx, String c_idx) {
        return c_mapper.tnAdd(tn_idx, c_idx);

    }

    public CourseVO[] search_ct(String c_idx, String ct_idx) {
        CourseVO[] ar = null;

        List<CourseVO> list = c_mapper.search_ct(c_idx, ct_idx);
        if (list != null && list.size() > 0) {
            ar = new CourseVO[list.size()];
            list.toArray(ar);
        }
        return ar;

    }

    public int update_f_file(String f_file, String tr_idx) {
        return c_mapper.update_f_file(f_file, tr_idx);
    }
    public CourseVO[] staffSearchCourse(String sf_idx, String select, String value, String year, String begin, String end){

        CourseVO[] ar = null;

        List<CourseVO> list = c_mapper.staffSearchCourse(sf_idx, select, value, year, begin, end);
        if (list != null && list.size() > 0) {
            ar = new CourseVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    public int staffSearchCourse_count(String sf_idx, String select, String value, String year) {
        return c_mapper.staffSearchCourse_count(sf_idx, select, value, year);
    }
}