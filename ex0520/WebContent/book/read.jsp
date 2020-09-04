<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
   <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
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
			<!-- 여기부터 출력할 내용 시작 -->
				<h2>[도서목록 읽기]</h2>
				<form action=update method=post name=bfrm>
				<table id=tbl width=400>
					<tr>
						<td class=title width=100>책코드</td>
						<td><input type=text value="${bookvo.code}" name=code maxlength=5 readonly></td>
					</tr>
					<tr>
						<td class=title width=100>책제목</td>
						<td><input type=text size=30px value="${bookvo.title}" name=title></td>
					</tr>
					<tr>
						<td class=title width=100>책저자</td>
						<td><input type=text value="${bookvo.writer}" name=writer></td>
					</tr>
					<tr>	
						<td class=title width=100>판매가</td>
						<td><input type=number value="${bookvo.price}" name=price></td>
					</tr>
				</table>
				<input type=submit value=수정>
				<input type=button value=삭제 id=btnDelete>
				<input type=reset value=취소>
				<input type=button value=목록 onClick="location.href='list'">
			</form>
			<!-- 여기부터 출력할 내용 작성종료 -->
		</div>
		<div id=footer><jsp:include page="../footer.jsp"></jsp:include></div>
		</div>
	</div>
</body>
<script>

	//삭제버튼을 눌렀을 때
	$("#btnDelete").on("click", function(){
		var code="${bookvo.code}";
		//alert(code);
		if(!confirm("책번호 "+code+" 의 목록을 삭제하시겠습니까?")) return;
		bfrm.action="delete";
		bfrm.method="post";
		bfrm.submit();
		alert("삭제되었습니다!");
	});
		
	//수정버튼을 눌렀을 때
	$(bfrm).submit(function(e){
		e.preventDefault();
		if(!confirm("수정하시겠습니까?")) return;
		var code=$(bfrm.code).val();
		var title=$(bfrm.title).val();
		var writer=$(bfrm.writer).val();
		var price=$(bfrm.price).val();
		
		//alert(code+title+writer+price);
		
		if(title==""){
			alert("책제목을 입력하세요!");
			$(bfrm.title).focus();
		}else if(writer==""){
			alert("책저자를 입력하세요!");
			$(bfrm.writer).focus();
		}else if(price==""){
			alert("판매가를 입력하세요!");
			$(bfrm.price).focus();
		}else{
			bfrm.submit();
			alert("수정되었습니다!");
		}
	});
</script>
</html>