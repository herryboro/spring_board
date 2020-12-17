package com.herryboro.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.herryboro.board.mapper.BoardMapper;
import com.herryboro.board.vo.BoardVO;

import net.webjjang.util.PageObject;

@Service
public class BoardService {
	
	@Autowired
	private BoardMapper mapper;
	
	public List<BoardVO> list(PageObject pageObject) {
		pageObject.setTotalRow(mapper.getCount());
		return mapper.list(pageObject);
	}

	public BoardVO view(int no) {
		return mapper.view(no);
	}

	public Integer write(BoardVO vo) {
		return mapper.write(vo);
	}
}
