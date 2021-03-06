<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>질문글 작성</h3>
<table>
<tr><th class='w-px160'>제목</th>
	<td colspan="5" class="left">${vo.title }</td>
</tr>
<tr><th class="w-px120">작성자</th>
	<td>${vo.name }</td>
	<th class="w-px120">작성일자</th>
	<td>${vo.writedate }</td>
	<th class="w-px80">조회수</th>
	<td>${vo.readcnt }</td>
</tr>
<tr><th>내용</th>
	<td colspan="5" class="left">${fn:replace(vo.content, crlf, '<br>') }</td> <!-- 글 내용의 엔터를 <br>태그로 처리 -->
</tr>
<tr><th>첨부파일</th>
	<td colspan="5" class="left">${vo.filename }
	<c:if test="${ !empty vo.filename }">
		<a href='download.qa?id=${vo.id }' style='margin-left:15px'><i class="fas fa-download"></i></a>
	</c:if>
	</td>
</tr>
</table>
<div class="btnSet">
<a class="btn-fill" href="list.qa?curPage=${page.curPage }&search=${page.search}&keyword=${page.keyword}">목록으로</a>
<!-- 관리자인 경우 수정/삭제 가능 -->
<c:if test="${login_info.admin eq 'y' }">
<a class="btn-fill" href="modify.qa?id=${vo.id }">수정</a>
<a class="btn-fill" onclick='if(confirm("정말 삭제?")) {href="delete.qa?id=${vo.id }"}'>삭제</a>
</c:if>
<!-- 로그인이 된 경우 답글쓰기 가능 -->
<c:if test="${!empty login_info }">
<a class='btn-fill' href='reply.qa?id=${vo.id }'>답글쓰기</a>
</c:if>
</div>
</body>
</html>