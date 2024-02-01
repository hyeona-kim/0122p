package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.WeeklyMeetingMapper;
import com.ict.project.vo.CounselingdetailVO;
import com.ict.project.vo.StaffVO;
import com.ict.project.vo.WeeklyMeetingVO;

@Service
public class WeeklyMeetingService {

    @Autowired
    private WeeklyMeetingMapper wk_mapper;

    public WeeklyMeetingVO[] getWeeklyMeetingList() {
        WeeklyMeetingVO[] ar = null;

        List<WeeklyMeetingVO> list = wk_mapper.all();
        if(list != null && list.size() > 0) {
            ar = new WeeklyMeetingVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    public int addWeeklyMeeting(WeeklyMeetingVO vo) {
        return wk_mapper.add(vo);
    }

    public int delWeeklyMeeting(String wk_idx) {
        return wk_mapper.del(wk_idx);
    }
    public WeeklyMeetingVO getWk(String wk_idx) {
        return wk_mapper.getWk(wk_idx);
    }
    
    public int editWeeklyMeeting(WeeklyMeetingVO wvo) {
        return wk_mapper.edit(wvo);
    }
    
    public int getSearchCount(String select, String value) {
        return wk_mapper.search_count(select, value);
    }

    
    public WeeklyMeetingVO[] searchweeklyMeeting(String select, String value, String begin, String end) {
        WeeklyMeetingVO[] ar = null;

        List<WeeklyMeetingVO> list = wk_mapper.search(select, value, begin, end);
        if(list != null && list.size() > 0) {
            ar = new WeeklyMeetingVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

}
