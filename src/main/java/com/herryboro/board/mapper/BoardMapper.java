package com.herryboro.board.mapper;

import java.util.List;

import com.herryboro.board.vo.BoardVO;

import net.webjjang.util.PageObject;

public interface BoardMapper {
	
	// 게시판 리스트
	public List<BoardVO> list(PageObject pageObject);
	
	// 전체 데이터를 가져오는 메서드
	public Integer getCount();
	
	// 게시판 글보기
	public BoardVO view(int no);
	
	// 조회수 증가
	public void increase(int no);
	
	// 게시판 글쓰기
	public Integer write(BoardVO vo);
	
	// 게시판 글 수정
	public Integer update(BoardVO vo);
	
	// 글 삭제
	public Integer delete(int no);
}
