<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 리스트</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript">
// 글쓰기 이동
	function goWrite() {
		location.href='/BbsWrite';
		
}
// 상세페이지 이동
	function goDetail(data) {
		location.href='/BbsDetail?bbsId='+data;
}


// 검색 기능
	function goSearch() {
		
		var form = document.getElementById("search");
		
		var bbsType1Checked = document.getElementById("bbsType1").checked;
		var bbsType1CheckedValue = document.getElementById("bbsType1").value;
		var bbsType2Checked = document.getElementById("bbsType2").checked;
		var bbsType2CheckedValue = document.getElementById("bbsType2").value;
		
		var searchType1Checked = document.getElementById("searchType1").checked;
		var searchType2Checked = document.getElementById("searchType2").checked;
		

		if (!searchType1Checked && !searchType2Checked) {
	        alert("제목 또는 내용 중 하나를 선택해야 합니다.");
	      	return;
	    }
		
		form.submit();
}		

//페이징기능
	// 페이지 블록 눌렀을때 페이지 이동하는 기능을 구현 goPage()에 담긴 데이터 전부 가져옴
	function goPage(data) {
		// id가 search라는 태그의 요소를 가져와서 form 변수에 담아줌 
		var form = document.getElementById("search");
		// html 속성에 id가 page인 태그에서 가져온 데어터 값으로 페이지 번호 지정
		document.getElementById("page").value = data;
		// form에 저장된 정보 submit
		form.submit();
	}

</script>
</head>
<body>

<!-- <nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Navbar</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="#">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Features</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Pricing</a>
        </li>
      </ul>
    </div>
  </div>
</nav>  -->

	<div align = "center">
	<h2>게시글 리스트</h2>
		<form name="searchForm" action="/BbsList" method="post" id="search">			
			<div>
				구분
				<input type="radio" id="bbsType1" name="bbsType" value="notice"<c:if test="${shList.bbsType == 'notice'}" >checked</c:if> />
				<label for="bbsType1">공지</label>
				<input type="radio" id="bbsType2" name="bbsType" value="ordinary"<c:if test="${shList.bbsType == 'ordinary'}" >checked</c:if> />
				<label for="bbsType2">일반</label>
			</div>
			<div>
				검색어
				<input type="checkbox" id="searchType1" name="searchType" value="subject"
				<c:if test="${shList.searchType == 'subject'}">checked</c:if>
				<c:if test="${shList.searchType == 'subject,contents' }">checked</c:if>/>
				<label for="searchType1">제목</label>				
				<input type="checkbox" id="searchType2" name="searchType" value="contents"
				<c:if test="${shList.searchType == 'contents'}">checked</c:if> 
				<c:if test="${shList.searchType == 'subject,contents' }">checked</c:if>/>
				<label for="searchType2">내용</label>		
				<input type="text" id="searchWord" name="searchWord" value="${shList.searchWord }" placeholder="검색내용" maxlength='50'>
			  	<button type="button" onclick="goSearch()" >검색</button>
			  	<input type="hidden" name="pageLength" value="10">
				<input type="hidden" id="page" name="page" value="">
			</div>			
			
		</form>
		
	</div>
	
	<div align = "right" >
		 	
		<input type="button" value="글쓰기" onclick="goWrite()">
	</div>
	
	<div id="boardList">
		<table border="1" width="100%">
			<tr>
				<th>No</th>
				<th>구분</th>
				<th>제목</th>
				<th>조회수</th>
				<th>등록자</th>
				<th>등록일</th>
			</tr>
			<c:forEach var="bl" items="${bsList}">
			<tr>
				<td>${bl.rowNum }</td>
				<td>${bl.codeName }</td>
				<td><a href="javascript:void(0);" onclick="goDetail('${bl.bbsId }')">${bl.bbsSubject }[${bl.replyCnt }]</a></td>
				<td>${bl.hitCnt }</td>
				<td>${bl.memberName }</td>
				<td><fmt:formatDate value="${bl.regDttm}" pattern="yyyy-MM-dd"/></td>
			</tr>
			</c:forEach>
		</table>
	</div>
	
	<div align="center">
		<nav>
			<ul>
				<c:choose>
					<c:when test="${shList.page == 1  }">
						<li><a href="#" tabindex="-1" aria-disabled="true">&lt;&lt;</a></li>
					</c:when>
					<c:otherwise>
						<li><a onclick="goPage(1)" tabindex="-1">&lt;&lt;</a></li>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${shList.page == 1  }">
						<li><a href="#" tabindex="-1" aria-disabled="true">&lt;</a></li>
					</c:when>
					<c:otherwise>
						<li><a onclick="goPage(${shList.page - 1})" tabindex="-1">&lt;</a></li>
					</c:otherwise>
				</c:choose>
				
				<c:forEach var="num" begin="${pgList.startPage}" step="1" end="${pgList.endPage}">
					<li class="page-item">
						<a class="page-link" onclick="goPage(${num})">${num}</a>
					</li>
				</c:forEach>
				
				<c:choose>
					<c:when test="${shList.page == pgList.totalPages }">
						<li><a href="#" tabindex="-1" aria-disabled="true">&gt;</a></li>
					</c:when>
					<c:otherwise>
						<li><a onclick="goPage(${shList.page + 1})">&gt;</a></li>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${shList.page == pgList.totalPages }">
						<li><a href="#" tabindex="-1" aria-disabled="true">&gt;&gt;</a></li>
					</c:when>
					<c:otherwise>
						<li><a onclick="goPage(${pgList.totalPages})">&gt;&gt;</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</nav>
	</div>
	
	<!-- 자바스크립트 추가 -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct"
        crossorigin="anonymous"></script>
</body>
</html>