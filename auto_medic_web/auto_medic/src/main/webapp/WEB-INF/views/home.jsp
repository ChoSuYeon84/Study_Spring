<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
   <title>Home</title>
   <Style>
     
      #content {
         height:700px;
      }
      
      .myInfo-img {
      	width: 80px;
      	height: 80px;
		-webkit-border-radius: 50px;
		float: left;
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
   </Style>
</head>
<body>
<div id = "content" class="container">
    <div class="row">	
        <div class="col-sm-12">
           <jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include> 
        </div>
    </div>
     <div id='content' class="row">
        <div class="col-sm-9">
        <img src='img/home.png' class="img-responsive"/></div>
        <div class="col-sm-3" style="padding: 0px;">
        	<div class="my-info">
	        	<div>
	        		<img src='img/default_profile.jpg' class="myInfo-img"/>
	        		<a class="myInfo_userName">닉네임 님!</a>
	        		<div class="myInfo_email">email@email.com</div>
	        	</div>
	        	<div class="my-btnSet">
					<a class="mybtn-empty" href="#">로그아웃</a>
					<a class="mybtn-empty" href="#">내정보</a>
					<a class="mybtn-empty" href="#">쪽지함</a>
				</div>
        	</div>
        </div>
    </div>
</div>   

<jsp:include page="/WEB-INF/views/include/footer.jsp"/> 
</body>
</html>