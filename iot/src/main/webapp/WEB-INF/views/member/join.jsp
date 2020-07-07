<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
table tr td{text-align: left}
table tr td input[name=tel] {width: 40px;}
table tr td input[name=addr] {width: calc(100% - 14px);}
.ui-datepicker select { vertical-align: middle; height: 28px;}
.valid, .invalid {font-size: 12px; font-weight: bold;}
.valid {color : green}
.invalid {color : red}
</style>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> <!--  생년월일 선택을 위해  https://jqueryui.com/ 에서 달력css 코드 가져옴 -->
</head>
<body>
<%-- <jsp:include page="/WEB-INF/views/include/header.jsp"/> --%>
<!-- <div id='content'> -->
<h3>회원가입</h3>
<p class="w-pct60 right" style="margin: 0 auto; padding-bottom: 5px; font-size: 13px">*는 필수입력항목입니다.</p>
<form>
<table class="w-pct60">
<tr><th class="w-px160">* 성명</th>
	<td><input type="text" name="name"/></td>
</tr>
<tr><th>* 아이디</th>
	<td><input class="chk" type="text" name="id"/><br/>
		<div class="valid">아이디를 입력하세요(영문소문자, 숫자만 입력 가능)</div>
	</td>
</tr>
<tr><th>* 비밀번호</th>
	<td><input class="chk" type="password" name="pw"/><br/>
		<div class="valid">비밀번호를 입력하세요(영문대/소문자, 숫자를 모두 포함)</div>
	</td>
</tr>
<tr><th>* 비밀번호확인</th>
	<td><input class="chk" type="password" name="pw_ck"/><br/>
		<div class="valid">비밀번호를 다시 입력하세요</div>
	</td>
</tr>
<tr><th>* 성별</th>
	<td><label><input type="radio" name="gender" value="남"/>남</label>
		<label><input type="radio" name="gender" value="여" checked="checked"/>여</label>
	</td>
</tr>
<tr><th>* 이메일</th>
	<td><input class="chk" type="text" name="email"/><br/>
		<div class="valid">이메일을 입력하세요</div>
	</td>
</tr>
<tr><th>생년월일</th>
	<td><input type="text" name="birth" readonly="readonly"/>
		<span id="delete" style="color:red; position: relative; right: 25px; display: none; "><i class="fas fa-times font-img"></i></span>
	</td> <!-- 구글에서 font awesome검색하여  x버튼 추가할것--> 
</tr>
<tr><th>연락처</th>
	<td><input type="text" name="tel"/>
		- <input type="text" name="tel"/>
		- <input type="text" name="tel"/>
	</td>
</tr>
<tr><th>주소</th>
	<td><a class="btn-fill-s" onclick="daum_post()">우편번호찾기</a>
		<input type="text" name="post" class="w-px60" readonly="readonly"/>
		<input type="text" name="addr" readonly="readonly"/>
		<input type="text" name="addr"/>
	</td>
</tr>
</table>


</form>
<script src="js/join_check.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.1/js/all.min.js"></script><!-- https://cdnjs.com/ 에서 fontawesome을 쳐서 복사해옴 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>	<!-- 주소라이브러리를 받아서 온다 -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> <!--  생년월일 선택을 위해  https://jqueryui.com/ 에서 달력라이브러리 가져옴 -->
<script type="text/javascript">
$('.chk').on('keyup', function(){
	validate( $(this));
});
function validate(t){
	var data = join.tag_status(t);
	//console.log(data);
	display_status (t.siblings('div'), data);
}
function display_status(div, data){
	div.text( data.desc );
	div.addClass( data.code );
}

//만13세 이상만 선택이 가능하게 처리
var today = new Date();
var endDay = new Date(today.getFullYear()-13, today.getMonth(), today.getDate()-1);	//만으로 표현하기위해 2007년 7월7일 -1 해서 7월 6일까지

$('[name=birth]').change(function(){
	$('#delete').css('display', 'inline-block');
});
$('#delete').click(function(){
	$('[name=birth]').val('');
	$('#delete').css('display', 'none');
});



$('[name=birth]').datepicker({
	dateFormat : 'yy-mm-dd',
	changeYear : true,
	changeMonth : true,
	showMonthAfterYear: true,
	dayNamesMin:['일', '월', '화', '수', '목', '금', '토'],
	monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
//	beforeShowDay : after, //오늘날짜까지만 선택하도록 함 (미래의 시간은 선택 못하도록)
	maxDate: endDay,	//13세 이상만 선택가능하도록
});



function after(date){
	if( date > new Date()){
		return [false];
	} else {
		return [true];
	}
}


function daum_post(){
	 new daum.Postcode({
	        oncomplete: function(data) {
		        $('[name=post]').val(data.zonecode);	//우편번호
		        
	         	//지번주소(구주소): J, 도로명주소   : R
	         	var address = data.userSelectedType == 'J' ? data.jibunAddress : data.roadAddress;
	         	if(data.buildingName != '') {
		         	address += '('+data.buildingName+')';
	         	}
	         	$('[name=addr]').eq(0).val(address);
	        }
	    }).open();
}

</script>

<!-- </div> -->
<%-- <jsp:include page="/WEB-INF/views/include/footer.jsp"/> --%>
</body>
</html>