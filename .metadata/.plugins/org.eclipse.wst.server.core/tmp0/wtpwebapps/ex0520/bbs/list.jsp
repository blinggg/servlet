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
			<div id=menu><jsp:include page="../menu.jsp"></jsp:include>
			</div>
			<div id=content>
				<h2>[게시판목록]</h2>
				<div id=search>
						<select id=key>
							<option value=title>글제목</option>
							<option value=writer>작성자</option>
							<option value=wdate selected>작성일</option>
							<option value=content>글내용</option>
						</select>
						
						<input type=text id=word>
						<select id=perPage>
							<option value=5>5행씩 출력</option>
							<option value=10>10행씩 출력</option>
							<option value=15>15행씩 출력</option>
						</select>
						
						<input type=button value=검색 id=btnSearch>
						
						검색수:<span id=count></span>	
						
						<select id=order>
							<option value=seqno>글번호</option>
							<option value=title>글제목</option>
							<option value=writer>글쓴이</option>
						</select>
						
						<select id=desc>
							<option value="">오름차순</option>
							<option value=desc selected>내림차순</option>
							
						</select>
						
						<input type=button value=정렬 id=btnSort>
				</div>
				<table id=tbl width=700></table>
				<script id="temp" type="text/x-handlebars-template">
					<tr class=title>
						<td width=100>글번호</td>
						<td width=300>글제목</td>
						<td width=100>글쓴이</td>
						<td width=200>작성일</td>												
					</tr>
				{{#each list}}
					<tr class=row>
						<td class=no>{{seqno}}</td>
						<td>{{title}}</td>
						<td>{{writer}}</td>
						<td>{{wdate}}</td>
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
	</div>
</body>
<script>
	
	
	var key;
	var word;
	var page=1;
	var perPage;
	var totPage;
	var order;
	var desc;
	
	getList();
	
	//게시 글 읽기
	$("#tbl").on("click",".row",function(){
		var no=$(this).find(".no").html();
		location.href="read?no="+no;
		
	});
	
	//검색버튼을 눌렀을 때
	$("#btnSort").on("click", function(){
		page=1;
		getList();
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
	
	//검색버튼을 눌렀을 때
	$("#btnSearch").on("click", function(){
		page=1;
		getList();
	});
	
	function getList(){
		key=$("#key").val();
		word=$("#word").val();
		perPage=$("#perPage").val();
		order=$("#order").val();
		desc=$("#desc").val();
		//alert("...");
		
		$.ajax({
			type:"get",
			url:"/bbs/list.json",
			data:{"key":key, "word":word, "page":page, "perPage":perPage, "order":order, "desc":desc},
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