<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:forEach items="${list}" var="vo" varStatus="status">
${status.index eq 0? '<hr>' : '' }
<div> ${vo.name }[${vo.writedate }]
	<div>
	${vo.content }
	</div>
</div>
<hr>
</c:forEach>