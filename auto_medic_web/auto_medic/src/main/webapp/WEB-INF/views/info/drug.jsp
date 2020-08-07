<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<Style>
table td {
	overflow: hidden;
	text-overflow: ellipsis;
	/* white-space: nowrap; */
}

.drug li div {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.container1 {
	width: 1200px;
	/* background-color: yellow; */
	height: 700px;
	margin: 0 auto;
}

.search {
	/* background-color: red; */
	height: 50px;
	margin-top: 50px;
}

.result {
	/* background-color: pink; */
	height: 600px;
	margin-top: 50px;
}

.drug {
	height: 500px;
}

.list-view, .grid-view {
	font-size: 40px;
	color: #33675d;
	padding-top: 3px;
}

.search {
	vertical-align: middle;
}

form {
	display: inline-block;
	height: 50px;
}

table {
	padding: 0 auto;
	overflow: hidden;
}

.common {
	float: right;
}

input[type=text] {
	padding: 0px;
	text-align: center;
	margin: 0px;
	line-height: 46px;
}

td {
	font-size: 15px;
}

#data-list {
	overflow: hidden;
	padding: 0 auto;
}

#data-list th {
	height: 30px;
}

.drug {
	width: 100%;
}

.page_on, .page_off, .page_next, .page_last, .page_prev, .page_first {
	display: inline-block;
	line-height: 30px;
	margin: 0;
}

.page_on, .page_off {
	min-width: 22px;
	padding: 0 5px 2px;
}

.page_next, .page_last, .page_prev, .page_first {
	text-indent: -9999999px;
	border: 1px solid #d0d0d0;
	width: 30px;
}

.page_on {
	border: 1px solid gray;
	/* background-color: gray; */
	color: #fff;
	font-weight: bold;
}

.page_next {
	background: url('img/page_next.jpg') center no-repeat;
}

.page_last {
	background: url('img/page_last.jpg') center no-repeat;
}

.page_prev {
	background: url('img/page_prev.jpg') center no-repeat;
}

.page_first {
	background: url('img/page_first.jpg') center no-repeat;
}

.page-list {
	width: 40%;
	margin: 0 auto;
}

#data-list ul.drug li div:last-child {
	font-size: 14px;
}
</Style>
</head>
<body>
	<div class="container1">
		<div class="search">
<!-- 			<form> -->
				<input type="text" id='keyword' name='keyword'
					placeholder="검색할 약을 입력하세요!">
				<!-- <input type="submit" value="검색"> -->
				<button onclick="search_fn()">검색하기</button>
<!-- 				<button onclick="search()">검색하기</button> -->
				<div id='list-top'>
					<div id='pageList'></div>
				</div>
<!-- 			</form> -->
			<table class='common'>
				<tr>
					<td class='list-view'><i class="fas fa-list font-img"
						style="vertical-align: top;"></i></td>
					<td class='grid-view'><i class="fas fa-th font-img"
						style="vertical-align: top;"></i></td>
				</tr>
			</table>
		</div>
		<div class="result">
			<div id='data-list' style="width: 100%;"></div>
			<div class='page-list'></div>
		</div>
	</div>

	<script>
		drug_list(1);
		//약 검색 기능

		var keyword = null;
