package com.weekend1.dto;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BbsSearchDTO {

	public String searchWord;	// 검색어
	public String bbsType;		// 게시글 형태
	public String searchType;	// 검색형태
	public String page;		 	// 현재페이지
	public Integer pageLength;	// 페이지 길이값 => 한 페이지에 표시되는 게시글 개수
	public String subject;
	public String contents;
}
