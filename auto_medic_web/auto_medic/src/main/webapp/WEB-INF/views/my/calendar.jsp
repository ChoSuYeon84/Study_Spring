<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>



<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" type="text/css"
	href="css/common.css?v=<%=new Date().getTime()%>">
<script type="text/javascript">
	var today = new Date();//오늘 날짜//내 컴퓨터 로컬을 기준으로 today에 Date 객체를 넣어줌
	var date = new Date();//today의 Date를 세어주는 역할	

	function prevCalendar() {//이전 달
	// 이전 달을 today에 값을 저장하고 달력에 today를 넣어줌
	//today.getFullYear() 현재 년도//today.getMonth() 월  //today.getDate() 일 
	//getMonth()는 현재 달을 받아 오므로 이전달을 출력하려면 -1을 해줘야함
		today = new Date(today.getFullYear(), today.getMonth() - 1, today
				.getDate());
		buildCalendar(); //달력 cell 만들어 출력 
	}

	function nextCalendar() {//다음 달
		// 다음 달을 today에 값을 저장하고 달력에 today 넣어줌
		//today.getFullYear() 현재 년도//today.getMonth() 월  //today.getDate() 일 
		//getMonth()는 현재 달을 받아 오므로 다음달을 출력하려면 +1을 해줘야함
		today = new Date(today.getFullYear(), today.getMonth() + 1, today
				.getDate());
		buildCalendar();//달력 cell 만들어 출력
	}
	function buildCalendar() {//현재 달 달력 만들기
		var doMonth = new Date(today.getFullYear(), today.getMonth(), 1);
		//이번 달의 첫째 날,
		//new를 쓰는 이유 : new를 쓰면 이번달의 로컬 월을 정확하게 받아온다.     
		//new를 쓰지 않았을때 이번달을 받아오려면 +1을 해줘야한다. 
		//왜냐면 getMonth()는 0~11을 반환하기 때문
		var lastDate = new Date(today.getFullYear(), today.getMonth() + 1, 0);
		//이번 달의 마지막 날
		//new를 써주면 정확한 월을 가져옴, getMonth()+1을 해주면 다음달로 넘어가는데
		//day를 1부터 시작하는게 아니라 0부터 시작하기 때문에 
		//대로 된 다음달 시작일(1일)은 못가져오고 1 전인 0, 즉 전달 마지막일 을 가져오게 된다
				
		var tbCalendar = document.getElementById("calendar");
		//날짜를 찍을 테이블 변수 만듬, 일 까지 다 찍힘
		var tbCalendarYM = document.getElementById("tbCalendarYM");
		//테이블에 정확한 날짜 찍는 변수
		//innerHTML : js 언어를 HTML의 권장 표준 언어로 바꾼다
		//new를 찍지 않아서 month는 +1을 더해줘야 한다. 
		tbCalendarYM.innerHTML = today.getFullYear() + "년 "
				+ (today.getMonth() + 1) + "월";

		/*while은 이번달이 끝나면 다음달로 넘겨주는 역할*/
		while (tbCalendar.rows.length > 2) { //tbCalendar.rows.length:'월~일',한달,'클릭달'
			//열을 지워줌
			//기본 열 크기는 body 부분에서 2로 고정되어 있다.
			tbCalendar.deleteRow(tbCalendar.rows.length - 1); //마지막 달빼고 지워짐
			//테이블의 tr 갯수 만큼의 열 묶음은 -1칸 해줘야지 
			//30일 이후로 담을달에 순서대로 열이 계속 이어진다.
		}		
		var row = null;
		row = tbCalendar.insertRow();
		//테이블에 새로운 열 삽입//즉, 초기화
		var cnt = 0;// count, 셀의 갯수를 세어주는 역할
		// 1일이 시작되는 칸을 맞추어 줌
		for (i = 0; i < doMonth.getDay(); i++) {
			/*이번달의 day만큼 돌림*/
			cell = row.insertCell();//열 한칸한칸 계속 만들어주는 역할
			cnt = cnt + 1;//열의 갯수를 계속 다음으로 위치하게 해주는 역할
		}
		/*달력 출력*/
		for (i = 1; i <= lastDate.getDate(); i++) {
			
			var month=( today.getMonth() + 1);
			  if((today.getMonth() + 1)<10){
				month="0"+(today.getMonth() + 1);
			   }

			  var day=i; 
			  if(day<10){
			    day="0"+i;
				  }
            var dayy=today.getFullYear()+"-"+month+"-"+day;
			
			//1일부터 마지막 일까지 돌림
			cell = row.insertCell();//열 한칸한칸 계속 만들어주는 역할		
			cell.innerHTML = "<a><div class='date'  id="+dayy+" val="+dayy+">"
			 + i + "</div></a>";//셀을 1부터 마지막 day까지 HTML 문법에 넣어줌
			//cell.innerHTML = "<a class='date'>" + i + "</a>";//셀을 1부터 마지막 day까지 HTML 문법에 넣어줌
			cnt = cnt + 1;//열의 갯수를 계속 다음으로 위치하게 해주는 역할
		
			if (cnt % 7 == 1) {/*일요일 계산*/
				//1주일이 7일 이므로 일요일 구하기
				//월화수목금토일을 7로 나눴을때 나머지가 1이면 cnt가 1번째에 위치함을 의미한다
				cell.innerHTML = "<a><div class='date'id="+dayy+" val="+dayy+" ><font color=#F79DC2><a >" + i + "</div></a>"
				//1번째의 cell에만 색칠
			}
			if (cnt % 7 == 0) {/* 1주일이 7일 이므로 토요일 구하기*/
				//월화수목금토일을 7로 나눴을때 나머지가 0이면 cnt가 7번째에 위치함을 의미한다
				cell.innerHTML = "<a><div class='date'id="+dayy+" val="+dayy+"><font color=skyblue>" + i + "</div></a>"
				//7번째의 cell에만 색칠
				row = calendar.insertRow();
				//토요일 다음에 올 셀을 추가
			}
			/*오늘의 날짜에 노란색 칠하기*/
			if (today.getFullYear() == date.getFullYear()
					&& today.getMonth() == date.getMonth()
					&& i == date.getDate()) {
				//달력에 있는 년,달과 내 컴퓨터의 로컬 년,달이 같고, 일이 오늘의 일과 같으면
				cell.bgColor = "#FAF58C";//셀의 배경색을 노랑으로 
			}
		}
		
	}
	
 
