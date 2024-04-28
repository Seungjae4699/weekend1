package com.weekend1.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BbsPageDTO {

	public String tempPage;		// 페이시 개수
	public String startPage;	// 시작 페이지
	public String endPage;		// 마지막 페이지
	public String totalPages;	// 총 페이지
	public String totalRows;	// 총 데이터 개수
}
