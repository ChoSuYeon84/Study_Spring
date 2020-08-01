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



#dm_ul {
height:100%;
	width: 100%;
	min-width: 300px;
	text-align: center;
	background-color: blue;
}


#dm_ul li{
width:300px;
	background-color: black;
}

#dm_ul li a{
	color:white;
	width:100%;
}
.logo{
	display: inline;
}
#dm_ul li:first-child {
	
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
		<div class="dropmenu" style="z-index: 2">

		<div class='logo'>
			
		</div>
		<div>
			<ul id="dm_ul">
				<!-- <li class='logo'>
				<ul>
				<li><a></a></li>
				
				</ul><a href="/automedic">로고가 들어갈 <img src="img/logo_web.png"
						href='#' alt='로고' height="100%" width="100%" />
				</a></li> -->

				<li><a href="/automedic">메인화면</a>
					<ul style="z-index: 2">
						<li><a href="#">인사말</a></li>
						<li><a href="#">설립취지</a></li>
						<li><a href="#">비전/미션</a></li>
						<li><a href="#">교육목표</a></li>
					</ul></li>
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
					</ul></li>
				<li><a href="#">고객센터</a>
					<ul style="z-index: 2">
						<li><a href="#">공지사항</a></li>
						<li><a href="#">학사일정</a></li>
						<li><a href="#">행사사진</a></li>
						<li><a href="#">시설안내</a></li>
					</ul></li>
			</ul>
			</div>
	</div>

	<script type="text/javascript">
      $(".dropmenu ul li").hover(function(){
        $(this).find("ul").stop().fadeToggle(300);
      });
    </script>
</body>


