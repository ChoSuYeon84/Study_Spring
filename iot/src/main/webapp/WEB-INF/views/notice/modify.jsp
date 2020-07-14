<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>공지글 안내 수정</h3>
<form>
<table>
<tr><th class="w-px160">제목</th>
	<td><input type="text" name="title" value='${vo.title }'/></td>
</tr>
<tr><th>내용</th>
	<td><textarea name = "content">${vo.content }</textarea></td>
</tr>
<tr><th>첨부파일</th>
	<td></td>
</tr>
</table>
</form>
</body>
</html>