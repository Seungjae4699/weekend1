package com.weekend1.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.weekend1.dto.BbsCodeDTO;
import com.weekend1.dto.BbsDTO;
import com.weekend1.dto.BbsMemberDTO;
import com.weekend1.dto.BbsPageDTO;
import com.weekend1.dto.BbsReplyDTO;
import com.weekend1.dto.BbsSearchDTO;
import com.weekend1.service.BbsService;

@Controller
public class BbsController {

	@Autowired
	private BbsService bbsService;
	
	@RequestMapping(value="/BbsList")
	public ModelAndView getBoardList(@ModelAttribute BbsSearchDTO bbsSearchDTO) {
		
		ModelAndView mv = new ModelAndView();
		
		// 최초 화면 로딩에 페이지 길이 값이 없을 경우 페이지에 표시할 게시글 수를 10으로 세팅
		if (bbsSearchDTO.getPageLength() == null) {
			bbsSearchDTO.setPageLength(10);
		}
		
		// 최초 화면 로딩시 현재 페이지의 값이 없을 경우 현재 페이지 번호 1로 세팅합니다.
		if (bbsSearchDTO.getPage() == null || bbsSearchDTO.getPage() == "") {
			bbsSearchDTO.setPage("1");
		}
		
		// 최초 화면 로딩시 공지글만 표시
		if (bbsSearchDTO.getBbsType() == null || bbsSearchDTO.getBbsType() == "" ) {
			bbsSearchDTO.setBbsType("notice");
		}
		
		// 하단 페이지 번호 변수
		int cPage = 0;
		
		// 페이지의 값을 String에서 int형으로 바꾸고, 내부에러가 발생할 경우, 1로 고정
		try {
			cPage = Integer.parseInt(bbsSearchDTO.getPage());
		} catch (NumberFormatException e) {
			cPage = 1;
		}
		
		// 리스트 불러오는 메소드 호출
		List<BbsDTO> BbsBoardList = bbsService.getBoardList(bbsSearchDTO);
		
		// 게시글 개수 계산하는 메소드
		int totalCnt = bbsService.boardListCnt(bbsSearchDTO);
		
		// 페이지 정보(현재페이지, 게시글 총 개수, 페이지 길이)
		BbsPageDTO bbsPageDTO = getPageData(cPage, totalCnt, bbsSearchDTO.getPageLength());
		
		mv.setViewName("bbs/bbsList");
		
		mv.addObject("bsList" , BbsBoardList); // 게시글 리스트 데이터
		mv.addObject("pgList" , bbsPageDTO);   // 게시글 페이지 데이터
		mv.addObject("shList" , bbsSearchDTO); // 게시글 검색	데이터
		
		return mv;
	}
	// 메소드에 cPage = 현재페이지(블록이 5개 존재) , totalCnt = 전체 페이지 블록수, pageLength = 한 화면당 페이지 블록수 
	public BbsPageDTO getPageData(int cPage, int totalCnt, int pageLength) {
		
		BbsPageDTO bbsPageDTO = new BbsPageDTO();
		
		// 한 화면당 페이지 블록수 5개로 지정
		int len = 5;
		
		// 현재 블록 = 페이지 5로 나눴을때 나머지가 0이면 블록수 나눈 몫 , 0이 아닐시에 몫에 1을 더해준다 >
		//ex)현재페이지 10이면 페이지가 2개 되며 11이면 1추가해주어 페이지가 3개가 됨
		int currentBlock = cPage % len == 0 ? cPage / len : (cPage / len) + 1;
		
		// 스타트 페이지 = 위에서 구한 currentBlock-1 후 len = 5 곱해주고 1 더해준다
		// ex) 페이지 2개면 스타트 페이지 6이됨
		int startPage = (currentBlock - 1) * len + 1;
		
		// 끝 페이지 = 위에서 구한 스타트 페이지에 5 더해주고 1빼줌
		int endPage = startPage + len - 1;
		
		// 총 페이지 = 전체 페이지 블록수를 pageLength로 나눠서 나머지 0=>나눠준 몫 0 아닐시에는 몫+1 해준다
		int totalPages = totalCnt % pageLength == 0 ? totalCnt / pageLength : (totalCnt / pageLength) + 1;
		
		// 총 페이지가 0이면 1로 지정
		if (totalPages == 0) {
		    totalPages = 1;
		}
		
		// 끝 페이지가 총 페이지보다 크면 같게 처리
		if (endPage > totalPages) {
		    endPage = totalPages;
		}
		
		// 끝 페이지가 총 페이지보다 크면 같게 처리
		if (endPage > totalPages) {
		    endPage = totalPages;
		}
		// DTO에 있는 객체들을 각각 문자열로 반환해주는 기능 실행
		bbsPageDTO.setTempPage(Integer.toString(cPage));		
		bbsPageDTO.setStartPage(Integer.toString(startPage));
		bbsPageDTO.setEndPage(Integer.toString(endPage));		
		bbsPageDTO.setTotalPages(Integer.toString(totalPages));	
		bbsPageDTO.setTotalRows(Integer.toString(totalCnt));
		
		return bbsPageDTO;
	}
	
