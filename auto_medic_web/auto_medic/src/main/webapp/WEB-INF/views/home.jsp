<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>

//네이버로그인시 아이디, 이메일 표출
$(document).ready(function() {
	var Nname = ${result}.response.name;
	var Nemail = ${result}.response.email;
	var Nphoto = ${result}.response.profile_image;
	$("#Nname").html(Nname+"님!");
	$("#Nemail").html(Nemail);
	$("#Nphoto").attr('src', Nphoto);
  });

function go_login(){
	if($('#userid').val()==''){
		alert('아이디를 입력하세요!');
		$('#userid').focus();
		return;
	} else if($('#userpw').val()==''){
		alert('아이디를 입력하세요!');
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
				location.reload();
			}else {
				alert('아이디나 비밀번호가 일치하지 않습니다!');
				$('#userid').focus();
			}
			
		},error : function(req, text){
			alert(text+' : '+req.status)
		}
	});
}

function go_logout(){
	$.ajax({
		type : 'post',
		url : 'logout',
		success : function(){
			location.reload();
		},error : function(req, text){
			alert(text+' : '+req.status)
		}
	});
}
</script>
<html>
<head>
   <title>Home</title>
   <Style>
	#content {
		height: 700px;
	}
	
	.myInfo-img {
		width: 70px;
		height: 70px;
		-webkit-border-radius: 50px;
		/* float: left; */
		margin: 5px;
	}
	
	.myInfo_userName {
		text-decoration: none !important;
		margin: 10px;
		padding-top: 20px;
		clear: both;
	}
	
	.myInfo_email {
		margin: 0 10px;
		padding-top: 20px;
		font-size: 12px;
	}
	
	.my-info {
		border: 1px solid #ccc;
		overflow: hidden;
		height: 120px;
		width: 260px;
		margin: 10px;
		padding: 5px;
	}
	
	.my-btnSet {
		margin-: 13px;
	}
	
	a.mybtn-empty {
		text-align: center;
		padding: 5px 12px;
		border: 1px solid #ccc;
		border-radius: 3px;
		text-decoration: none !important;
		color: gray;
		margin: -2px;
	}
	
	a.mybtn-fill {
		background-color: #ccc;
		margin-top: 5px;
		width: 248px;
		height: 30px;
		padding : 3px 104px;
		display: block;
		border-radius: 3px;
		
	}
	
	#btn_join, #btn_findPw, #btn_social {
		padding: 11px;
	}
	
	</Style>
</head>
<body>
<div id = "content" class="container">
    <div class="row">	
        <div class="col-sm-12">
          
        </div>
    </div>
    <div id='content' class="row">
        <div class="col-sm-9">
        <!-- 메인화면 이미지 -->
        <img src='img/home.png' class="img-responsive"/></div>
        <div class="col-sm-3" style="padding: 0px;">
        	<!-- 로그인한 경우 -->
        	<c:if test="${!empty login_info }">
        	<div class="my-info">
	        	<table class="my_info_tab">
	        		<tr>
	        			<td rowspan="2" style="vertical-align:middle"><img src='img/default_profile.jpg' class="myInfo-img"/></td>
	        			<td>${result}.response.name;</td>
	        		</tr>
	        		<tr>
	        			<td>${result}.response.email;</td>
	        		</tr>
	        		<tr>
	        		<td colspan="2" class="my-btnSet">
	        			<a class="mybtn-empty" onclick="go_logout()">로그아웃</a>
						<a class="mybtn-empty" href="#">내정보</a>
						<a class="mybtn-empty" href="#">쪽지함</a>
	        		</td>
	        		</tr>
	        	</table>
	        </div>
	        </c:if>
	        <!-- 로그인하지 않은 경우 -->
	        <c:if test="${empty login_info }">
	        <div class="my-info">
	        	<table class="my_info_tab">
	        		<tr>
	        			<td>I&nbsp;&nbsp;D:</td>
	        			<td><input type="text" id="userid"/></td>
	        		</tr>
	        		<tr>
	        			<td>PW:</td>
	        			<td><input type="password" onkeypress="if( event.keyCode == 13){ go_login() }" id="userpw"/></td>
	        		</tr>
	        	</table>
	        	<a class="mybtn-fill" onclick="go_login()" id="btn_login">로그인</a>
	        	<a href="member" id="btn_join">회원가입</a>
	        	<a id="btn_findPw">PW찾기</a>
	        	<a id="btn_Nlogin" href="Nlogin"><img src='img/naver.png' style="width: 25px; height: 25px; margin-left: 10px;"></a>
	        	<a id="btn_Klogin"><img src='img/kakao.png' style="width: 25px; height: 25px; margin: 0 5px 0 10px;"></a>
        	</div>
        	</c:if>
        	<!-- 네이버로그인한 경우-->
        	<div class="my-info">
	        	<table class="my_info_tab">
	        		<tr>
	        			<td rowspan="2" style="vertical-align:middle"><img id="Nphoto"></td>
	        			<td id=Nname></td>
	        		</tr>
	        		<tr>
	        			<td id=Nemail></td>
	        		</tr>
	        		<tr>
	        		<td colspan="2" class="my-btnSet">
	        			<a class="mybtn-empty" onclick="go_logout()">로그아웃</a>
						<!-- <a class="mybtn-empty" href="#">내정보</a> -->
						<a class="mybtn-empty" href="#">쪽지함</a>
	        		</td>
	        		</tr>
	        	</table>
	        </div>
	        <!-- 네이버로그인한 경우-->
        </div>	
    </div>
</div>   

</body>
</html>
