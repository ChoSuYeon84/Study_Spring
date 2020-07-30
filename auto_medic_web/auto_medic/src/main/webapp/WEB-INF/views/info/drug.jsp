<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<Style>
.content {
	background-color: yellow;
	height: 700px;
}

#result {
	width: 100%;
	background-color: blue;
	height: 500px;
}

.left {
	background-color: blue;
	height: 100px;
}

.right {
	background-color: pink;
	height: 600px;
}

.type {
	float: right;
}
</Style>
</head>
<body>

	<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
	<div class="container">
		<div class="row content">
			<div class="col-sm-12">
				<div class="left">
					<form id='list' method='post' action='list.bo'>
<input type='hidden' name='curPage' value='1'/>
<input type='hidden' name='id' />
<div id='list-top'>
<div>
	<ul>
		<li>
		<select name='search' class='w-px80'>
			<option ${page.search eq 'all' ? 'selected' : ''} value='all'>전체</option>
			<option ${page.search eq 'title' ? 'selected' : ''} value='title'>제목</option>
			<option ${page.search eq 'content' ? 'selected' : ''} value='content'>내용</option>
			<option ${page.search eq 'writer' ? 'selected' : ''} value='writer'>작성자</option>
		</select>
		</li>
		<li><input type='text' name='keyword' value='${page.keyword}'
					class='w-px300'/>
		</li>
		<li><a class='btn-fill' onclick='$("form").submit()'>검색</a>
		</li>
	</ul>

	<ul>
	<li>
		<select name='pageList'  class='w-px80'
				onchange='$("[name=curPage]").val(1); $("form").submit()' >
				
			<option ${page.pageList eq 10 ? 'selected' : ''} value='10'>10개씩</option>
			<option ${page.pageList eq 20 ? 'selected' : ''} value='20'>20개씩</option>
			<option ${page.pageList eq 30 ? 'selected' : ''} value='30'>30개씩</option>
		</select>
		
	</li>
	<li>
		<select name='viewType' class='w-px100' 
				onchange='$("form").submit()'>
			<option ${page.viewType eq 'list' ? 'selected' : ''} value='list'>리스트형태</option>
			<option ${page.viewType eq 'grid' ? 'selected' : ''} value='grid'>바둑판형태</option>
		</select>
	</li>
	<c:if test="${!empty login_info}"> <!-- 로그인되어 있으면 글쓰기 가능 -->
		<li><a class='btn-fill' href='new.bo'>글쓰기</a></li>
	</c:if>
	</ul>
</div>
</div>
</form>

				</div>
				<div class="right">
					<div id='data-list'>
						<c:if test="${page.viewType eq 'list'}">
							<table>
								<tr>
									<th class='w-px60'>번호</th>
									<th>제목</th>
									<th class='w-px100'>작성자</th>
									<th class='w-px120'>작성일자</th>
									<th class='w-px60'>첨부파일</th>
								</tr>
								<c:forEach items="${page.list}" var="vo">
									<tr>
										<td>${vo.no}</td>
										<td class='left'><a onclick='go_detail(${vo.id})'>${vo.title}</a></td>
										<td>${vo.name}</td>
										<td>${vo.writedate}</td>
										<td><c:if test="${!empty vo.filename}">
												<img src="img/attach.png" class='file-img' />
											</c:if></td>
									</tr>
								</c:forEach>
							</table>
						</c:if>

						<c:if test="${page.viewType eq 'grid'}">
							<ul class='grid'>
								<c:forEach items="${page.list}" var="vo">
									<li><div>
											<a onclick='go_detail(${vo.id})'>${vo.title}</a>
										</div>
										<div>${vo.name}</div>
										<div>${vo.writedate}
											<span>${empty vo.filename ? '' : '<img src="img/attach.png" class="file-img" />'}</span>
										</div></li>
								</c:forEach>
							</ul>
						</c:if>

					</div>
				</div>

			</div>
		</div>
	</div>
<body>

	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</body>

</html>