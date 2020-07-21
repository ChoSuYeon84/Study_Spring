<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>답글쓰기</h3>
<form action="reply_insert.qa" method="post" enctype='multipart/form-data' >
<input type="hidden" name='root' value="${vo.root }"/>
<input type="hidden" name='step' value="${vo.step }"/>
<input type="hidden" name='indent' value="${vo.indent }"/>
<table>
<tr><th class="w-px160">제목</th>
	<td><input type="text"  class="need" name="title"/></td>
</tr>
<tr><th>작성자</th>
	<td>${login_info.name }</td>
</tr>
<tr><th>내용</th>
	<td><textarea class="need" name="content"></textarea></td>
</tr>
<tr><th>파일첨부</th>
	<td class="left">
		<label>
		<input type="file" name="file" id="attach-file">
		<img src='img/select.png' class='file-img'/>
		</label>
		<span id='file-name'></span>
		<span id='delete-file' style="color: red; margin-left: 20px;"><i class="fas fa-times font-img"></i></span>
	</td>
</tr>
</table>
</form>
<div class="btnSet">
<a class="btn-fill" onclick="if( necessary() ) $('form').submit()">저장</a>
<a class="btn-empty" href='list.qa?curPage=${page.curPage }&search=${page.search}&keyword=${page.keyword}'>취소</a>
</div>
<script type="text/javascript" src="js/need_check.js?v=<%=new java.util.Date().getTime()%>"></script>
<script type="text/javascript" src="js/file_attach.js"></script>
</body>
</html>