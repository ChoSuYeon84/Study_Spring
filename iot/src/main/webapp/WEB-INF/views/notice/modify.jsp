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
<form action='update.no' method="post" enctype='multipart/form-data' >
<input type='hidden' name='id' value='${vo.id }' />
<input type='hidden' name='attach' /> <!-- 첨부파일관련해서 필요한 태그 (첨부파일이 삭제된건지 새로 첨부된건지 그냥 원래껄 그냥 쓰는지 확인하기 위해) -->
<table>
<tr><th class="w-px160">제목</th>
	<td><input class='need' type="text" name="title" value='${vo.title }'/></td>
</tr>
<tr><th>내용</th>
	<td><textarea class='need' name = "content">${vo.content }</textarea></td>
</tr>
<tr><th>첨부파일</th>
	<td class="left">
		<label><input id='attach-file' type='file' name='file'/>
			<img src='img/select.png' class='file-img'/>
		</label>
		<span id='file-name'>${vo.filename }</span>
		<span id='delete-file' style="display:${empty vo.filename ? 'none' : 'inline'}; color: red; margin-left: 20px;"><i class="fas fa-times font-img"></i></span>
	</td>
</tr>
</table>
</form>
<div class='btnSet'>
<a class='btn-fill' onclick='if( necessary() ){$("[name=attach]").val($("#file-name").text()); $("form").submit() }'>저장</a>	<!-- 하단 스크립트 부분에 js/need_check.js 를 넣어야 함수 사용가능 -->
<a class='btn-empty' href='detail.no?id=${vo.id }'>취소</a>
</div>
<script type="text/javascript" src='js/file_attach.js?v=<%=new java.util.Date().getTime()%>'></script>
<script type="text/javascript" src='js/need_check.js'></script>
</body>
</html>