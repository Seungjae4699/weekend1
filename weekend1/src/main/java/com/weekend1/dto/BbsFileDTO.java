package com.weekend1.dto;

import java.util.Date;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BbsFileDTO {

	public int fileId;			// 파일 고유식별자
	public String fileOriginNm;	// 파일 원본이름
	public String fileNm;		// 저장되는 파일명
	public String filePath;		// 파일 경로
	public String useYn;		// 파일 삭제여부
	public String regId;		// 등록자
	public Date regDttm;		// 등록일자
	public String modId;		// 수정자
	public Date modDttm;		// 수정일자
}
