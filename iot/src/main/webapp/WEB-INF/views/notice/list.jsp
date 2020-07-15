<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>공지사항</h3>

<div id="list-top">
	<div>
	<ul>
	<c:if test="${login_info.admin eq 'y' }">
		<li><a class="btn-fill" href="new.no">글쓰기</a></li>
	</c:if>
	</ul>
	</div>
</div>

<table>
<tr><th class="w-px60">번호</th>
	<th>제목</th>
	<th class="w-px100">작성자</th>
	<th class="w-px120">작성일자</th>
	<th class="w-px60">첨부파일</th>
</tr>
<c:forEach items="${page.list }" var="vo">
<tr><td>${vo.no}</td>
	<td class='left'><a title="${vo.content}" href='detail.no?id=${vo.id}'>${vo.title }</a></td>
	<td>${vo.name }</td>
	<td>${vo.writedate }</td>
	<td><c:if test="${! empty vo.filename }">
			<a href="download.no?id=${vo.id}">
				<img title="${vo.filename}" class="file-img" src="img/attach.png"/> 
			</a>
		</c:if>
	</td>	
	<%-- <td>${ empty vo.filename ? '' : '<img class="file-img" src="img/attach.png"/>' }</td> --%>
</tr>
</c:forEach>
</table>
</body>
</html>