	@RequestMapping(value="/BbsWrite")
	public ModelAndView writeBoard() {
		
		ModelAndView mv = new ModelAndView();
		
		// 멤버테이블에서 조회해서 등록자 가져옴 
		BbsMemberDTO bbsMemberDTO = new BbsMemberDTO();
		List<BbsMemberDTO> bbsMember = bbsService.getMember(bbsMemberDTO);
		
		// 코드테이블 조회 구분 가져옴
		BbsCodeDTO bbsCodeDTO = new BbsCodeDTO();
		List<BbsCodeDTO> bbsCode = bbsService.getCode(bbsCodeDTO);
		
		mv.setViewName("bbs/bbsRegist");
		mv.addObject("bbsMember" , bbsMember);
		mv.addObject("bbsCode" , bbsCode);
		
		return mv;
	}
	
	// 자바 객체를 HTTP 응답 본문의 객체로 변환하여 클라이언트로 전송
	@ResponseBody
	@RequestMapping(value="/BbsWriteAc")
	public String writeBoardAc(@RequestBody BbsDTO bbsDTO) {
	// 서버에서 HTTP요청 본문에 담긴 값들을 자바객체로 변환
		String writeStr = "true";
		
		try {
			bbsService.writeBoard(bbsDTO);
			
		} catch (Exception e) {

			writeStr = "false";
		}
		
		return writeStr;
	}
	
	@RequestMapping(value="/BbsDetail")
	public ModelAndView detailBoard(@ModelAttribute BbsDTO bbsDTO , 
									@ModelAttribute BbsReplyDTO bbsReplyDTO) {		
		ModelAndView mv = new ModelAndView();
		// 상세내용 가져오기
		BbsDTO boardDetail = bbsService.detailBoard(bbsDTO);
		// 조회수 업데이트
		bbsService.updateReadCnt(bbsDTO.getBbsId());
		// 상세페이지 댓글 가져오기
		List<BbsReplyDTO> replyList = bbsService.replyList(bbsReplyDTO);
		
		mv.setViewName("bbs/bbsDetail");
		mv.addObject("bdDetail" , boardDetail);
		mv.addObject("rpList" , replyList);
		
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="/writeReply")
	public String writeReply(@RequestBody BbsReplyDTO bbsReplyDTO) {
		
		String writeReplyStr = "true";
		
		try {
			bbsService.writeReply(bbsReplyDTO);
			
		} catch (Exception e) {
			
			writeReplyStr = "false";
		}
		
		return writeReplyStr;
	}
	
	@ResponseBody
	@RequestMapping(value="/deleteReply")
	public String deleteReply(@RequestBody BbsReplyDTO bbsReplyDTO) {
		
		String deleteReplyStr = "true";
		
		try {
			bbsService.deleteReply(bbsReplyDTO);
			
		} catch (Exception e) {
			
			deleteReplyStr = "false";
		}
		
		return deleteReplyStr;
	}
		
	@ResponseBody
	@RequestMapping(value="/deleteAc")
	public String deleteBoardAc(@RequestBody BbsDTO bbsDTO) {
		
		String deleteStr = "true";
		
		try {
			bbsService.deleteBoard(bbsDTO);
			
		} catch (Exception e) {
			
			deleteStr = "false";
		}
		
		return deleteStr;
	}
	
	@RequestMapping(value="/Bbsmodify")
	public ModelAndView modifyBoard(@ModelAttribute BbsDTO bbsDTO) {
		
		ModelAndView mv = new ModelAndView();
		
		BbsDTO detailData = bbsService.detailBoard(bbsDTO);
		
		BbsCodeDTO bbsCodeDTO = new BbsCodeDTO();
		List<BbsCodeDTO> bbsCode = bbsService.getCode(bbsCodeDTO);
		
		mv.setViewName("bbs/bbsModify");
		mv.addObject("dtData", detailData);
		mv.addObject("bbsCode" , bbsCode);
		
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="/modifyAc")
	public String modifyAc(@RequestBody BbsDTO bbsDTO) {
		
		String modifyStr = "true";
		
		try {
			bbsService.modifyBoard(bbsDTO);
				

		} catch (Exception e) {

			modifyStr = "false";
		}
		
		return modifyStr;
	}
	
}
