<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>쇼핑몰</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
   <link rel="stylesheet" href="home.css">
<style>
 .box{width:200px;float:left;text-align:center; margin:auto;}
 .price1, .prod_id, .prod_name{font-size:12px; width:200px; text-overflow:ellipsis; white-space:nowrap; overflow:hidden;}
 .cart0{font-size:12px; width:200px; cursor:pointer; color:green; font-weight:bold;}
 .cart1{font-size:12px; width:200px; color:red; font-weight:bold;}
 .image img{whitd:150px; height:120px; margin:auto; margin-bottom:5px;}
</style>

</head>
<body>
   <div id="divPage">
      <div id="divMenu"><jsp:include page="menu.jsp"/></div>
      		<div id="divHeader"><h2>가 구 나 라</h2></div>
      <!--내용 입력 시작 ---------------------- -->
      		<div id="divCondition">
			<div id="divSearch"> 
				<select id="selKey">
					<option value="prod_id">상품코드</option>
					<option value="prod_name">상품명</option>
					<option value="company">제조사</option>
				</select> <input type="text" id="txtWord"> 
					<select id="selPerPage">
					<option value="4">4행</option>
					<option value="8">8행</option>
					<option value="12" selected>12행</option>
				</select> <input type="button" id="btnSearch" value="검색"> <span
					style="font-size: 12px;">검색수: <b id="count"></b>건
				</span>
			</div>
			<div id="divSort">
				<select id="selOrder">
					<option value="prod_id">상품코드</option>
					<option value="prod_name">상품명</option>
					<option value="company">제조사</option>
					<option value="price">가격</option>
				</select> <select id="selDesc">
					<option value="">오름차순</option>
					<option value="desc">내림차순</option>
				</select>
			</div>
		</div>
		<div id="tbl"></div>
		<script id="temp" type="text/x-handlebars-template">
		{{#each array}}
			<div class=box>
				 <div class="image"><img src="{{printImage image}}"></div>
				<div class=prod_id>{{prod_id}}</div>
				<div class=prod_name>{{prod_name}}</div>
				<div class=price1>{{price1}}원</div>
				<div class="cart{{prod_del}}">{{printDel prod_del}}</div>

			</div>
		{{/each}}
		</script>
      <!--내용 입력 종료 ---------------------- -->
      <div id="pagination">
			<button id="btnPre">◀</button>
			<button id="btnNext">▶</button>
			[<span id="curPage"></span>/<span id="totPage"></span>]
		</div>
   </div>
   
</body>
<script>
	var url="/shop/product/list";

	
	//장바구니 버튼을 눌렀을 때
	$("#tbl").on("click", ".box .cart0", function(){
		var	prod_id=$(this).parent().find(".prod_id").html();
		if(!confirm(prod_id+"상품을 장바구니에 담으시겠습니까?")) return;
		$.ajax({
			type:"post",
			url:"/shop/cart/insert",
			data:{"prod_id":prod_id},
			success:function(){
				alert("장바구니에 상품이 담겼습니다.");
				//location.href="/shop/cart/list.jsp";
			}
		});
	});
	
	//이미지가 없을 때 
	Handlebars.registerHelper("printImage",function(image){
      var src;
      if(!image){
         src="http://placehold.it/300x200";
      }else{
         src="/img/product/"+image;
      }
      return src;
   });

	
	//장바구니, 판매중지 뜨게 하기
	Handlebars.registerHelper("printDel", function(del){
		var src;
		if(del==1) src="판매중지"; else src="장바구니";
		return src;
	});
	
</script>
<script src="home.js"></script>
</html>