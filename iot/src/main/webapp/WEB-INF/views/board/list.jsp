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
<h3>방명록 목록</h3>
<form>
<div id="list-top">
<div>
	<ul>
		<li>
		<select name="search" class="w-px80">
			<option ${page.search eq 'all' ? 'selected' : '' } value="all">전체</option>
			<option ${page.search eq 'title' ? 'selected' : '' } value="title">제목</option>
			<option ${page.search eq 'content' ? 'selected' : '' } value="content">내용</option>
			<option ${page.search eq 'writer' ? 'selected' : '' } value="writer">작성자</option>
		</select>
		</li>
		<li><input type="text" name="keyword" value="${page.keyword }" class="w-pw300"/>
		</li>
		<li><a class="btn-fill" onclick="$('form').submit()">검색</a>
		</li>
	</ul>
	<ul>
	<c:if test="${!empty login_info }"> <!-- 로그인 되어 있으면 글쓰기 가능 -->
		<li><a class="btn-fill" href="new.bo">글쓰기</a></li>
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
<tr><td>${vo.no }</td>
	<td class="left">${vo.title }</td>
	<td>${vo.name }</td>
	<td>${vo.writedate }</td>
	<td><c:if test="${!empty vo.filename }">
		<img src="img/attach.png" class="file-img"/>
		</c:if>
	</td>
</tr>
</c:forEach>

</table>

<div class="btnSet">
<jsp:include page="/WEB-INF/views/include/page.jsp"/>
</div>

</body>
</html>