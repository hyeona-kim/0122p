package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.BoardVO;
import com.ict.project.vo.CourseVO;

public interface BoardMapper {
    int add(BoardVO vo);
    int addReply(BoardVO vo);
    BoardVO getBoard(String bd_idx);
    int cntNonNotice(String c_idx);
    List<BoardVO> checkNotice(String c_idx, String begin, String end);
    List<BoardVO> viewBoardList(String c_idx, String begin, String end);
    List<BoardVO> searchBoard(String c_idx, String bd_subject,String begin, String end);
    int reCount(String c_idx, String bd_subject);
    int cntBoardList(String c_idx);
    int addHit(String bd_idx);
    int search_both_count(String year, String tag, String value);
    List<CourseVO> searchBothBoard(String year, String tag, String value, String begin, String end);
}