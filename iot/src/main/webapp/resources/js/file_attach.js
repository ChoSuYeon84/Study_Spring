/**
 * 첨부파일 관련 처리
 */
 
 /*파일을 선택했을때 파일명이 보이게 처리*/
 $('#attach-file').on('change', function(){ //input 파일 태그가 가지고 있는 값이 변경되면
 	$('#file-name').text( this.files[0].name ); //파일 이름을 보여주고
 	$('#delete-file').css('display', 'inline');	//x표시도 보여준다
 });
 /*선택된 첨부파일을 삭제하고 첨부하지 않는 형태로 처리*/
 $('#delete-file').on('click', function(){
 	$('#file-name').text('');	//파일 이름도 없애고
 	$('#delete-file').css('display', 'none'); 	//x표시도 없애고
 	$('#attach-file').val('');	//input 파일 태그가 가지고 있는 값도 없앤다
 });