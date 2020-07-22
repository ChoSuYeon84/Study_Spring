<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>방명록 글쓰기</h3>
<form action="insert.bo" method="post" enctype="multipart/form-data">
<table>
<tr><th class="w-px160">제목</th>
	<td><input title="제목" type="text" name="title" class="need"></td>
</tr>
<tr><th>작성자</th>
	<td>${login_info.name }</td>
</tr>
<tr><th>내용</th>
	<td><textarea title="내용" name="content" class="need"></textarea> </td>
</tr>
<tr><th>첨부파일</th>
	<td class="left">
		<label>
		<input type="file" name="file" id="attach-file"/>
		<img src="img/select.png" class="file-img"/>
		</label>
		<span id="file-name"></span>
		<span id="preview"></span>
		<span id="delete-file" style="color:red; margin-left: 15px">
			<i class='fas fa-times font-img' ></i>
		</span>
	</td>
</tr>
</table>
</form>
<div class="btnSet">
<a class="btn-fill" onclick="if( necessary() ){ $('form').submit() }">저장</a>
<a class="btn-empty" href="list.bo">취소</a>
</div>
<script type="text/javascript">
$('#delete-file').on('click', function(){
	$('#preview').html('');
});

$('#attach-file').on('change', function(){
	var attach = this.files[0];
	if ( attach ){
		if ( isImage(attach.name) ){
			var img = '<img id="preview-img" class="file-img" src="" style="border-radius: 50%"  />';
			$('#preview').html(img);

			var reader = new FileReader();
			reader.onload = function(e){
				$('#preview-img').attr('src', e.target.result); // html태그 중 id 가 preview-img 인 태그에 src 속성 값을 읽은 파일로 변경 ( src = "파일에서 읽은 값 즉 파일")
			}
			reader.readAsDataURL(attach);
		} else $('#preview').html('');

	}
});
function isImage(filename){
//	ab.txt, abc.png, ab.hwp, ...
	var ext = filename.substring( filename.lastIndexOf('.')+1 ).toLowerCase(); /* 확장자 자르기 */
	var imgs = ['png', 'jpg', 'jpeg', 'gif', 'bmp'];
	if( imgs.indexOf(ext) >-1 ) return true;	//imgs 배열안에 값이 있다면 (-1보다 값이 크다면)
	else return false;	//imgs 배열안에 값이 없다면 (-1이라면)
}
</script>
<script type="text/javascript" src="js/file_attach.js"></script>
<script type="text/javascript" src="js/need_check.js?v=<%=new java.util.Date().getTime()%>"></script>
</body>
</html>