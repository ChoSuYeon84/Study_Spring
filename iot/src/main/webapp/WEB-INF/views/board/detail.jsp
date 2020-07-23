<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
table td{ word-break : break-all}
</style>
</head>
<body>
<h3>방명록 상세</h3>
<table>
<tr><th class="w-px160">제목</th><td colspan="5" class="left">${vo.title }</td>
</tr>
<tr><th>작성자</th><td>${vo.name }</td>
	<th class="w-px100">작성일자</th><td class="w-px100">${vo.writedate }</td>
	<th class="w-px80">조회수</th><td class="w-px60">${vo.readcnt }</td>
</tr>
<tr><th>내용</th>
	<td colspan='5' class="left">${fn:replace(vo.content, crlf, '<br>') }</td>
</tr>
<tr><th>첨부파일</th>
	<td colspan="5" class="left"><c:if test="${!empty vo.filename }">
		${vo.filename }
		<a href="download.bo?id=${vo.id }"><i class="fas fa-download font-img"></i></a>
		</c:if>
	</td>
</tr>
</table>
<div class="btnSet">
<a class="btn-fill" onclick="go_list()">목록으로</a>
<c:if test="${login_info.admin eq 'y' or login_info.id eq vo.writer }"> <!-- 관리자나 작성자로 로그인한 경우만 수정/삭제 가능 -->
<a class="btn-fill" onclick="$('form').attr('action', 'modify.bo'); $('form').submit()">수정</a>
<a class="btn-fill">삭제</a>
</c:if>
</div>
<form method="post" action="list.bo">
<input type="hidden" name="id" value="${vo.id }"/>
<input type="hidden" name="curPage" value="${page.curPage }"/>
<input type="hidden" name="search" value="${page.search }"/>
<input type="hidden" name="keyword" value="${page.keyword }"/>
<input type="hidden" name="viewType" value="${page.viewType }"/>
<input type="hidden" name="pageList" value="${page.pageList }"/>
</form>
<script type="text/javascript">
function go_list(){
	$('form').submit();
}
</script>
</body>
</html>