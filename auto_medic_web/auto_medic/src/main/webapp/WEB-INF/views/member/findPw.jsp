<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel = "stylesheet" type="text/css" href="css/common.css?v=<%= new Date().getTime()%>"> 
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<style type="text/css">
fieldset {
	width: 500px;
	height: 250px;
	margin: 0 auto;
}

input {
	height: 50px;
	width: 500px;
	color: black;
	font-size: 20px;
}


.btnfp{
	text-align: center;
	padding: 5px 12px;
	border: 1px solid black;
	border-radius: 3px;
	text-decoration: none !important;
	margin-left: 215px;
}
</style>
<script type="text/javascript">
function send_pw(){
	$('form').submit();
}
</script>
</head>
<body>
<a href="/automedic"><img src="img/logo1.PNG" style="width:25px; height: 25px;float: left;"></a>
<h3>&nbsp;비밀번호 찾기</h3>
<hr/>
<br/>
<form action="send_pw" method="post"> 
<fieldset> 
<legend>비밀번호 찾기</legend> 	
<p>비밀번호를 찾고자 하는 아이디를 입력해 주세요.</p><br/> 
	<label><input type="text" name="userMail"></label><br/><br/><br/>
<a class=btnfp onclick="send_pw()">제출</a>
</fieldset> 
</form>
</body>
</html>