$(document).ready(function(){
  var month=( today.getMonth() + 1);
  if((today.getMonth() + 1)<10){
	month="0"+(today.getMonth() + 1);
   }

  var day=today.getDate(); 
  if(day<10){
    day="0"+today.getDate();
	  }

  selectedDate(today.getFullYear() + "년 " + (month) + "월 " + day+"일"
		  ,  today.getFullYear() + "-" + (month) + "-" + day);
 
});
 $(document).on('click', '.date', function(index,item){
  	
   var month=( today.getMonth() + 1);
   if((today.getMonth() + 1)<10){
   	month="0"+(today.getMonth() + 1);
   }

   var day=$(this).text(); 
   if($(this).text()<10){
       day="0"+day;
	  }
   selectedDate(today.getFullYear() + "년 " + (month) + "월 " + day+"일"
		   , today.getFullYear() + "-" + (month) + "-" + day);
	
	$(this).attr('style',
	 'background:#BDF0FB;-webkit-border-radius:25px;');

	  //그전 클릭했던 날짜배경색을 사라지게 하고 클래스를 원래대로 바꿈 	  
	  $('.selected').attr('style','none');	
	  $('.selected').attr('class','date');

	  //클릭하고 난 뒤에 클래스 바꾸기
	  $(this).attr('class','selected');
		  
});

function selectedDate(first, second) {
	$('#daily').text( first);
	$('#daily2').val( second);

	$.ajax({
		url: 'select.calendar.my',
		data: { day: second },
		success: function(response){
			var tag;
			if( response.length==0){
				tag = '<tr><td colspan="3">해당 일정이 없습니다.</td></tr>' 
			}else{
				$(response).each(function(){
					tag += '<tr><td>'+  this.record_take_time.substr(11,5) +'</td>'
					+ '<td>'+ this.record_alarm_name +'</td>'
                    if(this.chk==1){
                    	tag += '<td><button>삭제</button></td>'
                    }else{
                    	tag += '<td></td>' 
                       }					
					tag +='</tr>' ;
				});
			}
			$('#schedule tbody').html(tag);
			
		},error: function(req, status){
			alert(status+': '+req.status);
		}
		
	});
	
}

	
</script>
<script type="text/javascript"
	src="js/no_back.js?v=<%=new java.util.Date().getTime()%>"></script>

<style>
#input{
float: right;
}
#check{
-webkit-border-radius:25px;		
background: #CFD7EC;

}
#calendar {
	width: 800px;
	height: 500px;
	float: left;
	position:relative;
	left:50px;
	
}

#scd {
	float: left;
	width: 800px;
	height: 500px;
	overflow: auto;
	
	position:relative;
	left:100px;
}

td {
	width: 50px;
	height: 50px;
	text-align: center;
	font-size: 20px;
}

th {
	height: 30px;
	text-align: center;
	font-size: 20px;
}


#schedule{
 border-collapse:collapse;
 
}

</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body onload="noBack();" onpageshow="if(event.persisted) noBack();"
	onunload="">
     
	<h3 align="center">복용 기록 달력</h3>
	
		<table id="calendar">
			<tr>
				<!-- label은 마우스로 클릭을 편하게 해줌 -->
				<td><a onclick="prevCalendar()"><</a></td>
				<td align="center" id="tbCalendarYM" colspan="5">yyyy년 m월</td>
				<td><a onclick="nextCalendar()">&nbsp;&nbsp;> </a></td>
			</tr>
			<tr>
				<td align="center"><font color="#F79DC2" >일</font></td>
				<td align="center">월</td>
				<td align="center">화</td>
				<td align="center">수</td>
				<td align="center">목</td>
				<td align="center">금</td>
				<td align="center"><font color="skyblue">토</font></td>
				<!-- style='background:#F79DC2;'  -->
			</tr>
		</table>
		<script type="text/javascript">
			buildCalendar();//
		</script>
	
	<div id="scd" >
		<div>
			<h3 align="center" id='daily'></h3>
			<input type="text" id='daily2' >		
		</div>
		<div id="box">
			<table border="1" id="schedule">
				<thead>
					<tr>
						<th class="w-px200">시간</th>
						<th class="w-px500">일정</th>
						<th class="w-px80">삭제하기</th>
						
					</tr>					
				</thead>
				<tbody></tbody>
			</table>
		</div>
			
	</div>
	
	<div id="input">
	시간<input type="text" size="2">:<input type="text" size="2">
	일정<input type="text"><input type="button" value="입력"> 
	</div>	    
</body>
</html>