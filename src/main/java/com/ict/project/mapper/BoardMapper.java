package com.ict.project.mapper;

import java.util.List;

import com.ict.project.vo.BoardVO;

public interface BoardMapper {
    List<BoardVO> all(String begin, String end);
    int add(BoardVO vo);
    int addReply(BoardVO vo);
    int count();
    List<BoardVO> search(String subject,String begin, String end);
    int reCount(String subject);
    BoardVO getBoard(String bd_idx);
    int cntNonNotice();
    List<BoardVO> checkNotice(String begin, String end);
    List<BoardVO> viewBoardList(String c_idx, String begin, String end);
    int cntBoardList(String c_idx);
    int addHit(String bd_idx);
}