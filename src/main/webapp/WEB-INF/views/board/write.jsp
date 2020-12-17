<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글쓰기</title>

<!-- Bootstrap / jQuery 라이브러리 등록 : CDN -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
.dataRow:hover {
	background: #ccc;
	cursor: pointer;
}
</style>

<script type="text/javascript">
	$(function() {
		$(".cancelBtn").click(function() {
			history.back();
		});
	});
</script>

</head>
<body>
	<div class="container">
		<h1>게시판 글쓰기</h1>

		<!-- 검색을 위한 입력 태그 시작 -->
		<div>
			<form class="navbar-form">
				<div class="input-group">
					<div class="form-group navbar-left">
						<select name="key" class="form-control">
							<!-- selected="select" or selected -->
							<option value="t" ${(pageObject.key == "t")? " selected ":"" }>제목</option>
							<option value="c" ${(pageObject.key == "c")? " selected ":"" }>내용</option>
							<option value="w" ${(pageObject.key == "w")? " selected ":"" }>작성자</option>
							<option value="tc" ${(pageObject.key == "tc")? " selected ":"" }>제목/내용</option>
							<option value="tw" ${(pageObject.key == "tw")? " selected ":"" }>제목/작성자</option>
							<option value="cw" ${(pageObject.key == "cw")? " selected ":"" }>내용/작성자</option>
							<option value="tcw"
								${(pageObject.key == "tcw")? " selected ":"" }>전체</option>
						</select> <input type="text" class="form-control" placeholder="Search"
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
		<form method="post" action="write.do" class="form-group">
			<table class="table">
				<tr>
					<th>제목</th>
					<td><input class="form-control" name="title"></td>
				<tr>							
					<th>내용</th>
					<td><textarea class="form-control" name="content"></textarea></td>
				</tr>
					<th>작성자</th>
					<td><input class="form-control" name="writer"></td>
				</tr>	
				</tr>
					<th>비밀번호</th>
					<td><input class="form-control" name="pw"></td>
				</tr>							
				<tr>
					<td colspan="2">
						<button>등록</button>
						<button type="reset">새로입력</button>
						<button type="button" class="cancelBtn">취소</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>