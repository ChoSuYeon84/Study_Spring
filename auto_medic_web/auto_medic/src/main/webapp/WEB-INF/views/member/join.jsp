<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel = "stylesheet" type="text/css" href="css/common.css?v=<%= new Date().getTime()%>"> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
* {
margin: 0 auto; 
}

#logo, #join_us, h3 {
margin: 0 auto;
display: table;
}

table th {
float: left;
}

input {
height: 50px;
width: 500px;
color: #ccc;
}

.btn-fill-s{
display: block;
}

.btn-fill, .btn-fill-s{
height: 50px;
width: 500px;
background-color: #ccc;
text-align: center;
line-height: 50px;
}

img {
height: 215px;
width: 500px;
}

</style>
</head>
<body>
<a href="<c:url value='/'/>"><img src="img/logo_web.png" alt="홈으로" id="logo"></a>
<h3>회원가입</h3>
<form action="join" method="post">
<table>
<tr><th>아이디</th>
</tr>
<tr>
	<td><input class="chk" title='아이디' type="text" name="id"/><br/>
		<div class="valid">아이디를 입력하세요(영문소문자, 숫자만 입력 가능)</div>
	</td>
</tr>
<tr>
	<td><a class='btn-fill-s' id="id_chk">아이디중복확인</a></td>
</tr>
<tr><th>인증번호</th>
</tr>
<tr>
	<td><input type="text"/><br/>
		<div class="valid">아이디를 입력하세요(영문소문자, 숫자만 입력 가능)</div>
	</td>
</tr>
<tr><th>비밀번호</th>
</tr>
<tr>
	<td><input class="chk" title='비밀번호' type="password" name="pw"/><br/>
		<div class="valid">비밀번호를 입력하세요(영문대/소문자, 숫자를 모두 포함)</div>
	</td>
</tr>
<tr><th>비밀번호 재확인</th>
</tr>
<tr>
	<td><input class="chk" title='비밀번호확인' type="password" name="pw_ck"/><br/>
		<div class="valid">비밀번호를 다시 입력하세요</div>
	</td>
</tr>
<tr><th>닉네임</th>
</tr>
<tr>
	<td><input class="chk" title='닉네임' type="text" name="nickname"/><br/>
		<div class="valid">닉네임을 입력하세요</div>
		<a class='btn-fill-s' id="nickname_chk">닉네임중복확인</a>
	</td>
</tr>
<tr><th>연락처</th>
</tr>
<tr>
	<td><input type="text" name="tel"/><br/>
		<div class="valid">닉네임을 입력하세요</div>
	</td>
</tr>
</table>
</form>
<div class="btnSet">
<a class="btn-fill" onclick="go_join()" id="join_us">회원가입</a>
</div>
</body>
</html>