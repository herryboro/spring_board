package com.herryboro.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.herryboro.board.service.BoardService;
import com.herryboro.board.vo.BoardVO;

import net.webjjang.util.PageObject;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	// 자동 DI를 적용시켜주는 어노테이션 2가지 - Autowired, Inject
	@Autowired
	private BoardService boardService;
	
	// 게시판 리스트
	@GetMapping("/list.do")
	public String list(PageObject pageObject, Model model) {	
		model.addAttribute("list", boardService.list(pageObject));
		model.addAttribute("pageObject", pageObject);
		System.out.println("BoardController pageObject: " + pageObject);
		return "/board/list";
	}
	
	// 게시판 글보기
	@GetMapping("/view.do")
	public String view(int no, int inc, Model model, PageObject pageObject) {
		model.addAttribute("vo", boardService.view(no, inc));
		return "board/view";
	}
	
	// 게시판 글보기
	@GetMapping("/write.do")
	public String writeForm() {
		return "board/write";
	}
	
	// 게시판 글쓰기
	@PostMapping("/write.do")
	public String write(BoardVO vo) {
		boardService.write(vo);
		return "redirect:list.do";
	}
	
	// 게시판 수정폼
	@GetMapping("/update.do")
	public String updateForm(Model model, int no, int inc) {
		return "board/update";
	}
	
	// 게시판 수정 처리
	@PostMapping("/update.do")
	public String update(BoardVO vo) {
		return "redirect:view.do?no=" + vo.getNo() + "&inc=0";
	}
	
	// 게시판 삭제 처리
	@PostMapping("/delete.do")
	public String delete(BoardVO vo) {
		return "redirect:list.do";
	}
}
