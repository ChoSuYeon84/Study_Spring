<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

#mytable{
 border: 1px solid #ccc;
 border-collapse: collapse;
 margin: 100px auto;
 overflow: hidden; 
 
}

.xx{
padding:5px;

}
input[class='chk'] {width:calc(100% - 14px)}
.valid, .invalid{ font-size:14px; font-weight: bold;}
.valid{ color:green}
.invalid{ color:red}
</style>
</head>
<body  onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">
<form action='update2.my' method="post">
<input type='hidden' name='member_email' value='${vo.member_email }'/>
<input type='hidden' name='member_password' value='${vo.member_password }'/>
<input type="hidden" value="${vo.member_profile}" name='member_profile'>
<table id="mytable" border="1" >  
 <tr>
   <th class="xx">전화번호</th>   
   <td class="xx">
   <input type="tel" value='${vo.member_phonenum}'
    class="chk" title="전화번호" name="member_phonenum">
    <div class='valid'>전화번호를 입력하세요</div></td> 
 </tr>
 <tr>
   <th height="30px" colspan="2" >
     
       <button onclick='go_join(event)'>수정하기</button>&nbsp;&nbsp;&nbsp;&nbsp;           
       <button onclick="$('form').attr('action','/automedic/navigation.my'); $('form').submit();" >목록페이지로</button>&nbsp;&nbsp;&nbsp;&nbsp;
   </th>
  </tr>   
</table>
</form>
</body>


<script type="text/javascript" src="js/join_check.js?v=<%=new java.util.Date().getTime()%>"></script>
<script type="text/javascript" src="js/no_back.js?v=<%=new java.util.Date().getTime()%>"></script>
<script type="text/javascript">
function go_join(event){
	//중복확인하지 않은 경우
	if(!item_check($('[name=member_phonenum]'))){
		//실패 시 이벤트 막음
		event.preventDefault();
		return;
	}else{
	 $('form').submit(); 
	}
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
    if($(this).attr('name')=='member_phonenum'){
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