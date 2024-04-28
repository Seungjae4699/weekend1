package com.weekend1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.weekend1.dao.BbsDAO;
import com.weekend1.dto.BbsCodeDTO;
import com.weekend1.dto.BbsDTO;
import com.weekend1.dto.BbsMemberDTO;
import com.weekend1.dto.BbsReplyDTO;
import com.weekend1.dto.BbsSearchDTO;

@Service
public class BbsServiceImpl implements BbsService {

	@Autowired
	private BbsDAO bbsDAO;

	@Override
	public List<BbsDTO> getBoardList(BbsSearchDTO bbsSearchDTO) {
		return bbsDAO.getBoardList(bbsSearchDTO);
	}

	@Override
	public void writeBoard(BbsDTO bbsDTO) {
		bbsDAO.writeBoard(bbsDTO);
				
	}

	@Override
	public BbsDTO detailBoard(BbsDTO bbsDTO) {
		return bbsDAO.detailBoard(bbsDTO);
	}

	@Override
	public void updateReadCnt(int bbsId) {
		bbsDAO.updateReadCnt(bbsId);
	}
	
	@Override
	public void deleteBoard(BbsDTO bbsDTO) {
		bbsDAO.deleteBoard(bbsDTO);
		
	}

	@Override
	public void modifyBoard(BbsDTO bbsDTO) {
		bbsDAO.modifyBoard(bbsDTO);
		
	}

	@Override
	public int boardListCnt(BbsSearchDTO bbsSearchDTO) {
		return bbsDAO.boardListCnt(bbsSearchDTO) ;
	}

	@Override
	public List<BbsReplyDTO> replyList(BbsReplyDTO bbsReplyDTO) {
		return bbsDAO.replyList(bbsReplyDTO);
		
	}

	@Override
	public void writeReply(BbsReplyDTO bbsReplyDTO) {
		bbsDAO.writeReply(bbsReplyDTO);
		
	}

	@Override
	public void deleteReply(BbsReplyDTO bbsReplyDTO) {
		bbsDAO.deleteReply(bbsReplyDTO);
		
	}

	@Override
	public List<BbsMemberDTO> getMember(BbsMemberDTO bbsMemberDTO) {
		return bbsDAO.getMember(bbsMemberDTO);
	}

	@Override
	public List<BbsCodeDTO> getCode(BbsCodeDTO bbsCodeDTO) {
		return bbsDAO.getCode(bbsCodeDTO);
	}

	
}
