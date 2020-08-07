<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

#mytable{
 
 border-collapse: collapse;
 margin: 100px auto;
 overflow: hidden; 
 
}

.xx{
padding:5px;

}
.valid, .invalid{ font-size:14px; font-weight: bold;}
.valid{ color:green}
.invalid{ color:red}
input[class='chk'] {width:calc(100% - 14px)}

</style>
</head>
<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">
<form action='update2.my' method="post" >
<input type='hidden' name='member_email' value='${vo.member_email }'/>	
<input type='hidden' name='member_phonenum' value='${vo.member_phonenum }'/>	
	

<table id="mytable" border="1" >  
 <tr>
   <th class="xx">비밀번호</th>   
   <td class="xx">
   <input type="password" value="${vo.member_password}"
    class="chk" name="member_password">
   <div class='valid'>비밀번호를 입력하세요(영문대/소문자, 숫자를 모두 포함)</div></td> 
 </tr>
 <tr>
   <th class="xx">비밀번호확인</th>   
   <td class="xx">
   <input type="password" class="chk" name='pw_ck'>
   <div class='valid'>비밀번호를 다시 입력하세요</div></td> 
 </tr>
 <tr>
   <th height="30px" colspan="2" >
     
       <button onclick="go_join(event)">수정하기</button>&nbsp;&nbsp;&nbsp;&nbsp;
       <button onclick="$('form').attr('action','/automedic/navigation.my'); $('form').submit();" >목록페이지로</button>&nbsp;&nbsp;&nbsp;&nbsp;          
   </th>
  </tr>   
</table>
</form>
</body>
<script type="text/javascript" src="js/need_check.js?v=<%=new java.util.Date().getTime()%>"></script>
<script type="text/javascript" src="js/join_check.js?v=<%=new java.util.Date().getTime()%>"></script>
<script type="text/javascript" src="js/no_back.js?v=<%=new java.util.Date().getTime()%>"></script>
<script type="text/javascript">
function go_join(event){
	//중복확인하지 않은 경우
	if(!item_check($('[name=member_password]'))){
		//실패 시 이벤트 막음
		event.preventDefault(); return;
	}else if(!item_check($('[name=pw_ck]'))){
		//실패 시 이벤트 막음
		event.preventDefault(); return;
	}
	 $('form').submit(); 
	
}
function item_check(item){
  var data=join.tag_status(item);
  if(data.code=='invalid'){
	    alert('수정불가합니다\n'+data.desc);
		item.val("");
	    item.focus();
	    return false;
	}else return true; 	
}

$('.chk').on('keyup', function(){
    if($(this).attr('name')=='member_password' ||$(this).attr('name')=='pw_ck' ){
        if(event.keyCode==13){ item_check();} //13번코드:엔터
        else{
 	      $(this).removeClass('chked');
 	      validate( $(this));
        }  
    }else validate( $(this));
	});
 function validate(t){
 //판단할 수 있음 
    var data = join.tag_status(t);
    
    display_status( t.siblings('div'), data );
 }
 function display_status(div, data){
    div.text( data.desc);
    div.removeClass();
    div.addClass(data.code);  

 }	


</script>
</html>