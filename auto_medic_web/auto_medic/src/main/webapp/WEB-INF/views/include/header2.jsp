<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css"
   href="css/common.css?v=<%=new Date().getTime()%>">
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
</script>
<head>
<div style="float: right; border:none;">
${login_info.member_nickname }님![${login_info.member_email}] 환영합니다^^
<input type="button" value="로그아웃"  onclick="go_logout()"></div>

<a href="/automedic"><img src="img/logo1.PNG" style="width:25px; height: 25px;float: left;"></a>
<h3>&nbsp;상세정보</h3>

<hr>
</head>
      