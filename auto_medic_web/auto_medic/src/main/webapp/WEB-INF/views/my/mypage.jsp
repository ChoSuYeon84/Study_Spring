<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %>   
<!DOCTYPE html>
<html>
<head>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.myInfo-img {
		width: 150px;
		height: 150px;
		-webkit-border-radius:75px;
		/* float: left; */
		margin: 5px;
		style:border-radius:50%
	}
#mytable{
 
 border-collapse: collapse;
 margin: 100px auto;
 overflow: hidden; 
 
}
input[class='chk'] {width:calc(100% - 14px)}
.xx{
padding:5px;

}
#box{
   width: 100px; height:30px;   
   background:#029cd4;
   color: white; 
   box-sizing: content-box;	
   line-height:30px;
   position: relative;
   left: 40px;
   top:10px;
  
}
#nick_chk{
   width: 120px; height:30px;   
   background:#029cd4;
   color: white; 
   padding:7px;
   line-height:30px;
   text-align: center;
   position: relative;
   left: 25px;
   top:35px;
  
}

#delete{
 position: relative;
   left:55px;
   top:-15px;
}
#attach-file, #delete-file{
display: none;
}

a:hover {cursor: pointer;}

.valid, .invalid{ font-size:14px; font-weight: bold;}
.valid{ color:green}
.invalid{ color:red}
</style>
<script type="text/javascript" src="js/no_back.js?v=<%=new java.util.Date().getTime()%>"></script>
</head>
<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">



<form action='update.my' method="post" enctype='multipart/form-data'>
<input type="hidden" value="${vo.member_profile}"  id='attachchk'>
<input type='hidden' name='member_email' value='${vo.member_email }'/>
<input type="hidden" value="${vo.member_profile}" name='attach'>
<table id="mytable" border="1">  
 <tr>
   <th rowspan="2" style="width: 180px; height: 250px;">
       <c:if test="${empty vo.member_profile}">
           <img src='img/default_profile.jpg' class="myInfo-img" id="preview-img" name="${vo.member_profile}"/> 
       </c:if>
       <c:if test="${!empty vo.member_profile}">        
           <span id="preview"></span>
       </c:if>
     
      <label><input type="file" name="file" id="attach-file"/>
      <a><div id="box">수정하기</div></a></label>
           <a><span id='delete' style=' margin-left:20px;'>
				<i class="fas fa-times font-img" ></i></span></a>
   </th>
   <th>닉네임</th>
 </tr>
 <tr>   
   <td class="xx">
       <input type="text" value="${vo.member_nickname}"
       class="chk" name="member_nickname">
       <div class='valid'>한글로 입력해주세요.</div> 
       <a id="nick_chk" onclick="nick_check()" class="unchk">닉네임중복확인</a>
    </td> 
 </tr>
 <tr>
   <th height="30px" colspan="2" >
     
       <button onclick="go_join(event)" class="chk" >수정하기</button>&nbsp;&nbsp;&nbsp;&nbsp;
       <button onclick="$('form').attr('action','/automedic/navigation.my'); $('form').submit();" >목록페이지로</button>&nbsp;&nbsp;&nbsp;&nbsp;
   </th>
  </tr>   
</table>
</form>
</body>
<script type="text/javascript" src="js/file_attach.js"></script>
<script type="text/javascript" src="js/join_check.js?v=<%=new java.util.Date().getTime()%>"></script>
<script type="text/javascript">
 /* function modify(){
	if(necessary()){
		if($("[name=attach]").val()!=''){
	         $("[name=attach]").val($("#attachchk").val());
		}
	     $("form").submit();
	     
	}
}  */

//저장된 프로필 부르기
if(${!empty vo.member_profile}){
	showAttachImage('#preview');
}

function showAttachImage(id){	
	//첨부된 파일이 이미지인 경우 보여지게
	var member_profile='${vo.member_profile}';
	// ().jpg →jpg만 보임
	var ext=member_profile.substring(member_profile.lastIndexOf('.')+1)
	       .toLowerCase();
	var imgs=['gif','jpg','jpeg','bmp','png'];
	if(imgs.indexOf(ext)>-1){
	//이형태 filepath, file-img는 따로 빼야 하지만 이것도 문자여서 ''붙임
    var img='<img src="'+'${vo.member_profile}'.substring(1) + '"'
         +' id="preview-img" class="myInfo-img" >';   
     // '/'는 빠짐
     $(id).html(img);   
	}
}
//선택한 이미지 지우기
$('#delete').on('click',function(){	
	$("#preview-img").attr("src", "img/default_profile.jpg");
	$("[name=attach]").val('');
});

//선택한 이미지 부르기
$('#attach-file').on('change',function(){
    var attach =this.files[0];
    if(attach){
  	  if(isImage(attach.name)){
      	  var img='<img id="preview-img" class="myInfo-img" '           	
          	 + ' src=""  name="${vo.member_profile}">';
       	

       	 var reader=new FileReader();
       	 reader.onload=function(e){
                 $('#preview-img').attr('src', e.target.result);
           }
           reader.readAsDataURL(attach);
  	  }else  $('#preview').html('');
    }

	
});

function isImage(filename){
//	ab.txt,abc.png, ab.hwp..
   var ext=filename.substring(filename.lastIndexOf('.')+1).toLowerCase();
console.log(ext)
  var imgs=['png','jpg','jpeg','gif','bmp'];
  if(imgs.indexOf(ext) > -1) return true;
  else return false;
}

//닉네임 체크
 function nick_check(){
	var $nickname =  $('[name=member_nickname]')
	if( $nickname.hasClass( 'chked' )) return;
	console.log('el => '+$('[name=member_nickname]').val())
	console.log('go check')	
	var data = join.tag_status( $nickname);
	console.log('data의 값 => '+data)	
	if( data.code != 'valid'){
		alert(data.desc);
		$nickname.focus();
		return;
	}

	 $.ajax({
        type:'post',
        url:'nickname_check',
        data: {member_nickname:$nickname.val()},
        success: function(data){
            data=join.member_nickname_usable(data);
            display_status( $nickname.siblings('div'), data);
            $nickname.addClass('chked');
        },error: function(req, text){
            alert(text+':'+req.status);           
        }     

	}); 

 }
function go_join(event){
	if($("[name=attach]").val()!=''){
		 $("[name=attach]").val($("#attachchk").val());
	}

	//중복확인한 경우
	if($('[name=member_nickname]').hasClass('chked')){
		//이미사용중인 경우는 수정 불가
		if($('[name=member_nickname]').siblings('div').hasClass('invalid')){
			alert('수정 불가합니다\n'+join.id.unusable.desc);
			$('[name=member_nickname]').focus();
			return;
		}
	}else{
	   //중복확인하지 않은 경우
	   if(!item_check($('[name=member_nickname]'))){
		   //실패 시 이벤트 막음
		   event.preventDefault(); 
		  
	   }else{
		   
			     $("form").submit();
			     
			  
	           
	   }
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
    if($(this).attr('name')=='member_nickname'){
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