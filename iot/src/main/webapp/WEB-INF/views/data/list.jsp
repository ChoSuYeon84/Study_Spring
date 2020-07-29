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

.page_on, .page_off, .page_next, .page_last, .page_prev, .page_first {
	display: inline-block; line-height: 30px; margin: 0px; 
}

.page_on, .page_off {
	min-width: 30px;
	padding: 0px 5px 2px;
}

.page_next, .page_last, .page_prev, .page_first {
	text-indent: -9999999px;
	border: 1px solid #d0d0d0; width: 30px;
}

.page_on {
	border: 1px solid gray; background-color: gray; color: #fff; font-weight: bold;
}

.page_next { background: url('img/page_next.jpg') center no-repeat;}
.page_last { background: url('img/page_last.jpg') center no-repeat;}
.page_prev { background: url('img/page_prev.jpg') center no-repeat;}
.page_first { background: url('img/page_first.jpg') center no-repeat;}

.list-view, .grid-view { font-size: 25px; color: #3367d6; padding-top: 3px}
.common li i { vertical-align: top;}
#list-top ul.common li:not(:last-child){margin-right: 10px;}
#data-list ul.pharmacy li div:first-child {height:25px;}
#data-list ul.pharmacy li div:last-child {font-size:14px;}
</style>
</head>
<body>
<h3>공공데이터</h3>
<div class="btnSet dataOption">
	<a class="btn-fill">약국조회</a>
	<a class="btn-empty">유기동물조회</a>
</div>
<div id='list-top'>
	<ul class="common">
		<li><select id='pageList' class='w-pw80'>
			<option value="10">10개씩</option>
			<option value="20">20개씩</option>
			<option value="30">30개씩</option>
			</select>
		</li>
		<li class='list-view'><i class="fas fa-list font-img"></i>
		</li>
		<li class='grid-view'><i class="fas fa-th font-img"></i>
		</li>
	</ul>
</div>
<div id='data-list' style="margin:20px 0 auto"></div>
<div class="btnSet">
	<div class="page_list"></div>
</div>

<div id='map-background'></div>
<div id='map'></div>

<script type="text/javascript">
var viewType= 'list';
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
		data: {pageNo: page, rows:$('#pageList').val()},
		success: function(data){
			console.log(data);
			var tag = '<table class="pharmacy">';
				+ '<tr><th class="w-pw200">약국명</th><th class="w-pw140">전화번호</tn><th>주소</tn></tr>'

				$(data.item).each(function(){
					tag += '<tr><td><a class="map" data-x='+ this.XPos +' data-y=' + this.YPos + '>'+ this.yadmNm +'</a></td><td>'+ (this.telno ? this.telno : "-") +'</td><td class="left">'+ this.addr +'</td>'
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
		tag += '<a class="page_first" data-page=1 >처음</a>'
			+'<a class="page_prev" data-page='+ (page.beginPage-blockPage) +'>이전</a>'
	}

	for(var no = page.beginPage; no <= page.endPage; no++ ){
		if( no == curPage )
			tag += '<span class="page_on">'+ no +'</span>';
		else
			tag += '<a class="page_off" data-page='+ no +'>'+ no +'</a>';
	}
	if( page.curBlock < page.totalBlock){
		tag += '<a class="page_next" data-page='+ (page.endPage+1) +'>다음</a>'
			+'<a class="page_last" data-page='+ page.totalPage +'>마지막</a>';
	}
	$('.page_list').html(tag);
}

//페이지 처리
function pageInfo(totalList, curPage, pageList, blockPage){
	 var page = new Object();
	 page.totalPage = parseInt(totalList / pageList) + (totalList % pageList == 0 ? 0 : 1);
	 page.totalBlock = parseInt(page.totalPage / blockPage) + (page.totalPage % blockPage == 0 ? 0 : 1);
	 page.curBlock = parseInt(curPage / blockPage) + (curPage % blockPage == 0 ? 0 : 1);
	 page.endPage = page.curBlock * blockPage;
	 page.beginPage = page.endPage - (blockPage-1);
	 if ( page.endPage > page.totalPage ) page.endPage = page.totalPage;
	 return page;
}

function animail_list(){
	
}
//테이블목록뷰-> 그리드뷰로 변경
function pharmacy_grid_data( data ){
	var tag = '<ul class="pharmacy grid">';
	data.each(function(){
		if( $(this).index() > 0 ) {	//0번은 헤드부분(제목)이므로 불필요해서 0 이후부터
			var $a = $(this).find('.map'); 
			tag += '<li>'
				+'<div><a class="map" data-x="'+ $a.data('x') +'" data-y="'+ $a.data('y')+'">'+ $(this).children('td:eq(0)').text() +'</div>'
				+'<div>'+ $(this).children('td:eq(1)').text() +'</div>'
				+'<div>'+ $(this).children('td:eq(2)').text() +'</div>'
				+'</li>';
		}
		
	});
	tag += '</ul>';
	$('#data-list').html(tag);
	$('#data-list ul').css('height', 
			( ( $('.grid li').length % 5 > 0 ? 1 : 0 ) + Math.floor( $('.grid li').length/5 ) )	
			* $('.grid li').outerHeight(true) - 20);
		
}

function pharmacy_list_data(data){
	
}

$(document).on('click', '.page_list a', function(){
	pharmacy_list( $(this).data('page') );

}).on('change', '.list-view', function(){
	if(viewType=='grid'){
		viewType='list';
		pharmacy_list_data($('.grid li'));
	}

}).on('click', '.grid-view', function(){
	if( viewType=='list' ){
		viewType='grid';
		pharmacy_grid_data( $('.pharmacy tr'));
	}
	
}).on('change', '#pageList', function(){
	pageList = $(this).val();
	pharmacy_list(1);
	
}).on('click', '.map', function(){
	if( $(this).data('y')=='undefined' || $(this).data('x')=='undefined'){
		alert('위경도가 지원되지 않아 지도에 표시할 수 없습니다!')
		return;
	}
	$('#map, #map-background').css('display', 'block');

	var pos = {lat: Number($(this).data('y')), lng: Number($(this).data('x'))} /* lat : 위도y lng : 경도x */
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