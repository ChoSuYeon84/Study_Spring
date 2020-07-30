<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AutoMedic : 회원가입</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="js/join_check.js?v=<%=new java.util.Date().getTime()%>"></script>
<link rel = "stylesheet" type="text/css" href="css/common.css?v=<%= new Date().getTime()%>"> 
<style type="text/css">
* {
	margin: 0 auto; 

}

#logo, #join_us, h3 {
	margin: 0 auto;
	display: table;
}

table th {
float: left;
}

input {
	height: 50px;
	width: 500px;
	color: black;
	font-size: 20px;
}

.btn-fill-s{
	display: block;
}

.btn-fill, .btn-fill-s{
	height: 50px;
	width: 509px;
	background-color: #ccc;
	text-align: center;
	line-height: 50px;
}

img {
	height: 215px;
	width: 500px;
}

table tr td{
	text-align: left
}

.valid, .invalid {font-size: 12px; font-weight: bold;}
.valid {color : green}
.invalid {color : red}
</style>
</head>

<body>
<a href="<c:url value='/'/>"><img src="img/logo_web.png" alt="홈으로" id="logo"></a>
<h3>회원가입</h3>
<form action="join" method="post">
<table>
<tr><th>아이디</th>
</tr>
<tr>
	<td><input class="chk" title='아이디' type="text" name="member_email"/><br/>
		<div class="valid">아이디를 입력하세요(이메일주소만 입력 가능)</div>
	</td>
</tr>
<tr>
	<td><a class='btn-fill-s' id="id_chk" onclick="id_check()">아이디중복확인</a></td>
</tr>
<tr><th>인증번호</th>
</tr>
<tr>
	<td><input type="text" name="authNo" /><br/>
		<div class="valid">인증번호를 입력하세요</div>
	</td>
</tr>
<tr>
	<td><a class='btn-fill-s' id="idNum_chk" onclick="idNum_chk()">인증번호확인</a></td>
</tr>
<tr><th>비밀번호</th>
</tr>
<tr>
	<td><input class="chk" title='비밀번호' type="password" name="member_password"/><br/>
		<div class="valid">비밀번호를 입력하세요(영문대/소문자, 숫자를 모두 포함)</div>
	</td>
</tr>
<tr><th>비밀번호 재확인</th>
</tr>
<tr>
	<td><input class="chk" title='비밀번호확인' type="password" name="pw_ck"/><br/>
		<div class="valid">비밀번호를 다시 입력하세요</div>
	</td>
</tr>
<tr><th>닉네임</th>
</tr>
<tr>
	<td><input class="chk" title='닉네임' type="text" name="member_nickname"/><br/>
		<div class="valid">닉네임을 입력하세요</div>
		<a class='btn-fill-s' id="nick_chk" onclick="nick_check()">닉네임중복확인</a>
	</td>
</tr>
<tr><th>연락처</th>
</tr>
<tr>
	<td><input class="chk" type="text" name="member_phonenum"/><br/>
		<div class="valid">연락처를 입력하세요 (-없이 숫자만 입력가능)</div>
	</td>
</tr>
</table>
</form>
<div class="btnSet">
<a class="btn-fill" id="join_us" onclick="go_join()">회원가입</a>
</div>
<br/><br/>


<script type="text/javascript">
function go_join(){
	//필수항목의 유효성을 판단하도록 한다.
	//중복확인한 경우
	if( $('[name=member_email]').hasClass('chked') ){
		//이미사용중인 경우는 회원가입 불가
		if($('[name=member_email]').siblings('div').hasClass('invalid')){
			alert('회원가입불가\n'+join.member_email.unusable.desc);
			$('[name=member_email]').focus();
			return;
		}
	}else{
	//중복확인 하지 않은 경우
		if( !item_check( $('[name=member_email]') ) ) return;
		else{
			alert('회원가입불가\n'+join.member_email.valid.desc);
			$('[name=member_email]').focus();
			return;
		}
	}

	if(!$('[name=authNo]').hasClass('chked')){
		alert('회원가입불가\n인증번호를 확인해주세요!')
		return;
	}
	
	if( !item_check( $('[name=authNo]') ) ) return;
	if( !item_check( $('[name=member_password]') ) ) return;
	if( !item_check( $('[name=pw_ck]') ) ) return;
	if( !item_check( $('[name=member_nickname]') ) ) return;
	if( !item_check( $('[name=member_phonenum]') ) ) return;

	$('form').submit();
	
}

function item_check(item){
	var data = join.tag_status(item);
	if( data.code == 'invalid' ){
		alert('회원가입불가!\n' + data.desc);
		item.focus();
		return false;
	} else return true;
}

 //인증번호확인부분
 function idNum_chk(){
	var $authNo = $('[name=authNo]');
	console.log(1, authNo);
	var data = join.tag_status( $authNo);
	$authNo.addClass('chked');	
	display_status( $authNo.siblings('div'), data );
	if( data.code != 'valid'){
		//alert(data.desc);
		$authNo.focus();
		return;
	}
}
 
function id_check(){
//	올바른 아이디 입력형태인지 파악하여 유효하지 않다면 중복확인 불필요
	var $member_email =  $('[name=member_email]')
	if( $member_email.hasClass( 'chked' )) return;
	console.log('go check id')
	var data = join.tag_status( $member_email);
	if( data.code != 'valid'){
		alert(data.desc);
		$member_email.focus();
		return;
	}

	$.ajax({
		type: 'post',
		url: 'id_check',
		data: { member_email:$member_email.val() },
		success: function(data){
			authNo = data;
			data = join.member_email_usable(data == -1 ? false : true);
			console.log(data);
			display_status( $member_email.siblings('div'), data );
			$member_email.addClass('chked');	
		}, error: function(req, text){
			alert(text+': '+req.status);
		}
	});

}
var authNo = '';

function nick_check(){
	var $member_nickname =  $('[name=member_nickname]')
	if( $member_nickname.hasClass( 'chked' )) return;
	console.log('go check nickname')
	var data = join.tag_status( $member_nickname);
	if( data.code != 'valid'){
		alert(data.desc);
		$member_nickname.focus();
		return;
	}

	$.ajax({
		type: 'post',
		url: 'nickname_check',
		data: { member_nickname:$member_nickname.val() },
		success: function(data){
			data = join.member_nickname_usable(data);
			console.log(data);
			display_status( $member_nickname.siblings('div'), data );
			$member_nickname.addClass('chked');
		}, error: function(req, text){
			alert(text+': '+req.status);
		}
	});
}

$('.chk').on('keyup', function(){
	if( $(this).attr('name')=='member_email' || $(this).attr('name')=='member_nickname'|| $(this).attr('name')=='authNo'){
		if( event.keyCode==13){ id_check(); }
		else {
			$(this).removeClass('chked');
			validate( $(this));
		}
	}else validate( $(this));
	
	
});
function validate(t){
	var data = join.tag_status(t);
	console.log(data);
	display_status (t.siblings('div'), data);
}
function display_status(div, data){
	div.text( data.desc );
	div.removeClass();
	div.addClass( data.code );
}
</script>
</body>
</html>