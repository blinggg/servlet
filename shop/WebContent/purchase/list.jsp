<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>쇼핑몰</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<link rel="stylesheet" href="../home.css" />
<style>
#tblInfo, #tblOrder {
	width: 800px;
	margin: auto;
	overflow: hidden;
	margin-bottom: 10px;
	margin-top: 10px;
}
</style>
</head>
<body>
	<div id="divPage">
		<div id="divMenu"><jsp:include page="../menu.jsp" /></div>
		<div id="divHeader">
			<h2>주 문 목 록</h2>
		</div>
		<div id="divCondition">
			<div id="divSearch">
				<select id="selKey">
					<option value="order_id">주문번호</option>
					<option value="name">구매자명</option>
					<option value="address">주소</option>
					<option value="tel">전화번호</option>
				</select> <input type="text" id="txtWord"> <select id="selPerPage">
					<option value="3">3행</option>
					<option value="5">5행</option>
					<option value="10">10행</option>
				</select> <input type="button" id="btnSearch" value="검색"> <span
					style="font-size: 12px;">검색수: <b id="count"></b>건
				</span>
			</div>
			<div id="divSort">
				<select id="selOrder">
					<option value="order_id">주문번호</option>
					<option value="name">구매자명</option>
					<option value="address">주소</option>
				</select> <select id="selDesc">
					<option value="">오름차순</option>
					<option value="desc">내림차순</option>
				</select>
			</div>
		</div>
		<table id="tbl"></table>
		<script id="temp" type="text/x-handlebars-template">
          <tr class="title">
             <td width=100>주문번호</td>
             <td width=100>구매자명</td>
             <td width=300>주소</td>
             <td width=150>전화번호</td>
             <td width=150>구매정보</td>
          </tr>
          {{#each array}}
          <tr class="row">
             <td class=order_id>{{order_id}}</td>
             <td class=name>{{name}}</td>
             <td>{{address}}</td>
             <td>{{tel}}</td>
             <td><button id=btnPurchase>구매정보</button></td>
          </tr>
          {{/each}}
 </script>
		<div id="divInfo">
			<table id="tblInfo" style="margin-top: 30px;"></table>
			<script id="tempInfo" type="text/x-handlebars-template">
 				<tr>
 					<td class="title" width=50>이름</td>
 					<td width=100>{{name}}</td>
 					<td class="title" width=50>전화</td>
 					<td width=200>{{tel}}</td>
 					<td class="title" width=50>이메일</td>
 					<td width=150>{{email}}</td>
 					<td class="title" width=50>구매일</td>
 					<td width=150>{{pdate}}</td>
				</tr>
 				<tr>
 					<td class="title" width=50>주소</td>
 					<td id="address" colspan=3>{{address}}</td>
 					<td class="title" width=50>결제</td>
 					<td id="payType" width=100>{{payType}}</td>
 					<td class="title" width=50>상태</td>
 				<td id="status" width=100>{{status}}</td>
 				</tr>
 </script>
 		<table id="tblOrder"></table>
		<script id="tempOrder" type="text/x-handlebars-template">
          <tr class="title">
             <td width=100>상품코드</td>
             <td width=400>상품명</td>
             <td width=100>제조사</td>
             <td width=150>가격</td>
             <td width=50>수량</td>
			<td width=150>합계</td>
          </tr>
          {{#each .}}
          <tr class="row">
             <td class=prod_id>{{prod_id}}</td>
             <td>{{prod_name}}</td>
             <td>{{company}}</td>
             <td>{{price}}</td>
             <td>{{quantity}}</td>
			<td>{{sum}}</td>
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
	//구매자 목록 출력하기
	var url = "/shop/purchase/list";
	
	//구매정보 버튼을 눌렀을 때
	$("#tbl").on("click", ".row button", function() {
		//alert("..");
		//구매자의 정보를 보여주기
		var row = $(this).parent().parent();
		var order_id = row.find(".order_id").html();
		
		$.ajax({
			type : "get",
			url : "read",
			data : {"order_id" : order_id},
			dataType : "json",
			success : function(data) {
				var template = Handlebars.compile($("#tempInfo").html());
				$("#tblInfo").html(template(data));
			}
		});
		
		//구매자의 주문 내역을 보여주기
		$.ajax({
			type : "get",
			url : "/shop/orders/list",
			data : {"order_id" : order_id},
			dataType : "json",
			success : function(data) {
				//alert(order_id);
				var template = Handlebars.compile($("#tempOrder").html());
				$("#tblOrder").html(template(data));
			}
		});
	});

</script>
<script src="../home.js"></script>
</html>