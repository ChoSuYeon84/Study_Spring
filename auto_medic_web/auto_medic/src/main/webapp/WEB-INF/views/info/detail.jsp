<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
* {
	padding: 0;
	margin: 0;
}

.container1 {
	width: 1200px;
	/* background-color: yellow; */
	height: 700px;
	margin: 0 auto;
}

.search {
	/* background-color: red; */
	height: 50px;
	margin-top: 50px;
	vertical-align: middle;
	text-align: center;
	line-height: 50px;
}

.result {
	/* background-color: pink; */
	height: 500px;
	margin-top: 50px;
}

.drug {
	height: 500px;
}

.list-view, .grid-view {
	font-size: 25px;
	color: #33675d;
	padding-top: 3px;
}

.top{
	/* background-color: blue; */
	height: 200px;
}
form {
	display: inline-block;
	height: 50px;
}

table {
	float: right;
	line-height: 50px;
	text-align: center;
	WIDTH: 420PX;
}

input[type=text] {
	padding: 0px;
	text-align: center;
	margin: 0px;
	line-height: 46px;
}
.summary-no{
/* 	background-color: gray; */
	height: 100%;
	display: inline-block;
	margin: 0 485px;
}
.summary-yes{
	/* background-color: gray; */
	height: 100%;
	display: inline-block;
	margin: 0;
	margin-left: 20px;
}
.photo-container{
width: 50%;
height: 220px;
float: left;
}
.summary-container{
float: right;
width: 50%;
}

td {
	font-size: 10px;
}

.photo {
	display: inline-block;
    height: 100%;
    float : right;
}
}

#drugImg {
	float: left;
}

.tmp_profile_tb {
	float: left;
}
</style>
</head>
<body>
	<input type="hidden" value=${code } id='drugcode'>
	<div class="container1">
		<div class="search">
			<h1>${name }</h1>
		</div>
		<div class="top">
		<div class="photo-container">
			 <div class="photo">
				<img id="drugImg" src="" height="100%" />
			</div>
		</div>
		
		
		<div class="summary-container">
			<div class="summary-yes">
			<hr>
			<table class="tmp_profile_tb" style='height: 100%'>
				<tr>
					<td style='width:90px;'>구분</td>
					<th>${kind}</th>
				</tr>
				<tr>
					<td>제조(수입) 업체명</td>
					<th>${com}</th>
				</tr>
				<tr>
					<td>허가일자</td>
					<th>${date}</th>
				</tr>
				<tr>
					<td>첨가제</td>
					<th>${insurance}</th>
				</tr>
			</table>
			<hr>
		</div>
		</div>
		</div>



		<div class="result">
			<div id='appear'>
				<h1>외형정보</h1>
				<br>
				<h3>${appear}</h3>
				<br>
			</div>
			<div id='ingredient'>
				<h1>성분정보</h1>
				<br>
				<h3>${ingredient.replace(";","<br>").replace("|단위 : 밀리그램|규격 : KP|성분정보 : |비고 :","	")}</h3>
				<br>
			</div>
			<div id='keep'>
				<h1>보관방법</h1>
				<br>
				<h3>${keep}</h3>
				<br>
			</div>
			<div id='valid'>
				<h1>유효기간</h1>
				<br>
				<h3>${valid}</h3>
				<br>
			</div>
			<div id='effect'>
				<h1>효능효과</h1>
				<br>
				<h3>${effect}</h3>
				<br>
			</div>
			<div id='eat'>
				<h1>용법용량</h1>
				<br>
				<h3>${eat}</h3>
				<br>
			</div>
			<div id='caution'>
				<h1>사용상 주의사항</h1>
				<br>
				<h3>${caution.replace(".","<br>")}</h3>
				<br>
			</div>
		</div>
	</div>
	<script>

		//??
		/* sum = "<div class='1'><table>"
			+"<tr><td>데이터</td></tr></table></div>" */
		
				
		
		
		
		//약 사진 추출하는 함수
		var code = $('#drugcode').val();
		drug_image(code);

		var imgUrl;

		function drug_image(code) {
			$.ajax({
				url : 'data/image',
				data : {
					code : code
				},
				dataType : "json",
				success : function(data) {
					drug_url($(data.item));
				},
				error : function(req, text) {
					alert("실패ㅠㅠ" + text + ':' + req.status);
				}
			});
		}
		
		//이미지url가져오기
			var tag = "";
		function drug_url(data) {
			//테이블표시
			data.each(function() {
				if (this.ITEM_IMAGE != null) {
					//alert("사진이 있는 의약품입니다.");
					tag = this.ITEM_IMAGE;
				}
			});

			$('#drugImg').attr("src", tag);

			//사진이 존재하지 않을 때
			if(tag == ""){
				//	alert("사진은 없당께");
				//	alert("사진없음");
					var sum ="<div class='summary-no'><hr/><table><tr><td>구분</td><th>"+"${kind}"+"</th></tr><tr><td>제조(수입) 업체명</td><th>"+"${com}"+"</th></tr><tr><td>허가일자</td><th>"+"${date}"+"</th></tr><tr><td>첨가제</td><th>"+"${insurance}"+"</th></tr></table><hr></div>"
					//alert("사진없음+1");
					$('.summary-container').html(sum);
					$('.summary-container').width('100%');
					$('.photo-container').height(0);
					
			}else{
				//alert("사진있어욥");
				//var sum =
			}
		}

		setTimeout(function(){
			//alert("3초지남");
			//주의사항 높이에 따라 div컨텐츠 변경
				var changeHei = $("#caution").height();
			//	alert("주의사항 높이"+changeHei);
				//alert("콘텐츠 높이"+$("#content").height());
				$("#content").height(changeHei+1200);
			}, 100);

		
	</script>
</body>
</html>