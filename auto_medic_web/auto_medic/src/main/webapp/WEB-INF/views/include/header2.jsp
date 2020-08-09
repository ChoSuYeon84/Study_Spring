<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css"
   href="css/common.css?v=<%=new Date().getTime()%>">
<style>
.myInfo {
		width: 30px;
		height: 30px;
		-webkit-border-radius:15px;	
		style:border-radius:50%;
		position: relative;
		top: -1px;
	}
#text{
float: right;
position: relative;
top:2px;
font-size: 1.17em;;
}


</style>
<script type="text/javascript"
   src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
function go_logout(){
	$.ajax({
		type : 'post',
		url : 'logout',
		success : function(){			
			location.href="/automedic";
		},error : function(req, text){
			alert(text+' : '+req.status)
		}
		
	});
}

function changelogin_info(member_nickname, member_email){
	alert(member_nickname + "-" + member_email);
	$.ajax({
		type : 'post',
		url : 'automedic',
		data : { member_nickname :member_nickname, member_email :member_email},
		success : function(){			
			location.href="/automedic";
		},error : function(req, text){
			alert(text+' : '+req.status)
		}
		
	});
	//$("[name=header]").load(window.location.href + "[name=header]");

	
    //$('[name=header]').reload();
    //location.href="/automedic";
 }//changelogin_info()
</script>

<head>
</head>
<div style="float: right; ">
<c:if test="${empty vo.member_profile}">
      <img src='img/default_profile.jpg' class="myInfo" id="pre" name="${vo.member_profile}"/> 
</c:if>
<c:if test="${!empty vo.member_profile}">     
        <span id="pre"></span>
</c:if>
&nbsp;
<div id="text">
${vo.member_nickname }님![${login_info.member_email}] 환영합니다^^
<input type="button" value="로그아웃"  onclick="go_logout()"></div></div>

<a onclick="changelogin_info('${vo.member_nickname }','${login_info.member_email}')"><img src="img/logo1.PNG" style="width:25px; height: 25px;float: left;"></a>
<!-- href="/automedic" -->
<h3>&nbsp;상세정보</h3>

<hr>
 <script type="text/javascript">
//저장된 프로필 부르기
 if(${!empty vo.member_profile}){
 	show('#pre');
 	
 }

 function show(id){		
 	//첨부된 파일이 이미지인 경우 보여지게
 	var member='${vo.member_profile}';
 	// ().jpg →jpg만 보임
 	var ext=member.substring(member.lastIndexOf('.')+1).toLowerCase();
 	
 	var imgs=['gif','jpg','jpeg','bmp','png'];
 	if(imgs.indexOf(ext)>-1){
 	//이형태 filepath, file-img는 따로 빼야 하지만 이것도 문자여서 ''붙임
 	 var img='<img src="'+'resources/'+'${vo.member_profile}'.substring(1) + '"'
          +' id="prev" class="myInfo" >';   
      // '/'는 빠짐
      var ic='${vo.member_profile}'.substring(1);
      console.log(ic);
      $(id).html(img);   
 	}
 }
</script>
      