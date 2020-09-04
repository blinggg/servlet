<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
#tbl {
	width: 350px;
	margin: auto;
}

#pagination, h2 {
	width: 350px;
	margin: auto;
	text-align: center;
	margin-top: 10px;
	margin-bottom: 10px;
}

table {
	border-collapse: collapse;
}

td {
	border: 1px solid black;
	height: 30px;
	font-size: 12px;
	padding: 0px 5px 0px 5px;
}

table .title {
	background: #EAEAEA;
	text-align: center;
}

table .row:hover {
	background: gray;
	color: white;
}
</style>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<title>업체목록</title>

</head>
<body>
	<div id="divAll">
		<h2>업 체 목 록</h2>
		<input id=selPerpage  type=hidden value=3>
		<table id="tbl"></table>
		<script id="temp" type="text/x-handlebars-template">
 			<tr class="title">
				<td width=100>업체코드</td>
				<td width=100>업체명</td>
				<td width=150>전화번호</td>
			</tr>
 			{{#each array}}
 			<tr class="row">
				<td class="mall_id">{{mall_id}}</td>
 				<td class="mall_name">{{mall_name}}</td>
 				<td>{{tel}}</td>
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
	var url = "list";
	
	$("#tbl").on("click", ".row", function() {
		var mall_id = $(this).find(".mall_id").html();
		var mall_name = $(this).find(".mall_name").html();
		$(opener.frm.mall_id).val(mall_id);
		$(opener.frm.mall_name).val(mall_name);
		window.close();
	});
	
</script>
<script src="../home.js"></script>
</body>
</html>