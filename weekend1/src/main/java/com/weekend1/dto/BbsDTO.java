package com.weekend1.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BbsDTO {
	
	public int bbsId;			// 고유식별자
	public String bbsSubject;	// 제목
	public String bbsContents;	// 내용
	public String bbsType;		// 게시글 타입
	public String relplyCnt;	// 댓글 개수
	public String hitCnt;		// 조회수
	public String replyYn;		// 댓글 허용 여부
	public String useYn;		// 사용여부
	public String regId;		// 게시글 작성자
	public Date regDttm;		// 게시글 작성일시
	public String modId;		// 게시글 수정자
	public Date modDttm;		// 게시글 수정일시
	public String memberName;	// 
	public String codeName;
	public String replyCnt;
	public int rowNum;
	public String regName;
}
