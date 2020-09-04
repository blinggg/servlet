<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<meta name="viewport" content="user-scalable=no, width=device-width" charset="euc-kr"/>
<link href="home_mobile.css" rel="stylesheet" type="text/css" media="screen and (max-width:799px)">
<link href="home.css" rel="stylesheet" type="text/css" media="screen and (min-width:800px)">
<title>블로그검색</title>

</head>
<body>
<div id=divPage>
	<div id=divMenu><jsp:include page="menu.jsp"/></div>
	<div id="divHeader">
			<h2>블 로 그 검 색</h2>
	</div>
	<div id=divCondition>

		<input type=text id="query" value=자바>
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
				<td>제목</td>	
			</tr>

		{{#each items}}
			<tr class=row>
				<td><a href="{{link}}">{{{title}}}</a></td>
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
   var page=1, display, query, total, totPage;
   getList();
   
   $("#btnSearch").on("click",function(){
      page=1;
      getList();
   });
   
   $("#display, #query").change(function(){
      page=1;
      getList();
   });
   
   $("#btnNext").click(function(){ page++; getList(); });
   $("#btnPre").click(function(){ page--; getList(); });
   
   function getList(){
      query=$("#query").val();
      display=$("#display").val();
      var start=(page-1)*display + 1;
      
      $.ajax({
         type:"get",
         url:"/api/naver/blog",
         data:{"query":query,"display":display,"start":start},
         dataType:"json",
         success:function(data){
            var template = Handlebars.compile($("#temp").html());
             $("#tbl").html(template(data));
             
             total=data.total;
             if(total%display==0){
                totPage=total/display;
             }else{
                totPage=parseInt(total/display)+1;
             }
             
             if(page==1){
                $("#btnPre").attr("disabled",true);
             }else{ $("#btnPre").attr("disabled",false); }
             
             if(page==totPage){
                $("#btnNext").attr("disabled",true);
             }else{ $("#btnNext").attr("disabled",false);}
             
             $("#curPage").html(page);
             $("#totPage").html(totPage);
             $("#total").html(total);
         }
      });
   }
</script>
</html>