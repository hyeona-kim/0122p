package com.ict.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.project.mapper.BoardMapper;
import com.ict.project.vo.BoardVO;

@Service
public class BoardService {
    @Autowired
    private BoardMapper b_mapper;

    // 게시판 목록 출력하는 기능
    public BoardVO[] list(String begin, String end) {
        BoardVO[] ar = null;

        List<BoardVO> list = b_mapper.all(begin, end);
        if(list != null && list.size() > 0){
            ar = new BoardVO[list.size()];
            list.toArray(ar);
        }
        return ar;
    }

    // 게시글 추가하는 기능
    public int addBoard(BoardVO vo) {
        return b_mapper.add(vo);
    }

    // 답변 등록하는 기능
    public int addReply(BoardVO vo) {
        return b_mapper.addReply(vo);
    }

    // paging 객체 생성을 위한 totalRecord를 구하는 기능
    public int getTotalRecord() {
        return b_mapper.count();
    }

    // 게시물 검색하는 기능
    public BoardVO[] searchBoard(String subject, String begin, String end) {
        BoardVO[] ar = null;
        List<BoardVO> list = b_mapper.search(subject, begin, end);
        if(list != null && list.size() > 0) {
            ar = new BoardVO[list.size()];
            list.toArray(ar);
        }
        return ar;
    }

    // 게시물 검색 후 Paging기법을 다시 적용하기 위해
    // totalRecord를 다시 구하는 기능
    public int reGetTotalRecord(String c_idx, String bd_subject) {
        return b_mapper.reCount(c_idx, bd_subject);
    }

    // 게시물 보기 기능을 위해 해당 게시물 검색하는 기능
    public BoardVO getBoard(String bd_idx) {
        return b_mapper.getBoard(bd_idx);
    }

    // 공지사항이 아닌 게시물들의 총 개수를 구하는 기능
    public int cntNonNotice(String c_idx) {
        return b_mapper.cntNonNotice(c_idx);
    }

    // 공지 숨김처리 클릭했을 때 공지 아닌 글들만 검색하는 기능
    public BoardVO[] checkNotice(String c_idx, String begin, String end) {
        BoardVO[] ar = null;

        List<BoardVO> list = b_mapper.checkNotice(c_idx, begin, end);
        if(list != null && list.size() > 0) {
            ar = new BoardVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    // 과정별 게시판 목록을 배열로 반환하는 기능
    public BoardVO[] viewBoardList(String c_idx, String begin, String end) {
        BoardVO[] ar = null;

        List<BoardVO> list = b_mapper.viewBoardList(c_idx, begin, end);
        if(list != null && list.size() > 0) {
            ar = new BoardVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }

    // 과정별 게시판의 Paging을 위해 해당 게시판의 totalRecord를 구하는 기능
    public int cntBoardList(String c_idx){
        return b_mapper.cntBoardList(c_idx);
    }

    // 조회수 증가하는 기능
    public int addHit(String bd_idx) {
        return b_mapper.addHit(bd_idx);
    }
}
