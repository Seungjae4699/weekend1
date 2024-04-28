<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
//목록으로 이동
	function goList() {
	// 목록 이동하기전 alert창을 띄움
	alert('목록으로 이동합니다');
	// 목록 버튼 눌렀을때 /BbsList로 페이지 이동
	location.href='/BbsList';
}
//게시글 수정화면 이동
	function goModify(data){
	alert('수정화면으로 이동합니다');
	location.href='/Bbsmodify?bbsId='+data;
}

//게시글 삭제기능
	function goDelete(data) {
		// 삭제 눌렀을때 삭제하시겠습니까? 라는 예 아니오 있는 confirm창 띄움
	    if(confirm("삭제하시겠습니까?")) {
	        // ajax 호출하여 데이터 전송 타입, 실행 url, 비동기 통신여부, 데이터타입, 부가적정보(요청,컨텐츠 타입, 캐시등), 데이터타입, 
	    	$.ajax({
	            type: 'post',
	            url: '/deleteAc',
	            async : true,
	            dataType : 'text',
	            headers : {              // Http header  
					"Content-Type" : "application/json",   
					},
				dataType : 'text',
	            data : JSON.stringify(
					  {"bbsId" : data }	// 전송해줄 데이터 : (bbsId)를 보내줌으로써 해당하는 게시글 삭제 
				),
				// 기능 성공시 페이지 이동하기전 삭제되었다는 알림을 띄우고 /boardList로 페이지 이동
	            success: function(result) {
            	if(result == 'true'){
	            	alert("게시물이 삭제되었습니다.");
	                location.href='/BbsList'; 
	            }
            		//기능이 실행되지 않았을때 실패했을때 alert로 실패여부 띄움
            		else {
						alert("실패했습니다.");  
					}
				},
				
				// 비동기처리 방식에 문제 생겼을 때 alert 호출하여 알림을 띄워준다
				error : function(request, status, error) { // 결과 에러 콜백함수        
				alert("실패했습니다.");
				}
	        });
	    }
	}
	
//댓글 추가기능
	function registReply(data) {
	 
		var form = document.getElementById("reply");		
		
		if(replyForm.regIdSelect.value == "") {
			alert("등록자를 선택해주세요");
			return;
		}   
		
		if(replyForm.replyContents.value == "") {
			alert("댓글내용을 입력해주세요");
			return;
		}   
		
		// ajax 호출하여 데이터 전송 타입, 실행 url, 비동기 통신여부, 데이터타입, 부가적정보(요청,컨텐츠 타입, 캐시등), 데이터타입, 
	    	$.ajax({
	            type: 'post',
	            url: '/writeReply',
	            async : true,
	            dataType : 'text',
	            headers : {              // Http header  
					"Content-Type" : "application/json",   
					},
				dataType : 'text',
	            data : JSON.stringify({
	            	  "bbsId" : data, 	
	            	  "regId" : replyForm.regIdSelect.value, 
	            	  "replyContents" : replyForm.replyContents.value }),
	            success: function(result) {
            	if(result == 'true'){
	            	alert("댓글이 등록되었습니다.");
	            	location.reload();
	            }
            		//기능이 실행되지 않았을때 실패했을때 alert로 실패여부 띄움
            		else {
						alert("실패했습니다.");  
					}
				},
				
				// 비동기처리 방식에 문제 생겼을 때 alert 호출하여 알림을 띄워준다
				error : function(request, status, error) { // 결과 에러 콜백함수        
				alert("실패했습니다.");
				}
	        });
	    
			
}

//댓글 삭제기능
	function deleteReply(data) {
		// 삭제 눌렀을때 삭제하시겠습니까? 라는 예 아니오 있는 confirm창 띄움
	    if(confirm("댓글을 삭제하시겠습니까?")) {
	        // ajax 호출하여 데이터 전송 타입, 실행 url, 비동기 통신여부, 데이터타입, 부가적정보(요청,컨텐츠 타입, 캐시등), 데이터타입, 
	    	$.ajax({
	            type: 'post',
	            url: '/deleteReply',
	            async : true,
	            dataType : 'text',
	            headers : {              // Http header  
					"Content-Type" : "application/json",   
					},
				dataType : 'text',
	            data : JSON.stringify(
					  {"replyId" : data }	// 전송해줄 데이터 : (replyId)를 보내줌으로써 해당하는 게시글 삭제 
				),
				
	            success: function(result) {
            	if(result == 'true'){
	            	alert("댓글이 삭제되었습니다.");

	            	$("#num_" + data).remove();
	            }
            		//기능이 실행되지 않았을때 실패했을때 alert로 실패여부 띄움
            		else {
						alert("실패했습니다."); 
					
					}
				},
				
				// 비동기처리 방식에 문제 생겼을 때 alert 호출하여 알림을 띄워준다
				error : function(request, status, error) { // 결과 에러 콜백함수        
				alert("실패했습니다.");
				}
	        });
	    }
	}

</script>
</head>
<body>
	<div align="center">
	<h3>게시판 상세페이지</h3>
		<table border="1">
			<tr>
				<th>제목</th>
				<td colspan="4">${bdDetail.bbsSubject}</td>
			</tr>
			<tr>
				<th>구분</th>
				<td>${bdDetail.codeName}</td>
				<th>조회수</th>
				<td>${bdDetail.hitCnt}</td>
			</tr>
			<tr>
				<th>등록자</th>
				<td>${bdDetail.memberName}</td>
				<th>등록일</th>
				<td><fmt:formatDate value="${bdDetail.regDttm}" pattern="yyyy-MM-dd"/></td>
			</tr>
			<tr>
				<th>글내용</th>
				<td colspan="4">${bdDetail.bbsContents }</td> 
			</tr>
			<tr>
				<td colspan="4" align="right">
				<input type="button" value="목록" onclick="goList();">
				<input type="button" value="수정" onclick="goModify('${bdDetail.bbsId}')">
				<input type="button" value="삭제" onclick="goDelete('${bdDetail.bbsId}')">
				</td>
			</tr>
		</table>
	</div>
	<c:choose>
		<c:when test="${bdDetail.replyYn == 'N'}">
			<td></td>
		</c:when>
		<c:otherwise>
			<div align="center">
				<table border="1">
					<tr>
						<th colspan="4" align="left">댓글</th>
					</tr>
					<tr>
						<th>등록자</th>
						<td>
						<form name="replyForm" id="reply" action="/writeReply" method="post">
							<select id="regId" name="regIdSelect">
								<option value="">선택</option>	
								<option value="jmg">조문규</option>
								<option value="lhs">이형술</option>
								<option value="chw">최승우</option>
								<option value="hsj">허승재</option>
							</select>
							</td>						
							<td><input type="text" id="replyContents" name="replyContents" placeholder="댓글내용 입력" maxlength='50'></td>
							<td><input type="button" onclick="registReply('${bdDetail.bbsId}')" value="등록"></td>
						</form>
					</tr>
					<c:choose>
						<c:when test="${bdDetail.replyCnt == 0 }">
							<td colspan="4" align="center">등록된 댓글이 없습니다.</td>
						</c:when>
						<c:otherwise>
						<c:forEach var="rl" items="${rpList}">
								<tr id="num_${rl.replyId}" class="reply">							
									<th>${rl.memberName }</th>
									<td colspan="2">${rl.replyContents}</td>
									<td><input type="button" onclick="deleteReply('${rl.replyId}');" value="삭제"></td>
								</tr>	
						</c:forEach>					
						</c:otherwise>
					</c:choose>		
				</table>
			</div>
		</c:otherwise>
	</c:choose>
</body>
</html>