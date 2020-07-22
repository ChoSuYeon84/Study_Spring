<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
table { table-layout:fixed; }
table td { overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
</style>
</head>
<body>
<h3>방명록 목록</h3>
<form id="list" method="post" action="list.bo">
<input type="hidden" name="curPage" value="1"/>
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
	<li>
		<select name="pageList" class="w-px80" onchange="$('[name=curPage]').val(1); $('form').submit()">
			<option ${page.pageList eq 10 ? 'selected' : '' } value="10">10개씩</option>
			<option ${page.pageList eq 20 ? 'selected' : '' } value="20">20개씩</option>
			<option ${page.pageList eq 30 ? 'selected' : '' } value="30">30개씩</option>
		</select>	
	</li>
	<li>
		<select name="viewType" class="w-px100" onchange="$('form').submit()">
			<option ${page.viewType eq 'list' ? 'selected' : '' } value="list">리스트형태</option>
			<option ${page.viewType eq 'grid' ? 'selected' : '' } value="grid">바둑판형태</option>
		</select>
	</li>
	<c:if test="${!empty login_info }"> <!-- 로그인 되어 있으면 글쓰기 가능 -->
		<li><a class="btn-fill" href="new.bo">글쓰기</a></li>
	</c:if>
	</ul>
</div>
</div>
</form>
<div id="data-list">
<c:if test="${page.viewType eq 'list' }">
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
</c:if>

<c:if test="${page.viewType eq 'grid' }">
<ul class='grid'>
	<c:forEach items="${page.list }" var="vo">
	<li><div>${vo.title }</div>
		<div>${vo.name }</div>
		<div>${vo.writedate }</div>
	</li>
	</c:forEach>
</ul>
</c:if>

</div>
<div class="btnSet">
<jsp:include page="/WEB-INF/views/include/page.jsp"/>
</div>
<script type="text/javascript">
$(function(){
	$('#data-list ul').css('height', 
		( $('.grid li').length < 5 ? 1 : $('.grid li').length/5 )	
		* $('.grid li').outerHeight(true) - 20);
});
</script>
</body>
</html>