<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
#map{
	margin-top: 20px;
	width: 500px;
	height: 500px;
	float: left;
}

#contents {
	margin: 0 auto;
	width: 1000px;
	height: 700px;
	overflow: hidden;
}

p {
	padding: 10px;
	font-size: 1.8em;
	margin-top: 30px;
}

#contactUs {
	width : 480px;
	height : 500px;
	float: right;
	border: 1px solid #ccc;
	border-radius : 10px;
	margin-top: 20px;
	margin-left: 5px;
}

#contactUs li {
	line-height:40px; 
	margin:5px 0 5px 20px;
	list-style: none;
}

.bold lspacing05, .bold {
	color: #4374D9;
	font-size: 20px;
}
</style>
<meta charset="UTF-8">
<title>AutoMedic : 오시는길</title>
</head>
<body>

<div id="contents">
<p>오시는길</p>
<hr/>
<!-- 지도를 표시할 div 입니다 -->
<div id="map"></div>
<div id="contactUs">
	<ul>
		<li><span class="bold lspacing05">◆&nbsp;주&nbsp;&nbsp;&nbsp;소</span> :<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(619-28) 광주광역시 서구 경열로 3 ( 농성동 271-4 )</li>
		<li><span class="bold lspacing05">◆&nbsp;버&nbsp;&nbsp;&nbsp;스</span> :<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;금호36, 문흥39, 봉선37, 송정19,송암68, 송암72,<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;나주160, 함평500, 지선1187, 마을763</li>
		<li><span class="bold">◆&nbsp;지 하 철</span> :<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;농성역1번 출구, (도보 5분여 소요)</li>
		<li><span class="bold">◆&nbsp;전화번호</span> :<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;062)362-7797</li>
		<li><span class="bold">◆&nbsp;F A X</span> :<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;062)362-7798</li>
	</ul>
</div>
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ef0fde12cdb2634a56685939df6aa859&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(35.15346420918431, 126.88798794342071), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption); 
var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

//일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
var mapTypeControl = new kakao.maps.MapTypeControl();

// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
var zoomControl = new kakao.maps.ZoomControl();
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

//마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(35.15346420918431, 126.88798794342071); 

//마커를 생성합니다
var marker = new kakao.maps.Marker({
 position: markerPosition
});

//마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

//아래 코드는 지도 위의 마커를 제거하는 코드입니다
//marker.setMap(null);    
</script>
</body>
</html>