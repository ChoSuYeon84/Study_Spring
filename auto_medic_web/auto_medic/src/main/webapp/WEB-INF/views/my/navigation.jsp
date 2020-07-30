<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
function drop(){
	if(confirm('정말 탈퇴하시겠습니까?')){
        alert('완료되었습니다');
        window.location.replace("/automedic");      
       /*  window.location
       .replace("/delete.my?member_email=${login_info.member_email }");    */   
 };
}
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="myinfo">  
  <a href="mypage.my?member_email=${login_info.member_email }">프로필변경</a></div> 
 <div class="myinfo">  
  <a href="#">전화번호변경</a></div> 
 <div class="myinfo">  
  <a href="#">비밀번호변경</a></div><br/> 
 <div class="myinfo1">  
  <a href="#">복용기록</a></div> 
<div class="myinfo2">  
  <a onclick="drop()">회원탈퇴</a></div> 
</ul>
</div>
</body>
</html>