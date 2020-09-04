<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>쇼핑몰</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<link rel="stylesheet" href="../home.css" />
<style>
#tblPurchase, #tblOrder {
	width: 800px;
	margin: auto;
	overflow: hidden;
	margin-bottom: 10px;
}
</style>
</head>
<body>
	<div id="divPage">
		<div id="divMenu"><jsp:include page="../menu.jsp" /></div>
		<div id="divCart">
			<div id="divHeader">
				<h2>장 바 구 니</h2>
			</div>
			<c:if test="${listCart.size() > 0}">
				<table id="tbl">
					<tr class="title">
						<td width=20><input type="checkbox" id="chkAll"></td>
						<td width=100>코드</td>
						<td width=330>상품명</td>
						<td width=100>단가</td>
						<td width=100>수량</td>
						<td width=100>합계</td>
						<td width=50>삭제</td>
					</tr>
					<c:forEach items="${listCart}" var="vo">
						<tr class="row">
							<td><input type="checkbox" class="chk"></td>
							<td class="id">${vo.prod_id}</td>
							<td class="name">${vo.prod_name}</td>
							<td class="price">${vo.price}</td>
							<td><input type="text" value="${vo.quantity}" class="quantity" size=1>
								<button class="btnUpdate">수정</button></td>
							<td class="sum">${vo.sum}</td>
							<td><button class="btnDelete">삭제</button>
						</tr>
					</c:forEach>
				</table>
				<div id="pagination">
					<button id="btnAll">전체상품주문</button>
					<button id="btnSel">선택상품주문</button>
				</div>
			</c:if>
			<c:if test="${listCart==null || listCart.size()==0}">
				<table id="tbl">
					<tr class="title">
						<td class="title">장바구니가 비어있습니다.</td>
					</tr>
				</table>
			</c:if>
		</div>
		<div id=divOrderInfo>
			<div id="divHeader">
				<h2>주 문 정 보</h2>
			</div>
			<table id="tblOrder"></table>
			<script id="tempOrder" type="text/x-handlebars-template">
 			<tr class="title">
 				<td width=100>상품코드</td>
 				<td width=400>상품명</td>
 				<td width=100>상품가격</td>
 				<td width=100>상품수량</td>
 				<td width=100>합계</td>
 			</tr>
 			{{#each .}}
			 <tr class="row">
 				<td class="id">{{id}}</td>
 				<td class="name">{{name}}</td>
 				<td class="price">{{price}}</td>
 				<td class="quantity">{{quantity}}</td>
 				<td class="sum">{{sum}}</td>
 			</tr>
 			{{/each}}
			 <tr class="title">
				<td colspan=4>합계</td><td id="totSum" class="sum"></td>
 			</tr>
 </script>
 			<form name=frm>
			<table id="tblPurchase">
				<tr>
					<td class="title" with=100>주문자 성명</td>
					<td><input type="text" name="name" size=10></td>
				</tr>
				<tr>
					<td class="title" with=100>배송지 주소</td>
					<td><input type="text" name="address" size=80></td>
				</tr>
				<tr>
					<td class="title" width=100>이메일 주소</td>
					<td><input type="text" name="email" size=40></td>
				</tr>
				<tr>
					<td class="title" width=100>전 화 번 호</td>
					<td><input type="text" name="tel" size=40></td>
				</tr>
				<tr>
					<td class="title" width=100>결 재 방 법</td>
					<td><input type="radio" name="payType" checked value="0">무통장 <!-- 입력받는것은 다 form -->
						<input type="radio" name="payType" value="1">카드</td>
				</tr>
			</table>
			<div id="pagination">
				<input type=submit value=주문하기>
			</div>
			</form>
		</div>
	</div>
</body>
<script>
	$("#divOrderInfo").hide();
	$(frm).submit(function(e){
		if(!confirm("상품들을 주문하시겠습니까?")) return;
		var name=$(frm.name).val();
		var address=$(frm.address).val();
		var email=$(frm.email).val();
		var tel=$(frm.tel).val();
		var payType=$('input[name="PayType"]:checked').val();
		$.ajax({
			type:"post",
			url:"/shop/purchase/insert",
			data:{"name":name, "address":address, "email":email, "tel":tel, "payType":payType},
			dataType:"josn",
			success:function(data){
				alert(data.order_id);
				$("#tblOrder .row").each(function(){
				var order_id=data.order_id;
				var prod_id=$(this).find(".id").html();
				var price=$(this).find(".price").html();
				var quantity=$(this).find(".quantity").html();
				$.ajax({
					type:"post",
					url:"/shop/order/insert",
					data:{"order_id":order_id, "prod_id":prod_id, "price":price, "quantity":quantity},
					success:function(){
						alert("주문이 완료되었습니다.");
						 location.href="/shop/orders/list";
						}
					});
				});
			}
		});
	});
	//선택상품주문 버튼을 클릭했을때
	   $("#btnSel").on("click",function(){
	      $("#divCart").hide();
	      var totSum=0;
	      var array=[];   //배열
	      if($(".chk:checked").length>0){
	         $(".chk:checked").each(function(){
	            var row=$(this).parent().parent();
	            var id=row.find(".id").html();
	            var name=row.find(".name").html();
	            var price=row.find(".price").html();
	            var quantity=row.find(".quantity").val();
	            var sum=row.find(".sum").html();
	            totSum=totSum+parseInt(sum);
	            var data={"id":id,"name":name,"price":price,"quantity":quantity,"sum":sum};
	            array.push(data);
	         });
	         var template = Handlebars.compile($("#tempOrder").html());
	         $("#tblOrder").html(template(array));
	         $("#totSum").html(totSum);
	         $("#divOrderInfo").show();
	      }else{
	         alert("선택한 상품이 없습니다.");
	         $("#divCart").show();
	      }
	   });
	
	
	/*//선택상품주문 버튼을 선택했을 때
	$("#btnSel").on("click", function() {
		if($("#tbl .row.chk:checked").length>0){
			var array=[];
			var totSum=0;
			$("#tbl .row .chk:checked").each(function(){
				var id=$(this).find(".id").html();
				var name=$(this).find(".name").html();
				var price=$(this).find(".price").html();
				var quantity=$(this).find(".quantity").val();
				var sum=$(this).find(".sum").html();
				totSum=totSum+parseInt(sum);
				var data={"id":id, "name":name, "price":price, "quantity":quantity, "sum":sum}
				array.push(data);
			});
		//$("#divCart").hide();
			var template = Handlebars.compile($("#tempOrder").html());
			$("#tblOrder").html(template(array));
			$("#totSum").html(totSum);
			$("#divOrderInfo").show();
		}else{
			alert("선택한 상품이 없습니다");
		}
	});*/
		
	//전체상품주문 버튼을 선택했을 때
	$("#btnAll").on("click", function() {
		//$("#divCart").hide();
		$("#divOrderInfo").show();
		
		var array=[];
		var totSum=0;
		$("#tbl .row").each(function(){
			var id=$(this).find(".id").html();
			var name=$(this).find(".name").html();
			var price=$(this).find(".price").html();
			var quantity=$(this).find(".quantity").val();
			var sum=$(this).find(".sum").html();
			totSum=totSum+parseInt(sum);
			var data={"id":id, "name":name, "price":price, "quantity":quantity, "sum":sum}
			array.push(data);
			
		});
			var template = Handlebars.compile($("#tempOrder").html());
			$("#tblOrder").html(template(array));
			$("#totSum").html(totSum);
		
	});
	//장바구니 수량 수정버튼을 클릭한 경우
	$("#tbl").on("click", ".row .btnUpdate", function(){
		var row=$(this).parent().parent();
		var prod_id=$(row).find(".id").html();
		var quantity=$(row).find(".quantity").val();
		var price=$(row).find(".price").html();
		 if(!confirm(prod_id +" 상품의 수량을 " + quantity + "개로 수정하시겠습니까?")) return;
		 	$.ajax({
			 type:"post", 
			 url:"/cart/update", 
			 data:{"prod_id":id, "quantity":quantity}, 
			 success:function(){
			 	alert("수정되었습니다.");
			 	location.href="list";
			 }
		});

	});
	
	//전체 체크버튼을 눌렀을 때
	$("#tbl").on("click", "#chkAll", function() {
		if ($(this).is(":checked")) {
			$("#tbl .row .chk").each(function() {
				$(this).prop("checked", true);
			});
		} else {
			$("#tbl .row .chk").each(function() {
				$(this).prop("checked", false);
			});
		}
	});

	//각 행에 있는 체크버튼을 눌렀을 때 전체체크버튼 속성 바꾸기
	$("#tbl").on("click", ".row .chk", function() {
		var isChkALL = true;
		$("#tbl .row .chk").each(function() {
			if (!$(this).is(":checked"))
				isChkALL = false;

		});

		if (isChkALL) {
			$("#tbl #chkAll").prop("checked", true);
		} else {
			$("#tbl #chkAll").prop("checked", false);
		}
	});
</script>
</html>