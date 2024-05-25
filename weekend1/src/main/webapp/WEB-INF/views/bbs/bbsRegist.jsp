<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script>
//게시글 목록이동
function goList() {
	
	location.href='/BbsList';
}
//게시글 저장
function saveBoard() {

	if(writeForm.bbsSubject.value == "") {
		alert("제목이 입력되지 않았습니다");
		return;
	}

	if(writeForm.regIdSelect.value == "") {
		alert("등록자가 선택되지 않았습니다");
		return;
	}
	

    if (writeForm.bbsTypeSelect.value == "") {
        alert("구분이 선택되지 않았습니다");
        return;
    }
    
    var replyYnChecked = document.getElementById("replyYn").checked;
    var replyYn
	
    if(writeForm.bbsContents.value == "") {
		alert("내용이 입력되지 않았습니다");
		return;
	}

	save();
}
function save(){

	var form = document.getElementById("writeSubmit");
	
	if (confirm("제출하시겠습니까?")) {
		
		$.ajax({    
			type : 'post',            
			url : '/BbsWriteAc',     // 요청할 서버url    
			async : true,            // 비동기화 여부 (default : true)
			headers : {              // Http header  
				"Content-Type" : "application/json",   
				},
			dataType : 'json',       // 데이터 타입 (html, xml, json, text 등등)    
			data : JSON.stringify(
					{  // 보낼 데이터 (Object , String, Array)      
			"bbsSubject": writeForm.bbsSubject.value,
            "regId": writeForm.regId.value,
            "bbsType": writeForm.bbsType.value,
            "replyYn": document.getElementById("replyYn").checked ? "N" : "Y",
            "bbsContents": writeForm.bbsContents.value
					}),
			// 기능 성공시 페이지 이동하기전 등록이 완료되었다는 알림을 띄우고 /boardList로 페이지 이동
			success : function(result) { // 결과 성공 콜백함수      
				if(result){
					alert("등록이 완료되었습니다.");
					window.location.href = "/BbsList";
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
	<h2>게시글 작성</h2>
	<form name="writeForm" id="writeSubmit" action="/BbsWriteAc" method="post">
		<table border="1" align="center">	
			<tr>
				<td>제목</td>
				<td><input type="text" name="bbsSubject" maxlength='200'></td>
			</tr>	
			<tr>
				<td>등록자</td>
				<td>
					<select id ="regId" name="regIdSelect">
						<option value="">선택</option>
						<c:forEach var="bm" items="${bbsMember }">
							<option value="${bm.memberId }">${bm.memberName}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td>구분</td>
				<td>
					<c:forEach var="bc" items="${bbsCode }">
						<input type="radio" id="bbsType" name="bbsTypeSelect" value="${bc.code}">
		           		<label for="bbsType">${bc.codeName}</label>			
					</c:forEach>						
				</td>
			</tr>
			<tr>
				<td>댓글 허용여부</td>
				<td><input type="checkbox" id="replyYn" name="replyYn">허용하지 않음</td> <!-- 기본 value값 on -->
			</tr>
			<tr>
				<td>글내용</td>
				<td><textarea cols="100" rows="20" name="bbsContents"></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
				<input type="button" value="저장" onclick="saveBoard();">
				<input type="button" value="목록" onclick="goList();">	
			</tr>
		</table>
	</form>
	</div>
</body>
</html>