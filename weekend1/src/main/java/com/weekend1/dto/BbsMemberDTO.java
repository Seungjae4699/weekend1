package com.weekend1.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
public class BbsMemberDTO {

	public int memberId;		 // 멤버 고유식별자
	public String memberName;	 // 멤버 이름
	public String useYn;		 // 사용여부
	public String regId;		 // 등록자
	public Date regDttm;		 
	public String modId;
	public String modDttm;
}
