<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
table td{ word-break : break-all}
#popup {
	width: 350px; height: 350px;
	position: absolute; left: 50%; top: 50%; transform: translate(-50%, -50%);
	border: 3px solid #666; border-radius : 100%;
	z-index: 999999999; display: none;
}
#popup-background {
	position: absolute; left: 0; top: 0;
	width: 100%; height: 100%;
	background-color: #000;
	opacity: 0.3; display: none;
	
}
.popup{ width: 100%; height: 100%;}
#comment_regist span {width: 50%; float: left;}
</style>
</head>
<body>
<h3>방명록 상세</h3>
<table>
<tr><th class="w-px160">제목</th><td colspan="5" class="left">${vo.title }</td>
</tr>
<tr><th>작성자</th><td>${vo.name }</td>
	<th class="w-px100">작성일자</th><td class="w-px100">${vo.writedate }</td>
	<th class="w-px80">조회수</th><td class="w-px60">${vo.readcnt }</td>
</tr>
<tr><th>내용</th>
	<td colspan='5' class="left">${fn:replace(vo.content, crlf, '<br>') }</td>
</tr>
<tr><th>첨부파일</th>
	<td colspan="5" class="left"><c:if test="${!empty vo.filename }">
		${vo.filename }
		<span id="preview"></span>
		<a href="download.bo?id=${vo.id }"><i class="fas fa-download font-img"></i></a>
		</c:if>
	</td>
</tr>
</table>
<div class="btnSet">
<a class="btn-fill" onclick="go_list()">목록으로</a>
<c:if test="${login_info.admin eq 'y' or login_info.id eq vo.writer }"> <!-- 관리자나 작성자로 로그인한 경우만 수정/삭제 가능 -->
<a class="btn-fill" onclick="$('form').attr('action', 'modify.bo'); $('form').submit()">수정</a>
<a class="btn-fill" onclick='if( confirm("정말 삭제?")){ $("form").attr("action", "delete.bo"); $("form").submit()  }'>삭제</a>
</c:if>
</div>

<div style="margin: 0 auto; padding-top: 20px; width: 500px;">
	<div id="comment_regist">
		<span class="left">댓글작성</span>
		<span class="right"><a class="btn-fill-s" onclick="comment_regist()">등록</a></span>
		<textarea id='comment' style="width: 99%; height: 60px; margin-top: 5px; resize: none;"></textarea>
	</div>
	<div id='comment_list' style="text-align: left"></div>
</div>
<form method="post" action="list.bo">
<input type="hidden" name="id" value="${vo.id }"/>
<input type="hidden" name="curPage" value="${page.curPage }"/>
<input type="hidden" name="search" value="${page.search }"/>
<input type="hidden" name="keyword" value="${page.keyword }"/>
<input type="hidden" name="viewType" value="${page.viewType }"/>
<input type="hidden" name="pageList" value="${page.pageList }"/>
</form>
<div id='popup'></div>
<div id='popup-background' onclick="$('#popup, #popup-background').css('display', 'none');"></div>
<script type="text/javascript">
function comment_regist(){
	if( ${empty login_info} ){
		alert('댓글을 등록하려면 로그인 하세요!');
		return;
	}
	if( $('comment').val()==''){
		alert('댓글을 입력하세요!')
		$('comment').focus();
		return;
	}

	$.ajax({
		url: 'board/comment/insert',
		data: { pid: ${vo.id}, content:$('#comment').val()},	//원글의 아이디가 필요 pid: ${vo.id}
		success: function(data){//여기서 data는 파라메터 변수임
			if(data){
				$("#comment").val('');
				comment_list();
			}

		}, error : function(req, text){
			alert(text+':'+req.status)
		}
	});
}

function comment_list(){
	$.ajax({
		url : 'board/comment/${vo.id}', 
		success: function(data){	//문자로 되어있는 데이터의 결과를
			$('#comment_list').html(data);

		}, error : function(req, text){
			alert(text+':'+req.status)
		}
	});
}


if( ${ !empty vo.filename}){
	showAttachImge('#preview');
}

function showAttachImge( id ){
	//첨부된 파일이 이미지인 경우 보여지게
	var filename = '${vo.filename}';
	var ext = filename.substring( filename.lastIndexOf('.')+1 ).toLowerCase();
	var imgs = [ 'gif', 'jpg', 'jpeg', 'bmp', 'png'];
	if (imgs.indexOf(ext) > -1 ){
		var img = "<img src='"+ "${vo.filepath}".substring(1)+"' id = 'preview-img' class='"+(id=='#popup' ? 'popup' : 'file-img')+"' style='border-radius: 50%'/>";
		$(id).html(img);
	}
}

//이미지를 클릭했을때 이미지를 크게 보이게 하려는부분
$('#preview-img').click(function(){
	$('#popup, #popup-background').css('display', 'block');
	showAttachImge('#popup')
	
});

function go_list(){
	$('form').submit();
}

comment_list();
</script>
</body>
</html>