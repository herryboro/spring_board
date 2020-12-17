<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글보기</title>

  <!-- Bootstrap / jQuery 라이브러리 등록 : CDN -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
$(function(){
	$("#deleteBtn").click(function(){
		var pw = prompt("비밀번호 입력 :");
// 		alert(pw);
		if(pw.length >= 4){
			$("#deletePw").val(pw);
// 			alert($("#deletePw").val());
			$("#deleteForm").submit();
			return;
		}
		alert("비밀번호는 4자 이상 50자 이내로 입력하셔야 합니다.");
		// 화면 이동을 막는다.
		return false;
	});
});
</script>

</head>
<body>
<div class="container">
<h1>게시판 글보기</h1>
<table class="table">
<tr>
	<th>번호</th>
	<td>${vo.no }</td>
</tr>
<tr>
	<th>제목</th>
	<td>${vo.title }</td>
</tr>
<tr>
	<th>내용</th>
	<td><pre style="border: none;">${vo.content }</pre></td>
</tr>
<tr>
	<th>작성자</th>
	<td>${vo.writer }</td>
</tr>
<tr>
	<th>작성일</th>
	<td>
		<fmt:formatDate value="${vo.writeDate }"
		 pattern="yyyy.MM.dd"/>
	</td>
</tr>
<tr>
	<th>조회수</th>
	<td>${vo.hit}</td>
</tr>
<tr>
	<td colspan="2">
		<a href="update.do?no=${vo.no }" class="btn btn-defualt">수정</a>
		<a href="#" class="btn btn-defualt" id="deleteBtn">삭제</a>
		<a href="list.do" class="btn btn-defualt">리스트</a>
	</td>
</tr>
</table>
</div>
<!-- 삭제를 위한 form tag : 보이지 않는다.-->
<form action="delete.do" method="post" id="deleteForm">
	<input type="hidden" name="no" value="${vo.no }" />
	<input type="hidden" name="pw" id="deletePw"/>
</form>

</body>
</html>