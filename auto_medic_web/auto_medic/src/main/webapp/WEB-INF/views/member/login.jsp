<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AutoMedic : 로그인</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src = "//developers.kakao.com/sdk/js/kakao.min.js"></script>
<link rel = "stylesheet" type="text/css" href="css/common.css?v=<%= new Date().getTime()%>"> 
<link rel="icon" type="image/x-icon" href="img/logo1.ico">
<script type="text/javascript">
Kakao.init('1e375a8b8197c43949c6be5c803e61ba')
function loginWithKakao() {
Kakao.Auth.login({
		success : function(authObj) {
			Kakao.API.request({
				url : '/v2/user/me',
				success : function(res) {
					console.log(res.kakao_account.email);
					console.log(res.properties.nickname);
					var kakao_mail = res.kakao_account.email;
					var kakao_nickname = res.properties.nickname;

					$.ajax({
						type : 'post',
						url : 'kakaoLogin',
						dataType : "json",
						data : {
							kakao_email : kakao_mail,
							kakao_nickname : kakao_nickname
						},
						success : function(data) {
							console.log("성공");
							if (data) {
								location.href = "/automedic";
							} else {
								alert('sns로그인에 실패하였습니다');
							}
						},
						error : function() {
							console.log("실패");
						}
					});
				},
				fail : function(error) {
					alert(JSON.stringify(error));
				}
			});
		},
		fail : function(err) {
			console.log(JSON.stringify(err))
		},
	})
}
</script>
<script>
 //오토메딕 앱 로그인
 function go_login(){
 		if($('#userid').val()==''){
 		alert('아이디를 입력하세요!');
 		$('#userid').focus();
 		return;
 	} else if($('#userpw').val()==''){
 		alert('비밀번호를 입력하세요!');
 		$('#userpw').focus();
 		return;
 	}

 	$.ajax({
 		type: 'post',
 		url: 'login',
 		data: { id: $('#userid').val(), pw:$('#userpw').val()},
 		success: function(data){
 			//alert(data);
 			if (data == 'true'){
 				location.href = "/automedic";
 			}else {
 				alert('아이디나 비밀번호가 일치하지 않습니다!');
 				$('#userid').focus();
 			}
 			
 		},error : function(req, text){
 			alert(text+' : '+req.status)
 		} 
 	});
 }
 </script>
<style type="text/css">
* {
	margin: 0 auto; 

}

#custom-login-btn, #btn_Nlogin{
	margin: 0 auto;
	display: table;
}

#logo, #login, h3 {
	margin: 0 auto;
	display: table;
}

table th {
float: left;
}

input {
	height: 50px;
	width: 500px;
	color: black;
	font-size: 20px;
}

.btn-fill-s{
	display: block;
}

.btn-fill {
	height: 67px;
	width: 509px;
	background-color: #304294;
	color: white;
	text-align: center;
	line-height: 67px;
	font-size: 23px;
	border-radius: 5px;
}

#logo {
	height: 215px;
	width: 500px;
}

table tr td{
	text-align: left
}
</style>
</head>
<body>
<a href="<c:url value='/'/>"><img src="img/logo4.png" alt="홈으로" id="logo"></a>
<h3>로그인</h3>
<form action="login" method="post">
<table>
<tr><th>아이디</th>
</tr>
<tr>
	<td><input type="text" id="userid"/><br/>
	</td>
</tr>
<tr><th>비밀번호</th>
</tr>
<tr>
	<td><input type="password" onkeypress="if( event.keyCode == 13){ go_login() }" id="userpw"/><br/>
	</td>
</tr>
</table>
<br/>
<div class="btnSet">
<a class="btn-fill" id="login" onclick="go_login()">로그인</a>
</div>
</form>
<br/>
<a id="custom-login-btn" href="javascript:loginWithKakao()"><img src="img/snsloginbtn_kakao.png" style="height: 77px;"/></a>
<br/>
<a id="btn_Nlogin" href="Nlogin"><img src="img/snsloginbtn_naver.png" style="height: 77px;"/></a>
</body>
</html>