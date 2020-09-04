 var key, word, order, desc, perPage, page=1;
 getList();

 $("#btnSearch").on("click", function(){ page=1; getList(); });
 $("#selOrder, #selDesc, #selPerPage").change(function(){ page=1; getList(); });
 $("#txtWord").keydown(function(key){
 	if(key.keyCode==13){ page=1; getList(); }
 });
 $("#btnNext").click(function(){ page++; getList(); });
 $("#btnPre").click(function(){ page--; getList(); });

 //교수목록 출력을 위한 함수
 function getList(){
 	key=$("#selKey").val();
 	word=$("#txtWord").val();
 	order=$("#selOrder").val();
 	desc=$("#selDesc").val();
 	perPage=$("#selPerPage").val();
 	$.ajax({
 		type:"get", 
 		url:url,
 		data:{"key":key,"word":word,"page":page,"perPage":perPage,"order":order,"desc":desc},
 		dataType:"json",
 		success:function(data){ 		
	 		var template = Handlebars.compile($("#temp").html());
	 		$("#tbl").html(template(data));
	 		
	 		if(data.page==1){
	 			$("#btnPre").attr("disabled",true);
	 		}else{ $("#btnPre").attr("disabled",false); }
	 		
	 		if(data.page==data.totPage){
	 			$("#btnNext").attr("disabled",true);
	 		}else{ $("#btnNext").attr("disabled",false);}
	 		
	 		$("#curPage").html(data.page);
	 		$("#totPage").html(data.totPage);
	 		$("#count").html(data.count);	
 		}
 	});
 }