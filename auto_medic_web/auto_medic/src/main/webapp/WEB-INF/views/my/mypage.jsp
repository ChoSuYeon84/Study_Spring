<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<%-- <link rel = "stylesheet" type="text/css" href="css/common.css?v=<%= new Date().getTime()%>">  --%>
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
	}
#mytable{
 
 border-collapse: collapse;
 margin: 100px auto;
 overflow: hidden; 
 
}

.xx{
padding:5px;

}
#box{
   width: 100px; height:30px;
   border:1px solid black;
   background:cyan;
   color: white; 
   box-sizing: content-box;	
   line-height:30px;
   position: relative;
   left: 40px;
   top:10px;
  
}
#delete{
 position: relative;
   left:55px;
   top:-15px;
}
#attach-file, #delete-file{
display: none;
}
</style>

</head>
<body>

<table id="mytable" border="1">  
 <tr>
   <th  rowspan="2" style="width: 180px; height: 250px;">
     <c:if test="${empty vo.member_profile}">
      <img src='img/default_profile.jpg' class="myInfo-img" id="preview-img"/> 
     </c:if>
      <!-- <span id="preview"></span>   -->
      <label><input type="file" name="file" id="attach-file"/>
      <div id="box">수정하기</div></label>
      <span id='delete' style=' margin-left:20px;'val=''>
				<i class="fas fa-times font-img"></i></span>
      <br/>
     <!--  <span id='file-name'></span>
				<span id='delete-file' style='color:red; margin-left:20px;'>
				<i class="fas fa-times font-img"></i></span> -->
   </th>
   <th>닉네임</th>
 </tr>
 <tr>   
   <td class="xx"><input type="text" value="${vo.member_nickname}" ></td> 
 </tr>
 <th height="30px" colspan="2" >
       <button>수정하기</button>&nbsp;&nbsp;&nbsp;&nbsp;
       <button>홈으로</button>&nbsp;&nbsp;&nbsp;&nbsp;      
   </th>
</table>
</body>
<script type="text/javascript" src="js/file_attach.js"></script>
<script type="text/javascript">
$('#delete').on('click',function(){
	/*  var attach =img/default_profile.jpg;
	 var img='<img id="preview-img" class="myInfo-img" '           	
      	 + ' src="img/default_profile.jpg" style="border-radius:50%">';
   	 $('#preview').change(img);

   	 var reader=new FileReader();
   	 reader.onload=function(e){
             $('#preview-img').attr('src', e.target.result);
       }
       reader.readAsDataURL(attach);
	$('#preview').val('');
	console.log('drop') */
});
$('#attach-file').on('change',function(){
    var attach =this.files[0];
    if(attach){
  	  if(isImage(attach.name)){
      	  var img='<img id="preview-img" class="myInfo-img" '           	
          	 + ' src="" style="border-radius:50%">';
       	 $('#preview').change(img);

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




</script>
</html>