<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<style type="text/css">
  html, div, body, h3{
  	margin: 0;
  	padding: 0;
  }
  
  h3{
  	display: inline-block;
  	padding: 0.6em;
  }
  
</style>
</head>
<body>
<div style="background-color:#15a181; width: 100%; height: 50px;text-align: center; color: white; "><h3>SIST Login</h3></div>
<br>
<!-- 네이버 로그인 화면으로 이동 시키는 URL -->
<!-- 네이버 로그인 화면에서 ID, PW를 올바르게 입력하면 callback 메소드 실행 요청 -->
<div id="naver_id_login" style="text-align:center"><a href="${url}"><img width="223" src="${pageContext.request.contextPath}/resources/images/snsloginbtn_naver.png"/></a></div>
<%-- <br>
<c:url></c:url>
<script>

console.log("${url}")
</script>
<%

// response.sendRedirect("https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=przzu6N6M4M9BvGyF5QG&redirect_uri=http%3A%2F%2F192.168.0.22%3A90%2Fautomedic%2Fcallback&state=6d85bd25-722f-47fd-b743-d02fdeaf3993");
response.sendRedirect("${url}");
%> --%>
</body>
</html>
