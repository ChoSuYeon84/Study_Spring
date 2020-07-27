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
color: #ccc;
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
	<td><input class="chk" title='아이디' type="text" name="id"/><br/>
		<div class="valid">아이디를 입력하세요(이메일주소만 입력 가능)</div>
	</td>
</tr>
<tr>
	<td><a class='btn-fill-s' id="id_chk" onclick="id_check()">아이디중복확인</a></td>
</tr>
<tr><th>인증번호</th>
</tr>
<tr>
	<td><input type="text"/><br/>
		<div class="valid">인증번호를 입력하세요</div>
	</td>
</tr>
<tr>
	<td><a class='btn-fill-s' id="idNum_chk" onclick="idNum_chk()">인증번호확인</a></td>
</tr>
<tr><th>비밀번호</th>
</tr>
<tr>
	<td><input class="chk" title='비밀번호' type="password" name="pw"/><br/>
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
	<td><input class="chk" title='닉네임' type="text" name="nickname"/><br/>
		<div class="valid">닉네임을 입력하세요</div>
		<a class='btn-fill-s' id="nick_chk" onclick="nick_check()">닉네임중복확인</a>
	</td>
</tr>
<tr><th>연락처</th>
</tr>
<tr>
	<td><input class="chk" type="text" name="tel"/><br/>
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
	if( $('[name=id]').hasClass('chked') ){
		//이미사용중인 경우는 회원가입 불가
		if($('[name=id]').siblings('div').hasClass('invalid')){
			alert('회원가입불가\n'+join.id.unusable.desc);
			$('[name=id]').focus();
			return;
		}
	}else{
	//중복확인 하지 않은 경우
		if( !item_check( $('[name=id]') ) ) return;
		else{
			alert('회원가입불가\n'+join.id.valid.desc);
			$('[name=id]').focus();
			return;
		}
	}
	if( !item_check( $('[name=pw]') ) ) return;
	if( !item_check( $('[name=pw_ck]') ) ) return;
	if( !item_check( $('[name=nickname]') ) ) return;
	if( !item_check( $('[name=tel]') ) ) return;

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

function id_check(){
//	올바른 아이디 입력형태인지 파악하여 유효하지 않다면 중복확인 불필요
	var $id =  $('[name=id]')
	if( $id.hasClass( 'chked' )) return;
	console.log('go check')
	var data = join.tag_status( $id);
	if( data.code != 'valid'){
		alert(data.desc);
		$id.focus();
		return;
	}

	$.ajax({
		type: 'post',
		url: 'id_check',
		data: { id:$id.val() },
		success: function(data){
			data = join.id_usable(data);
			console.log(data);
			display_status( $id.siblings('div'), data );
			$id.addClass('chked');
		}, error: function(req, text){
			alert(text+': '+req.status);
		}
	});
	
}

function nick_check(){
	var $nickname =  $('[name=nickname]')
	if( $nickname.hasClass( 'chked' )) return;
	console.log('go check')
	var data = join.tag_status( $nickname);
	if( data.code != 'valid'){
		alert(data.desc);
		$nickname.focus();
		return;
	}

	$.ajax({
		type: 'post',
		url: 'nickname_check',
		data: { nickname:$nickname.val() },
		success: function(data){
			data = join.nickname_usable(data);
			console.log(data);
			display_status( $nickname.siblings('div'), data );
			$nickname.addClass('chked');
		}, error: function(req, text){
			alert(text+': '+req.status);
		}
	});
}

$('.chk').on('keyup', function(){
	if( $(this).attr('name')=='id' || $(this).attr('name')=='nickname'){
		if( event.keyCode==13){ id_check(); }
		else {
			$(this).removeClass('chked');
			validate( $(this));
		}
	}else validate( $(this));
	
	
});
function validate(t){
	var data = join.tag_status(t);
	//console.log(data);
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