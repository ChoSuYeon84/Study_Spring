<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css"
	href="css/common.css?v=<%=new Date().getTime()%>">

<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<style media="screen">
* {
	margin: 0;
	padding: 0;
}

header {
	min-width: 300px;
	height: 80px;
	background-color: navy;
	font-size: 30px;
	color: white;
	position: relative;
}

header p {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translateX(-50%) translateY(-50%);
}

#dm_ul {
	width: 100%;
	min-width: 300px;
	text-align: center;
}

#dm_ul li{
width:300px;
	background-color: black;
}

#dm_ul li a{
	color:white;
}

#dm_ul li:first-child {
	/* background-color: pink; */
	width: 500px;
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
	line-height: 43px;
	color: black;
	text-decoration: none;
}

.dropmenu ul li a:hover {
	background-color: navy;
	color: blue;
}
</style>
<Style>
</style>
<body>

	<div class="dropmenu">
		<ul id="dm_ul">
			<li>
				<a href="/automedic">
					<img src="img/logo_web.png" href='#' alt='로고' height="150px" width="500px" />
				</a>
			</li>

			<li><a href="/automedic">메인화면</a>
				<ul>
					<li><a href="#">인사말</a></li>
					<li><a href="#">설립취지</a></li>
					<li><a href="#">비전/미션</a></li>
					<li><a href="#">교육목표</a></li>
				</ul></li>
			<li><a href="#">제품소개</a>
				<ul>
					<li><a href="#">퍼블리싱</a></li>
					<li><a href="#">기획</a></li>
					<li><a href="#">유니티</a></li>
					<li><a href="#">포토샵</a></li>
				</ul></li>
			<li><a href="#">정보마당</a>
				<ul>
					<li><a href="map.if">지도검색</a></li>
					<li><a href="drug.if">약검색</a></li>
				</ul></li>
			<li><a href="#">고객센터</a>
				<ul>
					<li><a href="#">공지사항</a></li>
					<li><a href="#">학사일정</a></li>
					<li><a href="#">행사사진</a></li>
					<li><a href="#">시설안내</a></li>
				</ul></li>
		</ul>
	</div>

	<script type="text/javascript">
      $(".dropmenu ul li").hover(function(){
        $(this).find("ul").stop().fadeToggle(300);
      });
    </script>
</body>


<Script>

function go_logout(){
   $.ajax({
      type:'post',
      url:'logout',
      success(){
            location.reload();
         },error:function(req,text){
               alert(text+":"+req.status);
            }
      });
}
function go_login(){
   if($('#userid').val()==''){
         
         $('#userid').focus();
         return;
      }else if($('#userpw').val()==''){
         alert('비밀번호를 입력하세요!');
         $('#userpw').focus();
         return;
      }

      $.ajax({
         type:'post',
         url:'login',
         data: {id:$('#userid').val(),pw:$('#userpw').val()},
         success: function(data){
            alert(data);
            if(data=='true'){
                  location.reload();
               }else{
                     alert('아이디나 비밀번호가 일치하지 않습니다!');
                     $('#userid').focus();
                  }
            },error:function(req, text){
                  alert(text+":"+req.status);
               }
      });
}
</Script>