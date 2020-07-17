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

<form method="post" action="list.no" id="list">
<input type="hidden" name="curPage" value="1"/>
<div id="list-top">
	<div>
	<ul>
		<li><select name="search" class="w-px80">
				<option value="all" ${page.search eq 'all' ? 'selected' : '' }>전체</option>
				<option value="title" ${page.search eq 'title' ? 'selected' : '' }>제목</option>
				<option value="content" ${page.search eq 'content' ? 'selected' : '' }>내용</option>
				<option value="writer" ${page.search eq 'writer' ? 'selected' : '' }>작성자</option>
			</select>
		</li>
		<li><input value="${page.keyword }" type="text" name="keyword" class="w-px300"/></li>
		<li><a class="btn-fill" onclick="$('form').submit()">검색</a></li>
	</ul>
	<ul>
	<c:if test="${login_info.admin eq 'y' }">
		<li><a class="btn-fill" href="new.no">글쓰기</a></li>
	</c:if>
	</ul>
	</div>
</div>
</form>

<table>
<tr><th class="w-px60">번호</th>
	<th>제목</th>
	<th class="w-px100">작성자</th>
	<th class="w-px120">작성일자</th>
	<th class="w-px60">첨부파일</th>
</tr>
<c:forEach items="${page.list }" var="vo">
<tr><td>${vo.no}</td>
	<td class='left'>
	<c:forEach var="i" begin="1" end="${vo.indent }">
	${i eq vo.indent ? "<img src='img/re.gif'/>" : '&nbsp;&nbsp;' }
	</c:forEach>
	<a title="${vo.content}" href='detail.no?id=${vo.id}&curPage=${page.curPage}'>${vo.title }</a></td>
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
<div class="btnSet">
	<jsp:include page="/WEB-INF/views/include/page.jsp"/>
</div>
</body>
</html>