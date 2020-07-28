<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>공공데이터</h3>
<div class="btnSet dataOption">
	<a class="btn-fill">약국조회</a>
	<a class="btn-empty">유기동물조회</a>
</div>
<div id='data-list' style="margin:20px 0 auto"></div>

<script type="text/javascript">
$('.dataOption a').click(function(){
	//이미 선택된 버튼에 대해서는 적용하지 않으려면
	if( $(this).hasClass('btn-empty')) {
		$('.dataOption a').removeClass();
		$(this).addClass('btn-fill');
		var idx = $(this).index();
		$('.dataOption a:not(:eq('+idx+'))').addClass('btn-empty');
		if( idx==0 ) pharmacy_list();
		else		 animail_list();
	}
});
pharmacy_list();
function pharmacy_list(){
	$.ajax({
		url: 'data/pharmacy',
		success: function(data){
			console.log(data);
			var tag = '<table class="pharmacy">';
				+ '<tr><th class="w-pw200">약국명</th><th class="w-pw140">전화번호</tn><th>주소</tn></tr>'

				$(data.item).each(function(){
					tag += '<tr><td>'+ this.yadmNm +'</td><td>'+ this.telno +'</td><td class="left">'+ this.addr +'</td>'
						+'</tr>'
				});
				tag+= '</table>';
				$('#data-list').html(tag);
			
		}, error: function(req, text){
			alert(text+":"+req.status)
		}
	});
	
}
function animail_list(){
	
}
</script>

</body>
</html>