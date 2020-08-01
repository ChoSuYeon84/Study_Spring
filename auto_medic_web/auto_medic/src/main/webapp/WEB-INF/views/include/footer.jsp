<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<style>

body{
	margin-top: 100px;
}
.container{
	margin: 0 auto;
	width: 1200px;
	background-color: #B2B2B2;
	color: white;
}

a {
	color: #B2B2B2
}

ul.tabs{
	list-style: none;
}

ul.tabs li{
	background: none;
	color: white;
	display: inline-block;
	padding: 10px 20px;
	cursor: pointer;
}

ul.tabs li.current{
	background: #333333;
	color: #B2B2B2;
}

.tab-content{
	display: none;
	background: #333333;
	padding: 15px;
}

.tab-content.current{
	display: inherit;
}
</style>
<script type="text/javascript">

$(document).ready(function(){
	
	$('ul.tabs li').click(function(){
		var tab_id = $(this).attr('data-tab');

		$('ul.tabs li').removeClass('current');
		$('.tab-content').removeClass('current');

		$(this).addClass('current');
		$("#"+tab_id).addClass('current');
	})

})
</script>
</head>
<body>
	<div class="container">

		<ul class="tabs">
			<li class="tab-link current" data-tab="tab-1">회사정보</li>
			<li class="tab-link" data-tab="tab-2">사이트맵</li>
			<li class="tab-link" data-tab="tab-3">다운로드</li>
		</ul>
	
		<div id="tab-1" class="tab-content current" style="overflow: hidden;">
			<div id=copy style="width: 850px; float: left;">
				<div>업체명 : 식후30분 (Auto-Medic)</div>
				<div>주&nbsp;&nbsp;&nbsp;소 :  (619-28) 광주광역시 서구 경열로 3 ( 농성동 271-4 ) </div>
				<div>연락처 : 062-362-7797</div><a href="contactus">오시는길</a>
				<div>Copyright 2020</div>
			</div>
			<div id=download style="width: 200px; float: right ;">
				<a href='http://m.site.naver.com/0CPcf' style="text-decoration: none;">App다운로드</a>
				<a href='http://m.site.naver.com/0CPcf'><img src='img/qrcode.png'/></a>
			</div>
		</div>
		<div id="tab-2" class="tab-content">
			<ul>
				<li>준비중입니다....</li>
			</ul>
		</div>
		<div id="tab-3" class="tab-content">
			<span>다운로드</span>
		</div>

	</div>
</body>
</html>
