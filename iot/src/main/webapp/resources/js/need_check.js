/**
 * 입력항목에 입력되어있는지 여부를 반환하는 함수 
 */
function necessary(){
	var need = true;
	$('.need').each(function(){
		if( $(this).val()=='') {
			alert( $(this).attr('title')+' 입력하세요!' );
			$(this).focus();
			need = false;
			return false;
			return need;
		}
	});
	return need;
}

$('[name=title]').on('keypress', function(e){
	if(e.keyCode==13){
		if( necessary() ) $('form').submit();
		else return false;
	}
});