<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#map { 
	position: absolute; width: 800px; height: 600px; 
	left: 50%; top: 50%; transform:translate(-50%, -50%);
	border: 3px solid #666; display: none;
}

#map-background {
	position: absolute; left: 0; top: 0; 
	width: 100%; height: 100%; 
	background-color: #000;
	opacity: 0.3; display: none;
}
</style>
</head>
<body>
<h3>공공데이터</h3>
<div class="btnSet dataOption">
	<a class="btn-fill">약국조회</a>
	<a class="btn-empty">유기동물조회</a>
</div>
<div id='data-list' style="margin:20px 0 auto"></div>
<div class="btnSet">
	<div class="page_list"></div>
</div>

<div id='map-background'></div>
<div id='map'></div>

<script type="text/javascript">
$('.dataOption a').click(function(){
	//이미 선택된 버튼에 대해서는 적용하지 않으려면
	if( $(this).hasClass('btn-empty')) {
		$('.dataOption a').removeClass();
		$(this).addClass('btn-fill');
		var idx = $(this).index();
		$('.dataOption a:not(:eq('+idx+'))').addClass('btn-empty');
		if( idx==0 ) pharmacy_list(1);
		else		 animail_list();
	}
});
pharmacy_list(1);
function pharmacy_list(page){
	$.ajax({
		url: 'data/pharmacy',
		data: {pageNo: page},
		success: function(data){
			console.log(data);
			var tag = '<table class="pharmacy">';
				+ '<tr><th class="w-pw200">약국명</th><th class="w-pw140">전화번호</tn><th>주소</tn></tr>'

				$(data.item).each(function(){
					tag += '<tr><td><a class="map" data-x='+ this.XPos +' data-y=' + this.YPos + '>'+ this.yadmNm +'</a></td><td>'+ this.telno +'</td><td class="left">'+ this.addr +'</td>'
						+'</tr>'
				});
				tag+= '</table>';
				$('#data-list').html(tag);
				makePage( data.count, page );
			
		}, error: function(req, text){
			alert(text+":"+req.status)
		}
	});
	
}
function makePage ( totalList, curPage ){
	var page = pageInfo(totalList, curPage, pageList, blockPage);
	var tag = '';

	if( page.curBlock > 1) {
		tag += '<a class="page_first">처음</a>'
			+'<a class="page_prev">이전</a>'
	}

	for(var no = page.beginPage; no <= page.endPage; no++ ){
		if( no == curPage )
			tag += '<span class="page_on">'+ no +'</span>';
		else
			tag += '<a class="page_off">'+ no +'</a>';
	}
	if( page.curBlock < page.totalBlock){
		tag += '<a class="page_next">다음</a>'
			+'<a class="page_last">마지막</a>';
	}
	$('.page_list').html(tag);
}

//페이지 처리
function pageInfo(totalList, curPage, pageList, blockPage){
	 var page = new Object();
	 page.totalPage = parseInt(totalList / pageList)
						 +(totalList % pageList == 0 ? 0 : 1);
	 page.totalBlock = parseInt (page.totalpage / blockPage)
						 +(page.totalPage % blockPage == 0 ? 0 : 1);
	 page.curBlock = parseInt(curPage / blockPage)
	 					 +(curPage % blockPage == 0 ? 0 : 1);
	 page.endPage = page.curBlock * blockPage;
	 page.beginPage = page.endPage - (blockPage-1);
	 if (page.endPage > page.totalPage ) page.endPage = page.totalPage;
	 return page;
}

function animail_list(){
	
}

$(document).on('click', '.map', function(){
	$('#map, #map-background').css('display', 'block');

	var pos = {lat: $(this).data('y'), lng:$(this).data('x')} /* lat : 위도y lng : 경도x */
	map = new google.maps.Map(document.getElementById('map'), {
		center: pos, 
		zoom: 15
	});

/* 	new google.maps.Marker({
		map : map, position: pos, title: $(this).text()
	}); */

	var info = new google.maps.InfoWindow();
	info.setOptions({
		content: '<div>'+ $(this).text() +'</div>',
	});
	info.open(map, new google.maps.Marker({
		map:map, position:pos
	}));
});
$('#map-background').click(function(){
	$('#map, #map-background').css('display', 'none');
});
var pageList = 10, blockPage = 10;	//페이지당 보여질 목록수, 블럭당 보여질 페이지수

</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCsrerDHJrp9Wu09Ij7MUELxCTPiYfxfBI">
</script>
</body>
</html>