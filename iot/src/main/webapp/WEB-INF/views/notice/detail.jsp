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
<h3>공지글 안내</h3>
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
		<a href='download.no?id=${vo.id }' style='margin-left:15px'><i class="fas fa-download"></i></a>
	</c:if>
	</td>
</tr>
</table>
<div class="btnSet">
<a class="btn-fill" href="list.no">목록으로</a>
<c:if test="${login_info.admin eq 'y' }">
<a class="btn-fill" href="modify.no?id=${vo.id }">수정</a>
<a class="btn-fill" onclick='if(confirm("정말 삭제?")) {href="delete.no?id=${vo.id }"}'>삭제</a>
</c:if>
</div>
</body>
</html>