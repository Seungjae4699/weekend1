package com.weekend1.dao;

import java.util.List;

import com.weekend1.dto.BbsCodeDTO;
import com.weekend1.dto.BbsDTO;
import com.weekend1.dto.BbsMemberDTO;
import com.weekend1.dto.BbsReplyDTO;
import com.weekend1.dto.BbsSearchDTO;

public interface BbsDAO {

	public List<BbsDTO> getBoardList(BbsSearchDTO bbsSearchDTO);    // 게시글 목록 가져오기         
	public void writeBoard(BbsDTO bbsDTO);                          // 게시글 글쓰기             
	public BbsDTO detailBoard(BbsDTO bbsDTO);                       // 게시글 상세조회            
	public void updateReadCnt(int bbsId);                           // 조회수 업데이트            
	public void deleteBoard(BbsDTO bbsDTO);                         // 게시글 논리삭제            
	public void modifyBoard(BbsDTO bbsDTO);                         // 게시글 수정              
	public int boardListCnt(BbsSearchDTO bbsSearchDTO);             // 게시글 수 계산            
	public List<BbsReplyDTO> replyList(BbsReplyDTO bbsReplyDTO);    // 댓글 리스트              
	public void writeReply(BbsReplyDTO bbsReplyDTO);                // 댓글 쓰기               
	public void deleteReply(BbsReplyDTO bbsReplyDTO);               // 댓글 삭제               
	public List<BbsMemberDTO> getMember(BbsMemberDTO bbsMemberDTO); // 작성자 정보 DB에서 가져오기    
	public List<BbsCodeDTO> getCode(BbsCodeDTO bbsCodeDTO);         // 공지, 일반 데이터 DB에서 가져오기
}
