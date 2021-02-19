<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 리스트</title>

  <!-- Bootstrap / jQuery 라이브러리 등록 : CDN -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
.dataRow:hover {
	background: #ccc;
	cursor: pointer;
}
</style>

<script type="text/javascript">
$(function() {
	$(".dataRow").click(function(){
		// 글번호 찾기
		var no = $(this).find(".no").text();
		location = "view.do?no="+ no + "&inc=1"
			+ "&page=${pageObject.page}&"
			+ "perPageNum=${pageObject.perPageNum}"
			+ "&key=${pageObject.key}&"
			+ "&word=${pageObject.word}&";
	});
});
</script>

</head>
<body>
<div class="container">
<h1>게시판 리스트</h1>

<!-- 검색을 위한 입력 태그 시작 -->
 <div>
  <form class="navbar-form">
    <div class="input-group">
     <div class="form-group navbar-left">
      <select name="key" class="form-control">
       <!-- selected="select" or selected -->
       <option value="t" ${(pageObject.key == "t")? " selected ":"" }
        >제목</option>
       <option value="c" ${(pageObject.key == "c")? " selected ":"" }
       >내용</option>
       <option value="w" ${(pageObject.key == "w")? " selected ":"" }
       >작성자</option>
       <option value="tc" ${(pageObject.key == "tc")? " selected ":"" }
       >제목/내용</option>
       <option value="tw" ${(pageObject.key == "tw")? " selected ":"" }
       >제목/작성자</option>
       <option value="cw" ${(pageObject.key == "cw")? " selected ":"" }
       >내용/작성자</option>
       <option value="tcw" ${(pageObject.key == "tcw")? " selected ":"" }
       >전체</option>
      </select>
      <input type="text" class="form-control" placeholder="Search"
        name="word" value="${pageObject.word }">
      </div>
      <div class="input-group-btn">
        <button class="btn btn-default" type="submit">
          <i class="glyphicon glyphicon-search"></i>
        </button>
      </div>
    </div>
<!-- 검색을 위한 입력 태그 끝 -->

  </form>

 </div>



<table class="table">
<tr>
	<th>번호</th>
	<th>제목</th>
	<th>작성자</th>
	<th>작성일</th>
	<th>조회수</th>
</tr>
<c:if test="${empty list }">
	<!-- 만약에 데이터가 없으면 데이터 없음을 표시한다 -->
	<tr>
		<td colspan="5">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>
<c:if test="${!empty list }">
	<!-- 데이터가 존재하면 데이터의 갯수 만큼 반복되어 지는 부분 -->
	<c:forEach items="${list }" var="vo">
	<tr class="dataRow">
		<td class="no">${vo.rnum }</td>
		<td>${vo.title }</td>
		<td>${vo.writer }</td>
		<td>
			<fmt:formatDate value="${vo.writeDate }"
			 pattern="yyyy.MM.dd"/>
		</td>
		<td>${vo.hit }</td>
	</tr>
	</c:forEach>
</c:if>
  
<c:if test="${pageObject.totalPage > 1 }">
	<!-- 전체 페이지가 2페이지 이상이면 보여주는 부분 -->
	<tr>
		<td colspan="5">
			<pageNav:pageNav listURI="list.do" pageObject="${pageObject}" />
		</td>
	</tr>
</c:if>
<tr>
	<td colspan="5">
		<a href="write.do" class="btn btn-default">글쓰기</a>
	</td>
</tr>
</table>
</div>
</body>
</html>