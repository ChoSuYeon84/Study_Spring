<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
</body>
</html>