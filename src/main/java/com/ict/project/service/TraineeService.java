package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.TraineeMapper;
import com.ict.project.vo.TraineeVO;

@Service
public class TraineeService {
    @Autowired
    private TraineeMapper t_mapper;

    // 훈련생 목록을 배열로 반환하는 기능
    public TraineeVO[] getTraineeList(String begin, String end) {
        TraineeVO[] ar = null;

        List<TraineeVO> list = t_mapper.list();
        if(list != null && list.size() > 0) {
            ar = new TraineeVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    public TraineeVO view(String tr_idx){
        return t_mapper.view(tr_idx);
    }

    public TraineeVO tlist(String tr_idx, String c_idx){
        return t_mapper.tlist(tr_idx, c_idx);
    }

    public int trainedit(TraineeVO tvo){
        return t_mapper.trainedit(tvo);
    }
    
    public TraineeVO getCard(String tr_idx){
        return t_mapper.getcard(tr_idx);
    }

    public int status(String tr_idx, String tr_nowstatus){
        return t_mapper.nowstatus(tr_idx,tr_nowstatus);
    }
    
    public TraineeVO[] all(){
        TraineeVO[] aa = null;

        List<TraineeVO> list = t_mapper.all();
        if(list != null && !list.isEmpty()){
            aa = new TraineeVO[list.size()];
            list.toArray(aa);
        }
        return aa;
    }
    
    public TraineeVO[] clist(String c_idx, String begin, String end){
        TraineeVO[] ab = null;

        List<TraineeVO> list = t_mapper.clist(c_idx);
        if(list != null && !list.isEmpty()){
            ab = new TraineeVO[list.size()];
            list.toArray(ab);
        }
        return ab;
    }

    public int getCount(){
        return t_mapper.count();
    }
    
    public int delete(String tr_idx, String c_idx){
        return t_mapper.del(tr_idx, c_idx);
    }
  
    public TraineeVO[] getCourseTraineeList(String c_idx, String begin, String end){
        TraineeVO[] ar = null;

        List<TraineeVO> list = t_mapper.course_list(c_idx, begin, end);
        if(list != null && list.size() > 0) {
            ar = new TraineeVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    public TraineeVO[] getCourseTraineeSearchList(String select, String value, String year, String begin, String end){
        TraineeVO[] ar = null;

        List<TraineeVO> list = t_mapper.course_search(select, value, year, begin, end);
        if(list != null && list.size() > 0) {
            ar = new TraineeVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    public TraineeVO[] getCourseTraineeSearchValueList(String c_idx, String select, String value, String year, String begin, String end){
        TraineeVO[] ar = null;

        List<TraineeVO> list = t_mapper.course_searchValue(c_idx, select, value, year, begin, end);
        if(list != null && list.size() > 0) {
            ar = new TraineeVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    public int getCourseTraineeCount(String c_idx){
        return t_mapper.course_count(c_idx);
    }

    public int getCourseSearchCount(String select,String value,String year){
        return t_mapper.search_count(select,value,year);
    }

    public int getCourseSearchValueCount(String c_idx, String select,String value,String year){
        return t_mapper.searchValue_count(c_idx, select,value,year);

    }

    public int getCounsel_date(String tr_idx, String ss_end, String ss_num){
        return t_mapper.counsel_date(tr_idx, ss_end, ss_num);
    }

    public int getTCount(){
        return t_mapper.traineeReg_count();
    }

    public TraineeVO[] getTList(String begin,String end){
        TraineeVO[] ar = null;
        List<TraineeVO> list = t_mapper.traineeReg(begin, end);
        if(list != null && !list.isEmpty()){
            ar = new TraineeVO[list.size()];
            list.toArray(ar);
        }
        return ar;
    }
}