// 		var text = search_fn();
		//alert("출력문 => " + text);

		function search() {

			keyword = $('#keyword').val();


			if (keyword != null) {
				search_fn()
				alert('키워드가 있음');
				alert('키워드값은? ' + keyword + ' 입니다.');
			} else {
				search_fn();
				alert('키워드가 없음음');
			}
				
		};

		function search_fn() {
			$.ajax({
				url : 'data/search',
				data : {
					keyword : $('#keyword').val()
// 					keyword : keyword
				},
				dataType : "json",
				success : function(data) {
			console.log( '>> ',data )
					if (viewType == "list") {
						drug_list_data($(data.item), 0);
					} else {
						drug_grid_data($(data.item), 0);
					}
					alert("1단계")
					makePage(data.count, page);
// 					return keyword + "리턴한 값임!";

				},
				error : function(req, text) {
					alert(text + ':' + req.status);
				}
			});
		}

		var viewType = 'list';

		//약 정보 추출하는 함수
		function drug_list(page) {
			$.ajax({
				url : 'data/medicine',
				data : {
					pageNo : page,
					rows : $('#pageList').val()
				},
				dataType : "json",
				success : function(data) {

					if (viewType == "list") {
						drug_list_data($(data.item), 0);
					} else {
						drug_grid_data($(data.item), 0);
					}

					makePage(data.count, page);

				},
				error : function(req, text) {
					alert(text + ':' + req.status);
				}
			});
		}

		function makePage(totalList, curPage) {
			var page = pageInfo(totalList, curPage, pageList, blockPage);
			var tag = '';

			if (page.curBlock > 1) {
				tag += '<a class="page_first" data-page=1 >처음</a>'
						+ '<a class="page_prev" data-page='
						+ (page.beginPage - blockPage) + ' >이전</a>';
			}
			for (var no = page.beginPage; no <= page.endPage; no++) {
				if (no == curPage)
					tag += '<span class="page_on">' + no + '</span>';
				else
					tag += '<a class="page_off" data-page='+ no +'>' + no
							+ '</a>';
			}
			if (page.curBlock < page.totalBlock) {
				tag += '<a class="page_next" data-page='
						+ (page.endPage + 1)
						+ '>다음</a>'
						+ '<a class="page_last" data-page='+ page.totalPage +'>마지막</a>';
			}
			$('.page-list').html(tag);
		}
		function pageInfo(totalList, curPage, pageList, blockPage) {
			var page = new Object();
			page.totalPage = parseInt(totalList / pageList)
					+ (totalList % pageList == 0 ? 0 : 1);
			page.totalBlock = parseInt(page.totalPage / blockPage)
					+ (page.totalPage % blockPage == 0 ? 0 : 1);
			page.curBlock = parseInt(curPage / blockPage)
					+ (curPage % blockPage == 0 ? 0 : 1);
			page.endPage = page.curBlock * blockPage;
			page.beginPage = page.endPage - (blockPage - 1);
			if (page.endPage > page.totalPage)
				page.endPage = page.totalPage;
			return page;
		}

		$(document).on('click', '.page-list a', function() {
			drug_list($(this).data('page'));

		}).on('click', '.list-view', function() {
			if (viewType == 'grid') {
				viewType = 'list';
				drug_list_data($('.grid li'), 1);
			}

		}).on('click', '.grid-view', function() {
			if (viewType == 'list') {
				viewType = 'grid';
				drug_grid_data($('.drug tr'), 1);
			}

// 		}).on('change', '#pageList', function() {
// 			pageList = $(this).val();
// 			drug_list(1);

		}).on(
				'click',
				'.medicine',
				function() {
					//약 코드
					var code = $(this).data('x');
					var name = $(this).data('y');

					var kind = $(this).data('kind');
					var com = $(this).data('com');
					var date = $(this).data('date');
					var insurance = $(this).data('insurance');

					var appear = $(this).data('chart');
					var ingredient = $(this).data('ingredient');
					var keep = $(this).data('keep');
					var effect = $(this).data('effect');
					var eat = $(this).data('eat');
					var caution = $(this).data('caution');

					name = name.replace("%", "퍼센트");
					alert("무슨값이나올까용"+insurance)
					//디테일 창 넘기기
					location.href = "detail.if?code=" + code + "&name=" + name
							+ "&kind=" + kind + "&com=" + com + "&date=" + date
							+ "&insurance=" + insurance + "&appear=" + appear
							+ "&ingredient=" + ingredient + "&keep=" + keep
							+ "&effect=" + effect + "&caution=" + caution
							+ "&eat=" + eat;
		});

		//테이블목록뷰 --> 그리드뷰로 변경
		function drug_grid_data(data, type) {
			var tag = '<ul class="drug grid">';
			if (type == 0) {
				data
						.each(function() {
							tag += '<li>'
									+ '<div><a class="medicine" ' + 'data-x="'
				+ this.XPos + '" data-y="' + this.YPos
				+ '" >'
									+ this.yadmNm + '</a></div>' + '<div>'
									+ (this.telno ? this.telno : '-')
									+ '</div>' + '<div>' + this.addr + '</div>'
									+ '</li>';
						});
			} else {
				data.each(function() {
					if ($(this).index() > 0) {
						var $a = $(this).find('.medicine');
						tag += '<li>' + '<div><a class="medicine" ' + 'data-x="'
								+ $a.data('x') + '" data-y="' + $a.data('y')
								+ '" >' + $(this).children('td:eq(0)').text()
								+ '</a></div>' + '<div>'
								+ $(this).children('td:eq(1)').text()
								+ '</div>' + '<div>'
								+ $(this).children('td:eq(2)').text()
								+ '</div>' + '</li>';
					}
				});
			}
			tag += '</ul>';
			$('#data-list').html(tag);
			$('#data-list ul').css(
					'height',
					(($('.grid li').length % 5 > 0 ? 1 : 0) + Math
							.floor($('.grid li').length / 5))
							* $('.grid li').outerHeight(true) - 20);
		}
		//그리드뷰 --> 테이블목록뷰로 변경
		function drug_list_data(data, type) {
			console.log( '여기');
			//alert(type);

			var tag = '<table class="drug" border="1">'
					+ '<tr><th class="w-px200">약명</th>'
					+ '<th class="w-px140">회사</th><th>효능효과</th></tr>';
			//테이블표시
			if (type == 0) {

				//console.log("데이터: " + data.toString());

				data
						.each(function() {
							var size = 0;
							var idx = 0;
							
							tag += '<tr><td><a class="medicine" data-x='+this.ITEM_SEQ+' data-y='+this.ITEM_NAME
									+' data-kind='+this.ETC_OTC_CODE+' data-com='+this.ENTP_NAME+' data-date='+this.ITEM_PERMIT_DATE+' data-insurance='+this.INGR_NAME	
									+' data-chart='+this.CHART+' data-ingredient='+this.MATERIAL_NAME+' data-keep='+this.STORAGE_METHOD
									+' data-effect='+this.EE_DOC_DATA.DOC+' data-eat='+this.UD_DOC_DATA.DOC.SECTION.ARTICLE+' data-caution='+this.NB_DOC_DATA.DOC.SECTION+'>'
									+ this.ITEM_NAME
									+ '</a></td>'
									+ '<td>'
									+ this.ENTP_NAME
									+ '</td>'
									+ '<td class="left">'
									//+ title
									+ this.CHART + '</td>' + '</tr>';

						});
			} else {		//그리드뷰

				data
						.each(function() {
							tag += '<tr><td><a class="medicine" data-x='+this.ITEM_SEQ+' data-y='+this.ITEM_NAME
					+' data-kind='+this.ETC_OTC_CODE+' data-com='+this.ENTP_NAME+' data-date='+this.ITEM_PERMIT_DATE+' data-insurance='+this.CLASS_NO+' data-chart='+this.CHART+' data-ingredient='+this.MATERIAL_NAME+' data-keep='+this.STORAGE_METHOD
					+' data-effect='+this.EE_DOC_DATA.DOC+' data-eat='+this.UD_DOC_DATA.DOC.SECTION.ARTICLE+' data-caution='+this.NB_DOC_DATA.DOC.SECTION+'>'
								
									+ '</a></td>'
									+ '<td>'
									+ $(this).children('div:eq(1)').text()
									+ '</td>'
									+ '<td class="left">'
									+ $(this).children('div:eq(2)').text()
									+ '</td>' + '</tr>';

						});
			}
			tag += '</table>';
			$('#data-list').html(tag);

		}
		var pageList = 10, blockPage = 10; //페이지당 보여질 목록수, 블럭당 보여질 페이지수
	</script>
<body>

</body>
</body>

</html>