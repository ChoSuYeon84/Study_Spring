<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%-- <link rel = "stylesheet" type="text/css" href="css/common.css?v=<%= new Date().getTime()%>">  --%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
var color=["blue","violet","cyan","yellow","pink"];
</script>
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
 margin: 0 auto;
 overflow: hidden; 
 height: 300px;
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
   top: 100px;
   left: 100px;
}
#attach-file, #delete-file{
display: none;
}
</style>

</head>
<body>




<div>
<br/>
<table id="mytable" border="1"> 
 <tr height=50px >
   <th>이메일</th> 
   <td class="xx">${vo.member_email}</td> 
   <th width="180px">이메일 수신여부</th> 
   <td width="130px">
    <!--  name:하나만 선택되게 함   -->
     &nbsp;&nbsp;<label><input checked type="radio" name="email" value="예">예 </label>
   <label><input type="radio"  name="email" value="아니오">아니오</label>
   </td> 
 </tr>
 <tr height=50px>  
   <th width="170px">닉네임</th> 
   <td class="xx"><input type="text" value="${vo.member_nickname}" ></td> 
   
   <th rowspan='4' colspan='2' style="vertical-align:middle">
        <!--  <img src='img/default_profile.jpg' class="myInfo-img"/> -->
      <span id="preview"></span>  
      <label><input type="file" name="file" id="attach-file"/>
      <div id="box">수정하기</div></label><br/><br/> 
      <!-- <span id='file-name'></span>
				<span id='delete-file' style='color:red; margin-left:20px;'>
				<i class="fas fa-times font-img"></i> --></span>     
   </th> 
 </tr> 
 
 <tr height=50px>
   <th>비밀번호</th> 
   <td class="xx"><input type="password" value="${vo.member_password}"></td> 
 </tr>
 <tr height=50px>
   <th>비밀번호확인</th> 
   <td class="xx"><input type="password" value=""></td> 
 </tr>
 <tr height=50px>
   <th>전화번호</th> 
   <td class="xx"><input type="text" value="${vo.member_phonenum}"></td> 
 </tr>
 <tr>
   <th colspan='4' height=80px >
       <button>수정하기</button>&nbsp;&nbsp;&nbsp;&nbsp;
       <button>홈으로</button>&nbsp;&nbsp;&nbsp;&nbsp;
       <button>삭제하기</button>
   </th>
 </tr>
</table>



</div>

</body>
<script type="text/javascript" src="js/file_attach.js"></script>
<script type="text/javascript">

if(${!empty vo.member_profile}){ //id가 '#preview'대신에 들어감
	//첨부된 파일이 이미지인 경우 보여지게
	showAttachImage('#preview');
}
showAttachImage(id){
	 var member_profile='${vo.member_profile}';
	 // .jpg
	var ext=member_profile.substring(member_profile.lastIndexof('.')+1)
	.toLowerCase();
	var imgs=['gif','jpg','jpeg','bmp','png'];
	if(imgs.indexof(ext)>-1){
	   //이형태 filepath, file-img는 따로 빼야 하지만 이것도 문자여서 ''붙임
        var img= '<img src="img'+'${vo.member_profile}'.lastIndexOf('/')+'" '  // 
          +' class="myInfo-img"/>'; 
       var img= '<img src="img/default_profile.jpg" class="myInfo-img"/>'; 
       $(id).html(img);
	} 
	
}



</script>
</html>