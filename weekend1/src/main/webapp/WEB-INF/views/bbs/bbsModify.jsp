<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
//게시글 목록이동
function goList() {
	
	alert('목록으로 이동합니다');
	location.href='/BbsList';
}
//게시글 수정
	function modifyBoard(data) {

	if(modifyForm.bbsSubject.value == "") {
		alert("제목이 입력되지 않았습니다");
		return;
	}

	if(modifyForm.modIdSelect.value == ""){
    	alert("수정자가 선택되지 않았습니다")
    	return;
	}
	var bbsType1Checked = document.getElementById("bbsType1").checked;
    var bbsType2Checked = document.getElementById("bbsType2").checked;
    if (!bbsType1Checked && !bbsType2Checked) {
        alert("구분이 선택되지 않았습니다");
        return;
    }
	   
    var replyYnChecked = document.getElementById("replyYn").checked;
    if (data != '0') {
    	alert("이미 등록된 댓글이 있어 댓글허용여부를 변경하실수 없습니다.")
    	return;
    }
    
	if(modifyForm.bbsContents.value == "") {
		alert("내용이 입력되지 않았습니다");
		return;
	}

	modify();
}

	function modify(data) {
		var form = document.getElementById("modifySubmit");
		//저장 버튼 누르면 페이지 이동전 예 아니오가 담긴 confirm창을 띄우게 됨
		if(confirm("수정하시겠습니까?")) {
			// ajax 호출하여 데이터 전송 타입, 실행 url, 비동기 통신여부, 데이터타입, 부가적정보(요청,컨텐츠 타입, 캐시등), 데이터타입,
			$.ajax({    
				type : 'post',           // 타입 (get, post, put 등등)    
				url : '/modifyAc',           // 요청할 서버url    
				async : true,            // 비동기화 여부 (default : true)
				headers : {              // Http header  
					"Content-Type" : "application/json",   
					},
				dataType : 'text',       // 데이터 타입 (html, xml, json, text 등등)    
				data : JSON.stringify(
						{  // 보낼 데이터 (Object , String, Array)
					"bbsId" : modifyForm.bbsId.value,
					"bbsSubject": modifyForm.bbsSubject.value,
		            "modId": modifyForm.modId.value,
		            "bbsType": modifyForm.bbsTypeSelect.value,
		            "replyYn": document.getElementById("replyYn").checked ? "N" : "Y",
		            "bbsContents": modifyForm.bbsContents.value }
				),
				// 기능 성공시 페이지 이동하기전 수정이 완료되었다는 알림을 띄우고 /boardList로 페이지 이동
				success : function(result) { // 결과 성공 콜백함수      
					if(result == 'true'){
						alert("수정이 완료되었습니다.");
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
	<h2>게시글 수정</h2>
	<form name="modifyForm" id="modifySubmit" action="/modifyAc" method="post">
		<table border="1" align="center">	
			<tr>
				<td>제목</td>
				<td><input type="text" name="bbsSubject" value="${dtData.bbsSubject }"></td>
			</tr>	
			<tr>
				<td>수정자</td>
				<td>
					<select id ="modId" name="modIdSelect">
						<option value="">선택</option>	
						<option value="jmg">조문규</option>
						<option value="lhs">이형술</option>
						<option value="chw">최승우</option>
						<option value="hsj">허승재</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>구분</td>
				<td>
				<!--<c:forEach var="bc" items="${bbsCode }">
					<input type="radio" id="bbsType" name="bbsTypeSelect" value="${bc.code}"
					<c:if test="${dtData.bbsType == '01'}">checked="checked"</c:if>
					<c:if test="${dtData.bbsType == '02'}">checked="checked"</c:if>>					
					<label for="bbsType">${bc.codeName}</label>	
				</c:forEach>-->
				<input type="radio" id="bbsType1" name="bbsTypeSelect" value="01"<c:if test="${dtData.bbsType == '01'}">checked="checked"</c:if>>
				<label for="bbsType1">공지</label>
				<input type="radio" id="bbsType2" name="bbsTypeSelect" value="02"<c:if test="${dtData.bbsType == '02'}">checked="checked"</c:if>>
				<label for="bbsType1">일반</label>
				</td>				
			</tr>
			<tr>
				<td>댓글 허용여부</td>
				<td><input type="checkbox" id="replyYn" name="replyYn"<c:if test="${dtData.replyYn == 'N'}">checked="checked"</c:if>>허용하지 않음</td>
			</tr>
			<tr>
				<td>글내용</td>
				<td><textarea cols="100" rows="20" name="bbsContents">${dtData.bbsContents }</textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
				<input type="hidden" name="bbsId" value="${dtData.bbsId }">
				<input type="button" value="저장" onclick="modifyBoard(${dtData.replyCnt});">
				<input type="button" value="목록" onclick="goList();">	
			</tr>
		</table>
	</form>
	</div>
</body>
</html>