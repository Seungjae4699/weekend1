package com.weekend1.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.weekend1.dto.BbsCodeDTO;
import com.weekend1.dto.BbsDTO;
import com.weekend1.dto.BbsMemberDTO;
import com.weekend1.dto.BbsReplyDTO;
import com.weekend1.dto.BbsSearchDTO;

@Repository
public class BbsDAOImpl implements BbsDAO{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<BbsDTO> getBoardList(BbsSearchDTO bbsSearchDTO) {
		return sqlSession.selectList("BbsMapper.getBoardList" , bbsSearchDTO);
	}

	@Override
	public void writeBoard(BbsDTO bbsDTO) {
		sqlSession.insert("BbsMapper.writeBoard" , bbsDTO);
	}

	@Override
	public BbsDTO detailBoard(BbsDTO bbsDTO) {
		return sqlSession.selectOne("BbsMapper.detailBoard" , bbsDTO);
	}
	
	@Override
	public void updateReadCnt(int bbsId) {
		sqlSession.update("BbsMapper.updateReadCnt" , bbsId);
	}

	@Override
	public void deleteBoard(BbsDTO bbsDTO) {
		sqlSession.update("BbsMapper.deleteBoard" , bbsDTO);
	}

	@Override
	public void modifyBoard(BbsDTO bbsDTO) {
		sqlSession.update("BbsMapper.modifyBoard" , bbsDTO);
		
	}

	@Override
	public int boardListCnt(BbsSearchDTO bbsSearchDTO) {
		return sqlSession.selectOne("BbsMapper.boardListCnt" , bbsSearchDTO);
	}

	@Override
	public List<BbsReplyDTO> replyList(BbsReplyDTO bbsReplyDTO) {
		return sqlSession.selectList("BbsMapper.replyList", bbsReplyDTO);
		
	}

	@Override
	public void writeReply(BbsReplyDTO bbsReplyDTO) {
		sqlSession.insert("BbsMapper.writeReply" , bbsReplyDTO);
		
	}

	@Override
	public void deleteReply(BbsReplyDTO bbsReplyDTO) {
		sqlSession.update("BbsMapper.deleteReply" , bbsReplyDTO);
		
	}

	@Override
	public List<BbsMemberDTO> getMember(BbsMemberDTO bbsMemberDTO) {
		return sqlSession.selectList("BbsMapper.getMember" , bbsMemberDTO);
	}

	@Override
	public List<BbsCodeDTO> getCode(BbsCodeDTO bbsCodeDTO) {
		return sqlSession.selectList("BbsMapper.getCode" , bbsCodeDTO);
	}

}
