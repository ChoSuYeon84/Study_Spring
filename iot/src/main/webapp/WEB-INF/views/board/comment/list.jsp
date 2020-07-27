<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:forEach items="${list}" var="vo" varStatus="status">
${status.index eq 0? '<hr>' : '' }
<div data-id='${vo.id }'> ${vo.name }[${vo.writedate }]
	<c:if test="${login_info.id eq vo.writer }"><!-- 로그인한 사용자가 작성한 댓글 수정/삭제 가능 -->
	<span style="float:right;">
		<a class="btn-fill-s btn-modify-save">수정</a>
		<a class="btn-fill-s btn-delete-cancel">삭제</a>
	</span>
	</c:if>
	<div class='original'>${fn:replace( fn:replace(vo.content, lf, '<br>'), crlf, '<br>') }</div>
	<div class="modify" style="display: none; margin-top: 6px;"></div>
</div>
<hr>
</c:forEach>
<script>
/* $('.original').each(function(){
	$(this).text(
			$(this).text().replace(/</g, '&lt;').replace(/>/g, '&gt;'));
}); */
$('.btn-modify-save').on('click', function(){
	//수정/저장
	var $div = $(this).closest('div'); /* 가장가까운 div를 찾아라 */
	if( $(this).text()=='수정' ){
		$div.children('.modify').css('height', $div.children('.original').height()-6);
		var tag = '<textarea style="width:99%; height:90%; resize:none">'+$div.children('.original').html().replace(/<br>/g, '\n')+'</textarea>'/*  /<br>/g, '\n'->전체문자에서 br을 찾아 뉴라인으로 바꾸겠음 */
		$div.children('.modify').html(tag);
		display($div, 'm');
	}else{
		var comment = {id : $div.data('id'), content: $div.children('.modify').find('textarea').val() };
		//alert( JSON.stringify(comment) );
		$.ajax({
			url : 'board/comment/update',
			data : JSON.stringify(comment),
			contentType: 'application/json', 
			type : 'post',
			success : function(data){
				alert(data);
				comment_list();
			}, error: function(req, text){
				alert(text+':'+req.status);
			}
			
			
		});
		
	}
});
$('.btn-delete-cancel').on('click', function(){
	//삭제/취소
	var $div = $(this).closest('div');
	if( $(this).text()=='취소' ){
		display($div, 'd');
	}else{
		if( confirm('정말 삭제?')){
			$.ajax({
				url: 'board/comment/delete/'+$div.data('id'),
				success: function(){
					comment_list();
				}, error:function(req, text){
					alert(text+':'+req.status);
				}
			});
		}
	}
	
});
function display(div, mode){
	// 수정상태(m) : 저장/취소, 원글 안보이고, 수정글은 보이고
	// 보기상태(d) : 수정/삭제, 원글 보이고, 수정글은 안보이고
	div.find('.btn-modify-save').text(mode=='m' ? '저장' : '수정');
	div.find('.btn-delete-cancel').text(mode=='m' ? '취소' : '삭제');
	div.children('.original').css('display', mode=='m' ? 'none' : 'block');
	div.children('.modify').css('display', mode=='m' ? 'block' : 'none');
}
</script>