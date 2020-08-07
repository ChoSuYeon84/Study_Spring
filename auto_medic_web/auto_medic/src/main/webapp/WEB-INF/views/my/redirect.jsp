<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form method="post" action="${url}">
<input type="text" name="member_email" value='${member_email}'/>

</form>
<script>
$('form').submit();
</script>