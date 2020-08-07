<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<style type="text/css">

.myinfo{

float:left;
width: 350px;
height:200px;
margin:130px;
border: 3px solid black;
border-radius:50px; 

}	 
.myinfo1{
float:left;
width: 350px;
height:200px;
margin:0 250px 0 450px;
border: 3px solid black;
border-radius:50px; 

}	 
.myinfo2{
float:left;
width: 350px;
height:200px;
margin:0 200px 0 0px;
border: 3px solid black;
border-radius:50px; 

}	 

/* #myinfo ul li:nth-child(n):hover{
background-color: blue; 
}
#myinfo ul li a:hover{
color: white;
} */
a{  
 text-decoration: none;
 display: block;
 text-align:center;
 line-height: 200px;
 font-size: 1.17em;   
}
a:hover{
color:white;
}
.myinfo:hover, .myinfo1:hover, .myinfo2:hover{
background: green;
}

</style>
<script type="text/javascript">
/* function drop(){
	if(confirm('정말 탈퇴하시겠습니까?')){
       
       /*  window.location.replace("/automedic");     
       href.reload("/delete.my?member_email="${login_info.member_email }); 
       alert('탈퇴가 완료되었습니다');  
 };
} */
//주소가 노출되지 않게 함수로 주기
function go_mypage(member_email){

	$('[name=member_email]').val(member_email);
	$('form').attr('action','mypage.my'); //attr:속성바꿈
	$('form').submit();
	
}
function go_tel(member_email){

	$('[name=member_email]').val(member_email);
	$('form').submit();
	
}
function go_password(member_email){

	$('[name=member_email]').val(member_email);
	$('form').attr('action','password.my'); //attr:속성바꿈
	$('form').submit();
	
}
</script>
<script type="text/javascript" src="js/no_back.js?v=<%=new java.util.Date().getTime()%>"></script>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>

<body  onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">
<form method='post' action='tel.my'>
<input type="hidden" name="member_email">
<div class="myinfo">  
  <a onclick="go_mypage('${login_info.member_email }')">프로필변경</a></div> 
 <div class="myinfo">  
  <a onclick="go_tel('${login_info.member_email }')">전화번호변경</a></div> 
 <div class="myinfo">  
  <a onclick="go_password('${login_info.member_email }')">비밀번호변경</a></div><br/> 
 <div class="myinfo1">  
  <a href="calendar.my">복용기록</a></div> 
<div class="myinfo2">  
  <a onclick="if(confirm('정말 탈퇴하시겠습니까?')){href='delete.my?member_email=${login_info.member_email }'}">회원탈퇴</a></div> 
</form>
</body>
</html>