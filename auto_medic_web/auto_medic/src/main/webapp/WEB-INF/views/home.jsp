<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
//주소가 노출되지 않게 함수로 주기
 function go_navigation(member_email){

 	$('[name=member_email]').val(member_email); 	
 	$('form').submit();
 	
 }
 
function search(){
	  if(!$('#med').val()){
		  alert("약 검색창을 입력해주세요.");
		  return false;
	   }	
	  alert($('#med').val()+"를 검색했습니다.");
		
	}


$(document).ready(
			function() {

				var refreshInterval = null;
				var timer = null;
				var imgCnt = $('.col-sm-9').children().length;
				var imgIdx = 1;

				timer = function() {
					moveSlider(imgIdx);

					if (imgIdx < imgCnt - 1) {
						imgIdx++;
					} else {
						imgIdx = 0;
					}
				}
				 
				function moveSlider(index) {
					var willMoveleft = -(index * 1710);

					$('.col-sm-9').animate({
						left : willMoveleft
					}, 'slow');	
					
					$('.slider_text[data-index=' + index + ']').show().animate(
							{
								left : 0
							}, 'slow');

					$('.slider_text[data-index!=' + index + ']').hide('slow',
							function() {
								$(this).css('left', -1710);
							});

					$('.control_button[data-index=' + index + ']').addClass(
							'active');
					$('.control_button[data-index!=' + index + ']')
							.removeClass('active');			
				}

				
				$('.animation_canvas').on({
					mouseenter : function() {
						clearInterval(refreshInterval);
					},
					mouseleave : function() {
						refreshInterval = setInterval(timer, 5000)
					}

				});
				$('.control_button').each(function(index) {
					$(this).attr('data-index', index).click(function() {
						var index = $(this).attr('data-index');
						imgIdx = index;
						moveSlider(index);
					});
				});

				$('.slider_text').css('left', -1710).each(function(index) {
					$(this).attr('data-index', index);
				});

				/*  var randomNumber=Math.round(Math.random()*4);

				 moveSlider(randomNumber); */

				$('.slider_text[data-index=' + 0 + ']').show().animate({
					left : 0,
				}, 'slow');

				$('.slider_button[data-index=' + 0 + ']').addClass('active');
			
				refreshInterval = setInterval(timer, 5000)
				/*setInterval:정해진 시간마다 timer해라*/
			});

</script>
<html>
<head>
   <title>Home</title>
   <Style>
   .input{
   margin:10px; 
   }
  
   
   #login{
   position: relative;
		left:1585px;
		top:-745px;
   padding:0px;
   width: 300px;
   height: 224px;
   		
   
   }
	#content {
		height: 730px;
		position: relative;
		left:0px;
		top:10px;
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
		height: 20	0px;
		width: 260px;
		margin: 10px;
		padding: 5px;
		
	}
	#profile{
	position: relative;
		top:-745px;
		left: 1600px;
	
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
	
	
.animation_canvas{
    padding:0px;
    overflow: hidden;
	position: relative;
	width: 1710px; height:700px; margin:0 auto;
} 

.col-sm-9 {

	width: 8550px; height:700px; position: relative;
}
.mainimg{ 
 
    float: left;
	width: 1710px; 
	height:700px; 
	margin:0px;
} 

	/* Slider Text Panel */
	.slider_text_panel {
		position: absolute;
		top: 250px;
		left: 1000px;
	}
	
	.slider_text {
		position: absolute;
		width: 300px;
		height: 150px;
		
	}
	
	/* Control Panel */
	.control_panel {
		position: absolute;
		top: 650px;
		left: 670px;
		height: 13px;
		overflow: hidden;
	}
	
	.control_button {
		width: 12px;
		height: 46px;
		position: relative;
		float: left;
		cursor: pointer;
		background: url('img/point_button.png');
	}
	
	.control_button:hover {
		top: -16px;
	}
	
	.control_button.active {
		top: -31px;
	}	
	
	
	
	</Style>
