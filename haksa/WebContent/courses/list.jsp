<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>학사관리시스템</title>
	<link rel="stylesheet" href="../home.css">
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
   	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
</head>
<body>
	<div id="divPage">
		<div id="divTop"><jsp:include page="../header.jsp"/></div>
		<div id="divCenter">
			<div id="divMenu"><jsp:include page="../menu.jsp"/></div>
			<div id="divContent">
			<!--여기에 내용출력 시작---------------------------- -->
			<div id="divHeader"><h2>강 좌 목 록</h2></div>
			<div id="divCondition">
				<div id="divSearch">
					<select id="selKey">
						<option value="lcode">강좌번호</option>
						<option value="lname">강좌이름</option>
						<option value="room">강의실</option>
						<option value="pname">교수명</option>
					</select>
					<input type="text" id="txtWord">
					<select id="selPerPage">
 						<option value="3">3행</option>
 						<option value="5" selected>5행</option>
 						<option value="10">10행</option>
 					</select>
 					<input type="button" id="btnSearch" value="검색">
 					<span style="font-size:12px;">검색수: <b id="count"></b>건</span>
				</div>
				<div id="divSort">
					<select id="selOrder">
						 <option value="lcode">강좌번호</option>
						 <option value="lname">강좌이름</option>
						 <option value="room">강의실</option>
						 <option value="pname">교수명</option>
					</select>
					<select id="selDesc">
						 <option value="">오름차순</option>
						 <option value="desc">내림차순</option>
					</select>
				</div>
			</div>
			<table id="tbl"></table>
			<script id="temp" type="text/x-handlebars-template">
 				<tr class="title">
 					<td width=130>강좌번호</td>
 					<td width=180>강좌이름</td>
 					<td width=130>강의실</td>
 					<td width=130>담당교수명</td>
 					<td width=70>강의시수</td>
 					<td width=70>수강신청</td>
					<td width=70>강좌정보</td>
 				</tr>
 				{{#each array}}
 				<tr class="row">
 					<td class="lcode">{{lcode}}</td>
 					<td class="lname">{{lname}}</td>
 					<td class="room">{{room}}</td>
 					<td class="pname">{{pname}}</td>
 					<td class="hours">{{hours}}</td>
 					<td class="persons">{{persons}}</td>
					<td><button>강좌정보</button>
 				</tr>
 				{{/each}}
 			</script>
 			<div id="pagination">
 				<button id="btnPre">◀</button> <button id="btnNext">▶</button>
 				[<span id="curPage"></span>/<span id="totPage"></span>]
 			</div>
			<!--여기에 내용출력 종료---------------------------- -->
			</div>
		</div>
		<div id="divBottom"><jsp:include page="../footer.jsp"/></div>
	</div>
</body>
<script>
	var url="/haksa/courses/list";
	$("#tbl").on("click", ".row button",function(){
		var lcode=$(this).parent().parent().find(".lcode").html();
		location.href="read?lcode=" + lcode;
	});
</script>
<script src="../home.js"></script>
</html>




