<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
   <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
   
<title>한빛미디어</title>
	<link rel="stylesheet" href="../home.css"/>
</head>
<body>
	<div id=page>
		<div id=header><jsp:include page="../header.jsp"></jsp:include></div>
		<div id=center>
			<!-- 여기부터 출력할 내용 -->
			<div id=menu><jsp:include page="../menu.jsp"></jsp:include></div>
			<div id=content>
				<h2>[도서목록]</h2>
				<div id=search style="margin-bottom:10px;">
						<select id=key>
							<option value=code>책코드</option>
							<option value=title>책제목</option>
							<option value=writer>책저자</option>
							<option value=price>가격</option>
						</select>
						
						<input type=text id=word class=word>
						
						<select id=perPage>
							<option value=5>5행씩 출력</option>
							<option value=10>10행씩 출력</option>
							<option value=15>15행씩 출력</option>
						</select>
						
						<input type=button value=검색 id=btnSearch>
						
						검색수:<span id=count></span>	
				</div>
				
				<table id=tbl width=700></table>
				<script id="temp" type="text/x-handlebars-template">
					<tr class=title>
						<td width=100>책코드</td>
						<td width=300>책제목</td>
						<td width=100>책저자</td>
						<td width=100>가격</td>
						<td width=100>카트</td>												
					</tr>
				{{#each array}}
					<tr class=row>
						<td class=code>{{code}}</td>
						<td class=btitle>{{title}}</td>
						<td class=center>{{writer}}</td>
						<td class=price>{{price}}</td>
						<td><button>카트</button></td>
					</tr>
				{{/each}}
			</script>
			<div id=pagination style="margin-top:10px;text-align:center;">
				<button id=btnPre>◀</button>
				<button id=btnNext>▶</button>
				[<span id=spage></span>
				/<span id=stotPage></span>]
			</div>
			<!-- 여기부터 출력할 내용 작성종료 -->
		</div>
		<div id=footer><jsp:include page="../footer.jsp"></jsp:include></div>
	</div>
</body>
<script>
	var key;
	var word;
	var page=1;
	var perPage;
	var totPage;
	
	getList();
	
	//도서 목록 읽기
	$("#tbl").on("click", ".row", function(){
		var code=$(this).find(".code").html();
		location.href="read?code="+code;
	});
	
	//카트 담기 버튼을 눌렀을 때
	$("#tbl").on("click",".row button", function(){
		var row=$(this).parent().parent();
		var code=row.find(".code").html();
		var title=row.find(".btitle").html();
		var price=row.find(".price").html();
		
		if(!confirm(code+" 상품을 장바구니에 담겠습니까?")) return;
		
		$.ajax({
			type:"post",
			url:"/book/cart",
			data:{"code":code, "title":title, "price":price},
			success:function(){
				alert("장바구니에 1개 담았습니다!");
			}

		});

	});
	
	//1페이지일때 이전버튼 속성정하기
	if(page==1){
		$("#btnPre").attr("disabled", true);
	}else{
		$("#btnPre").attr("disabled", false);
	}
	
	if(page==totPage){
		$("#btnNext").attr("disabled", true);
	}else{
		$("#btnNext").attr("disabled", false);
	}
	
	$("#btnPre").on("click",function(){
		page--;
		getList();
	});
	
	$("#btnNext").on("click",function(){
		page++;
		getList();
	});
	
	
	$("#word").keydown(function(key){
		if(key.keyCode==13){
			page=1;
			getList();
		}
	});
	
	$("#btnSearch").on("click", function(){
		page=1;
		getList();
	});
	
	function getList(){
		key=$("#key").val();
		word=$("#word").val();
		perPage=$("#perPage").val();
		//alert("...");
		
		$.ajax({
			type:"get",
			url:"/book/list.json",
			data:{"key":key, "word":word, "page":page, "perPage":perPage},
			dataType:"json",
			success:function(data){
				//alert("...");
				var temp=Handlebars.compile($("#temp").html());
				$("#tbl").html(temp(data));
				$("#count").html(data.count);
				
				if(data.count==0){
					$("#pagination").hide();
				}else{
					$("#pagination").show();
				}
				
				if(page==1){
					$("#btnPre").attr("disabled", true);
				}else{
					$("#btnPre").attr("disabled", false);
					
				}
				
				if(page==data.totPage){
					$("#btnNext").attr("disabled", true);
				}else{
					$("#btnNext").attr("disabled", false);
				}
				
				$("#spage").html(page);
				$("#stotPage").html(data.totPage);
				
			}
		});
	}

</script>
</html>