package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.WeeklyMeetingVO;

public interface WeeklyMeetingMapper {
    List<WeeklyMeetingVO> all();

    int add(WeeklyMeetingVO vo);

    int del(String wk_idx);

    WeeklyMeetingVO getWk(String wk_idx);

    int edit(WeeklyMeetingVO wvo);

    int search_count(String select, String value);

    List<WeeklyMeetingVO> search(String select, String value, String begin, String end);

}
