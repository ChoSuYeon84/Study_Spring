<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
h3{
	margin: 0 auto;
}
table{
	margin: 0 auto;
}
</style>
</head>
<body>
<h3>쪽지 연습화면</h3>
<form action="send">

	<%-- 보낸이:<input type='text' value="${login_info.member_email}"> <br/>
	받는이:<input type="text" name="receiver"><br/>
	메세지내용:<textarea rows="10" cols="10" name="message"></textarea><br/>
	<input type="submit" value="쪽지보내기">  --%>
	<input type="hidden" name="sender" value="${login_info.member_email}"/>
	 <table>
		<tr><th>보낸이</th><td>${login_info.member_email}</td></tr>
		<tr><th>받는이</th><td><input type="text" name="receiver"><br/></td></tr>
		<tr><th>메세지내용</th><td><textarea rows="10" cols="10" name="message"></textarea></td></tr>
		<tr><th><input type="submit" value="쪽지보내기"></th><td>취소</td></tr>
	</table> 
</form>
</body>
</html>