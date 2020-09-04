<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<link rel="stylesheet" href="home.css"/>
<style>
img{cursor:pointer;margin:auto;}


</style>
<title>도서검색</title>

</head>
<body>
<div id=divPage>
	<div id=divMenu><jsp:include page="menu.jsp"/></div>
	<div id="divHeader">
			<h2>도 서 검 색</h2>
	</div>
	<div id=divCondition>
		<input type=text id="query" value=김미경>
		<input type=button value=검색 id=btnSearch>
		<select id="display">
			<option value="5">5행</option>
			<option value="10">10행</option>
		</select>
		검색건수:<span id="total"></span>
	</div>
		<table id="tbl"></table>
		<script id="temp" type="text/x-handlebars-template">
		<tr class=title>	
			<td>이미지</td>
			<td>책제목</td>		
			<td>책저자</td>
			<td>판매가</td>
			<td>출간일</td>
		</tr>

		{{#each items}}
		<tr>
			<td><a href="{{link}}"><img src={{{image}}}</a></td>
			<td>{{{title}}}</td>
			<td>{{{author}}}</td>
			<td>{{{price}}}</td>
			<td>{{{pubdate}}}</td>
		</tr>
		{{/each}}
		</script>
		
		<div id="pagination">
				<button id="btnPre">◀</button>
				<button id="btnNext">▶</button>
				[<span id="curPage"></span>/<span id="totPage"></span>]
		</div>
	</div>
	
</body>
<script>
	var url="/api/naver/book";
</script>
<script src="home.js"></script>
</html>