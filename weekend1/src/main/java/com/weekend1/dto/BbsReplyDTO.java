package com.weekend1.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BbsReplyDTO {

	public int replyId;			// 테이블 고유 식별자
	public int bbsId; 			// 게시글 고유 식별자
	public String replyContents;// 댓글 내용
	public String useYn;		// 사용여부
	public String regId;		// 등록자
	public Date regDttm;		// 등록일
	public String modId;		// 수정자
	public Date modDttm;		// 수정일
	public String memberName;
	public int rowNum;
}
