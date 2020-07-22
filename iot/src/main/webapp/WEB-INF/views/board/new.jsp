<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>방명록 글쓰기</h3>
<form action="insert.bo" method="post">
<table>
<tr><th class="w-px160">제목</th>
	<td><input title="제목" type="text" name="title" class="need"></td>
</tr>
<tr><th>작성자</th>
	<td>${login_info.name }</td>
</tr>
<tr><th>내용</th>
	<td><textarea title="내용" name="content" class="need"></textarea> </td>
</tr>
<tr><th>첨부파일</th>
	<td class="left">
		<label>
		<input type="file" name="file" id="attach-file"/>
		<img src="img/select.png" class="file-img"/>
		</label>
		<span id="file-name"></span>
		<span id="delete-file" style="color:red; margin-left: 15px">
			<i class='fas fa-times font-img' ></i>
		</span>
	</td>
</tr>
</table>
</form>
<div class="btnSet">
<a class="btn-fill" onclick="if( necessary() ){ $('form').submit() }">저장</a>
<a class="btn-empty" href="list.bo">취소</a>
</div>
<script type="text/javascript" src="js/file_attach.js"></script>
<script type="text/javascript" src="js/need_check.js?v=<%=new java.util.Date().getTime()%>"></script>
</body>
</html>