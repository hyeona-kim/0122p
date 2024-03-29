package com.ict.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.TraineeMapper;
import com.ict.project.vo.TraineeVO;

import lombok.val;

@Service
public class TraineeService {
    @Autowired
    private TraineeMapper t_mapper;

    // 훈련생 목록을 배열로 반환하는 기능
    public TraineeVO[] getTraineeList(String begin, String end) {
        TraineeVO[] ar = null;

        List<TraineeVO> list = t_mapper.list();
        if (list != null && list.size() > 0) {
            ar = new TraineeVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    public TraineeVO view(String tr_idx) {
        return t_mapper.view(tr_idx);
    }

    public TraineeVO tlist(String tr_idx, String c_idx) {
        return t_mapper.tlist(tr_idx, c_idx);
    }

    public int trainedit(TraineeVO tvo) {
        return t_mapper.trainedit(tvo);
    }

    public TraineeVO getCard(String tr_idx) {
        return t_mapper.getcard(tr_idx);
    }

    public int status(String tr_idx, String tr_nowstatus) {
        return t_mapper.nowstatus(tr_idx, tr_nowstatus);
    }

    public TraineeVO[] all() {
        TraineeVO[] aa = null;

        List<TraineeVO> list = t_mapper.all();
        if (list != null && !list.isEmpty()) {
            aa = new TraineeVO[list.size()];
            list.toArray(aa);
        }
        return aa;
    }

    public TraineeVO[] clist(String c_idx, String begin, String end) {
        TraineeVO[] ab = null;

        List<TraineeVO> list = t_mapper.clist(c_idx);
        if (list != null && !list.isEmpty()) {
            ab = new TraineeVO[list.size()];
            list.toArray(ab);
        }
        return ab;
    }

    public int getCount() {
        return t_mapper.count();
    }

    public int delete(String tr_idx, String c_idx) {
        return t_mapper.del(tr_idx, c_idx);
    }

    public int etcedit(TraineeVO tvo) {
        return t_mapper.etcedit(tvo);
    }

    public TraineeVO[] getCourseTraineeList(String c_idx, String begin, String end) {
        TraineeVO[] ar = null;

        List<TraineeVO> list = t_mapper.course_list(c_idx, begin, end);
        if (list != null && list.size() > 0) {
            ar = new TraineeVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    public TraineeVO[] getCourseTraineeSearchList(String select, String value, String year, String begin, String end) {
        TraineeVO[] ar = null;

        List<TraineeVO> list = t_mapper.course_search(select, value, year, begin, end);
        if (list != null && list.size() > 0) {
            ar = new TraineeVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    public TraineeVO[] getCourseTraineeSearchValueList(String c_idx, String select, String value, String year,
            String begin, String end) {
        TraineeVO[] ar = null;

        List<TraineeVO> list = t_mapper.course_searchValue(c_idx, select, value, year, begin, end);
        if (list != null && list.size() > 0) {
            ar = new TraineeVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    public int getCourseTraineeCount(String c_idx) {
        return t_mapper.course_count(c_idx);
    }

    public int getCourseSearchCount(String select, String value, String year) {
        return t_mapper.search_count(select, value, year);
    }

    public int getCourseSearchValueCount(String c_idx, String select, String value, String year) {
        return t_mapper.searchValue_count(c_idx, select, value, year);

    }

    public int setCounsel_date(String tr_idx, String ss_end, String ss_num) {
        return t_mapper.counsel_date(tr_idx, ss_end, ss_num);
    }

    public int getTCount(String c_idx, String year, String ct_idx, String select, String value) {
        return t_mapper.traineeReg_count(c_idx, year, ct_idx, select, value);
    }

    public TraineeVO[] getTList(String begin, String end, String c_idx, String year, String ct_idx, String select,
            String value) {
        TraineeVO[] ar = null;
        List<TraineeVO> list = t_mapper.traineeReg(begin, end, c_idx, year, ct_idx, select, value);
        if (list != null && !list.isEmpty()) {
            ar = new TraineeVO[list.size()];
            list.toArray(ar);
        }
        return ar;
    }

    public int addTrainee(Map<String, List<TraineeVO>> map) {
        return t_mapper.add(map);
    }

    public TraineeVO[] getEs(String es_idx) {
        TraineeVO[] ar = null;

        List<TraineeVO> list = t_mapper.getEs(es_idx);
        if (list != null && list.size() > 0) {
            ar = new TraineeVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    public TraineeVO[] follup(String begin, String end, String c_idx, String value, String select) {

        TraineeVO[] ar = null;

        List<TraineeVO> list = t_mapper.follwup(begin, end, c_idx, value, select);
        if (list != null && list.size() > 0) {
            ar = new TraineeVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    public int follwupcount(String value, String select) {

        int cnt = t_mapper.follwupcount(value, select);

        return cnt;

    }
}
