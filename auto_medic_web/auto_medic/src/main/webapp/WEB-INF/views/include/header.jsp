<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css"
	href="css/common.css?v=<%=new Date().getTime()%>">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>

//주소가 노출되지 않게 함수로 주기
function go_navigation(member_email){

	$('[name=member_email]').val(member_email); 	
	$('form').submit();
	
}

//오토메딕 앱로그아웃
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
//네이버로그아웃
function go_Nlogout(){
	$.ajax({
		type : 'post',
		url : 'Nlogout',
		success : function(){
			location.reload();
		},error : function(req, text){
			alert(text+' : '+req.status)
		}
	});
}
//카카오로그아웃
function go_Klogout(){
	$.ajax({
		type : 'post',
		url : 'Klogout',
		success : function(){
			location.reload();
		},error : function(req, text){
			alert(text+' : '+req.status)
		}
	});
}

</script>
<style media="screen">
* {
	margin: 0;
	padding: 0;
}


#dm_ul {
	height:100%;
	width: 1900px;
	min-width: 300px;
	text-align: center;
	/* background-color: blue; */
	overflow: hidden;
	margin-bottom: -1px;
}


#dm_ul li{
width:345px;
	background-color: #304294;
}

#dm_ul li a{
	color:white;
	width:100%;
}
.logo{
	display: block;
}

.dropmenu ul ul {
	position: absolute;
	display: none;
}

.dropmenu ul ul li {
	display: block;
	background-color: navy;
}

.dropmenu ul li {
	display: inline-block;
	margin-left: -5.5px;
}

.dropmenu ul li a {
	display: block;
	width: 150px;
	line-height: 69px;
	color: black;
	text-decoration: none;
}

.dropmenu ul li a:hover {
	background-color: navy;
	color: blue;
}

#welcome_m, #welcome_n, #welcome_k {
	height: 25px;
	line-height: 25px;
	color: white;
	padding: 25px 0px 25px 0px;
	margin-top: -21px;
	margin-bottom: 15px;
}

#letter, #out, #go_my {
	padding: 15px;
	margin: 6px;
	border-radius: 5px;
}

.myInfo-img {
		width: 30px;
		height: 30px;
		-webkit-border-radius: 50px;
		display: inline-block;
	}

</style>
<body>
<!-- 상단아이디표출 -->
<!-- 로그인한 경우-->
<c:if test="${!empty login_info && empty Naverlogin && empty Kakaologin}">
<div style="float: right; position: relative; left: -92px; ">&nbsp;<img src='img/default_profile.jpg' class="myInfo-img" />${login_info.member_nickname }님!&nbsp;[${login_info.member_email}]</div>
</c:if>
<!-- 네이버 로그인한 경우 -->
<c:if test="${!empty Naverlogin }">
<div style="float: right; position: relative; left: -92px;">&nbsp;<img src='img/default_profile.jpg' class="myInfo-img" />${Naverlogin.naver_nickname }님!&nbsp;[${Naverlogin.naver_email}]</div>
</c:if>
<!-- 카카오 로그인한 경우 -->
<c:if test="${!empty Kakaologin }">
<div style="float: right; position: relative; left: -92px;">&nbsp;<img src='img/default_profile.jpg' class="myInfo-img" />${Kakaologin.kakao_nickname }님!&nbsp;[${Kakaologin.kakao_email}]</div>
</c:if>
		<div class="dropmenu" style="z-index: 2">
		<div class='logo'>
			
		</div>
		<div style = 'margin-top: -100px;'>
			<ul id="dm_ul">
				<!-- <li class='logo'>
				<ul>
				<li><a></a></li>
				
				</ul><a href="/automedic">로고가 들어갈 <img src="img/logo_web.png"
						href='#' alt='로고' height="100%" width="100%" />
				</a></li> -->
				<li style="background-color: white;"><a href="/automedic"><img src="img/logo4.png" alt="로고이미지" style='height: 100%; width: 100%; margin-bottom: -36px;
				'></a></li>
				<li><a href="#">제품소개</a>
					<ul style="z-index: 2">
						<li><a href="#">퍼블리싱</a></li>
						<li><a href="#">기획</a></li>
						<li><a href="#">유니티</a></li>
						<li><a href="#">포토샵</a></li>
					</ul></li>
				<li><a href="#">정보마당</a>
					<ul style="z-index: 2">
						<li><a href="map.if">지도검색</a></li>
						<li><a href="drug.if">약검색</a></li>
						<li><a href="letter">쪽지연습용(발신)</a></li>
						<li><a href="receive">쪽지연습용(수신)</a></li>
					</ul></li>
				<li><a href="#">고객센터</a>
					<ul style="z-index: 2">
						<li><a href="#">공지사항</a></li>
						<li><a href="#">학사일정</a></li>
						<li><a href="#">행사사진</a></li>
						<li><a href="#">시설안내</a></li>
					</ul>
				</li>
					<li>
					<!-- 로그인하지 않은 경우 -->
	        		<c:if test="${empty login_info && empty Naverlogin && empty Kakaologin }">
				 		<a id=gologin href="memberLogin" style="display: inline-block; width: 200px; margin-left: -100px;">로그인</a>
				 		<a id=gojoin href="member" style="display: inline-block; width: 100px;">회원가입</a>
				 	</c:if>
				 	<!-- 로그인한 경우 -->
				 	<c:if test="${!empty login_info && empty Naverlogin && empty Kakaologin}">
				 	<form method="post" action="navigation.my" >
        			<input type="hidden" name="member_email">
				 	<div id="welcome_m">
						<input id="go_my" type="button" value="내정보" onclick="go_navigation('${login_info.member_email }')">
						<input id="letter" type="button" value="쪽지함" onclick="receive">
						<input id="out" type="button" value="로그아웃"  onclick="go_logout()"></div>
				 	</form>
				 	</c:if>
				 	<!-- 네이버 로그인한 경우 -->
				 	<c:if test="${!empty Naverlogin }">
				 	<div id="welcome_n">
						<input id="go_my" type="button" value="내정보" onclick="go_navigation('${Naverlogin.naver_email }')">
						<input id="letter" type="button" value="쪽지함"  onclick="receive">
						<input id="out" type="button" value="로그아웃"  onclick="go_Nlogout()"></div>
				 	</c:if>
				 	<!-- 카카오 로그인한 경우 -->
				 	<c:if test="${!empty Kakaologin }">
				 	<div id="welcome_k">
						<input id="go_my" type="button" value="내정보" onclick="go_navigation('${Kakaologin.kakao_email }')">
						<input id="letter" type="button" value="쪽지함"  onclick="receive">
						<input id="out" type="button" value="로그아웃"  onclick="go_Klogout()"></div>
				 	</c:if>
				 	</li>
			</ul>
			</div>
	</div>
<script type="text/javascript">

$(".dropmenu ul li").hover(function(){
	  $(this).find("ul").stop().fadeToggle(300);
	});

</script>
</body>


