<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://tiles.apache.org/tags-tiles"  prefix="tiles"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${category eq 'cu' ? '고객관리': (category eq 'no'?'공지사항':(category eq 'bo'?'방명록':(category eq 'da'?'공공데이터':(category eq 'join' ? '회원가입':''))))}${empty category?'':' : '}AutoMedic</title>
<link rel="icon" type="image/x-icon" href="img/hanul.ico">
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.1/js/all.min.js"></script>
</head>
<body>
	<tiles:insertAttribute name='header'/>
	<div id='content'>
	<tiles:insertAttribute name='content'/>
	</div>
	<tiles:insertAttribute name='footer'/>
</body>
</html>