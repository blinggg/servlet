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
				<h2>[도서등록]</h2>
				<table id=tbl>
					<tr class=row>
						<td class=title>코드</td>
						<td><input type=text id=txtCode size=50></td>
					</tr>
					<tr class=row>
						<td class=title>책제목</td>
						<td><input type=text id=txtTitle size=50></td>
					</tr>
					<tr class=row>
						<td class=title>책저자</td>
						<td><input type=text id=txtWriter size=50></td>
					</tr>
					<tr class=row>
						<td class=title>가격</td>
						<td><input type=number id=txtPrice size=50></td>
					</tr>
				
				</table>
				<input type=button id=btnInsert value=저장>
				<input type=reset value=취소>
			<!-- 여기부터 출력할 내용 작성종료 -->
		</div>
		<div id=footer><jsp:include page="../footer.jsp"></jsp:include></div>
		</div>
	</div>
</body>
<script>
	//저장버튼을 눌렀을 때
	$("#btnInsert").on("click", function(){
		if(!confirm("등록하시겠습니까?")) return;
		var code=$("#txtCode").val();
		var title=$("#txtTitle").val();
		var writer=$("#txtWriter").val();
		var price=$("#txtPrice").val();
		if(code==""|| title==""||writer=="" || price==""){
			alert("모든 값을 입력해주세요!");
			
		}else{
			$.ajax({
				type:"post",
				url:"/book/insert",
				data:{"code":code, "title":title, "writer":writer, "price":price},
				dataType:"json",
				success:function(data){
					if(data.count==0){
						alert("저장되었습니다~");
						location.href="list";
					}else{
						alert("이미 도서목록이 존재합니다.");
						$("#txtCode").focus();
					}
					
				}
			});
		}
	});


</script>
</html>