</head>
<body>
    
    <div id='content' class="row">
        <!-- 메인화면 이미지 -->
        <!-- <img src='img/home.png' class="img-responsive"/></div> -->
        <div class="animation_canvas"> 
        <div class="col-sm-9">
        <!-- 메인화면 이미지 -->
         <a href="#"><img src='img/med.png' class="mainimg"/></a><a>
         <img src='img/running1.PNG' class="mainimg"/></a><a>
         <img src='img/clock.jpg' class="mainimg"/></a><a>
         <img src='img/happy.jpg' class="mainimg"/></a><a>
         <img src='img/iot2.jpg' class="mainimg"/></a>
      </div>
       <div class="slider_text_panel">
			<div class="slider_text">
				<h1>0. Lorem ipsum</h1>
				<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
			</div>
			<div class="slider_text">
				<h1>1. Nulla eget</h1>
				<p>Nulla eget sapien mauris, ornare elementum elit.</p>
			</div>
			<div class="slider_text">
				<h1>2. Quisque</h1>
				<p>Quisque eleifend augue nec lacus lobortis porta.</p>
			</div>
			<div class="slider_text">
				<h1>3. Donec</h1>
				<p>Donec a ligula lectus, eu iaculis justo.</p>
			</div>
			<div class="slider_text">
				<h1>4. Vivamus</h1>
				<p>Vivamus scelerisque mauris id nunc dictum sit amet.</p>
			</div>
		</div>
	
		<div class="control_panel">
			<!-- control_button과 같은 요소는 div태그로 만들고 
			스타일시트에서 background속성으로 이미지를 설정 
			이렇게 하면 스타일시트의 hover필터와 active필터 사용 가능-->
			<div class="control_button"></div>
			<div class="control_button"></div>
			<div class="control_button"></div>
			<div class="control_button"></div>
			<div class="control_button"></div>
		</div>   
    </div>  
</div>
 <%-- <div id="profile" style="padding: 0px;">
        	<!-- 로그인한 경우 -->
        	<c:if test="${!empty login_info && empty Naverlogin && empty Kakaologin }">
        	<form method="post" action="navigation.my" >
        	<input type="hidden" name="member_email">
        	<div class="my-info">
	        	<table class="my_info_tab">
	        		<tr>
	        			<td rowspan="2" style="vertical-align:middle"><img src='img/default_profile.jpg' class="myInfo-img"/></td>
	        			<td>${login_info.member_nickname} 님!</td>
	        		</tr>
	        		<tr>
	        			<td>${login_info.member_email}</td>
	        		</tr>
	        		<tr>
	        		<td colspan="2" class="my-btnSet">
	        			<a class="mybtn-empty" onclick="go_logout()">로그아웃</a>
						<a class="mybtn-empty"  onclick="go_navigation('${login_info.member_email }')" >내정보</a>
						<a class="mybtn-empty" href="#">쪽지함</a>
	        		</td>
	        		</tr>
	        	</table>
	        </div>
	        </form>
	        </c:if>
	        <!-- 로그인하지 않은 경우 -->
	        <c:if test="${empty login_info && empty Naverlogin && empty Kakaologin }">
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
	        	<a href="findPw" id="btn_findPw">PW찾기</a>
	        	<a id="btn_Nlogin" href="Nlogin"><img src='img/naver.png' style="width: 25px; height: 25px; margin-left: 10px;"></a>
	        	<a id="custom-login-btn" href="javascript:loginWithKakao()"><img src='img/kakao.png' style="width: 25px; height: 25px; margin: 0 5px 0 10px;"></a>
        	</div>
        	</c:if>
        	<c:if test="${!empty Naverlogin }">
        	<div class="my-info">
	        	<table class="my_info_tab">
	        		<tr>
	        			<td rowspan="2" style="vertical-align:middle"><img src='img/default_profile.jpg' class="myInfo-img"></td>
	        			<td id=Nname>${Naverlogin.naver_nickname}</td>
	        		</tr>
	        		<tr>
	        			<td id=Nemail>${Naverlogin.naver_email}</td>
	        		</tr>
	        		<tr>
	        		<td colspan="2" class="my-btnSet">
	        			<a class="mybtn-empty" onclick="go_Nlogout()">로그아웃</a>
						<a class="mybtn-empty" href="#">내정보</a>
						<a class="mybtn-empty" href="#">쪽지함</a>
	        		</td>
	        		</tr>
	        	</table>
	        </div>
	        </c:if>
	        <c:if test="${!empty Kakaologin }">
        	<div class="my-info">
	        	<table class="my_info_tab">
	        		<tr>
	        			<td rowspan="2" style="vertical-align:middle"><img src='img/default_profile.jpg' class="myInfo-img"></td>
	        			<td id=Kname>${Kakaologin.kakao_nickname}</td>
	        		</tr>
	        		<tr>
	        			<td id=Kemail>${Kakaologin.kakao_email}</td>
	        		</tr>
	        		<tr>
	        		<td colspan="2" class="my-btnSet">
	        			<a class="mybtn-empty" onclick="go_Klogout()">로그아웃</a>
						<a class="mybtn-empty" href="#">내정보</a>
						<a class="mybtn-empty" href="#">쪽지함</a>
	        		</td>
	        		</tr>
	        	</table>
	        </div>
	        </c:if>
	        <div class="input" >
               <input type="text" id="med" placeholder="약검색" size="29">
               <input type="button" value="검색" id="search" onclick="search()" />                               
            </div>        	
        </div>	 --%>
	
</body>
</html>
