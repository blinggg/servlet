<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
				<h2>[게시판 글쓰기]</h2>
			<form action=insert method=post name=frm>
			
			<c:if test="${id==null}">
				<input type=text value=guest name=writer style="margin-bottom:10px;">
			</c:if>
			
			<c:if test="${id!=null}">
				<input type=text value="${id}" name=writer>
			</c:if>
			
			<table id=bbstbl width=500>
				<tr>
					<td>글제목</td>
					<td><input type=text size=60 name=title></td>
				</tr>
				<tr>
					<td colspan=2>
						<textarea rows=15 cols=70 name=content>내용을 입력해주세요!</textarea>
					</td>
			</table>
			
			<input type=submit value=저장>
			<input type=reset value=취소>
			</form>
			<!-- 여기부터 출력할 내용 작성종료 -->
		</div>
		<div id=footer><jsp:include page="../footer.jsp"></jsp:include></div>
		</div>
	</div>
</body>
<script>
	
	//값이 들어가있는지 체크하는 식
	$(frm).submit(function(e){
		e.preventDefault(); //서브밋 방지
		if(!confirm("저장하시겠습니까?")) return;
		
		var title=$(frm.title).val();
		var content=$(frm.content).val();
		
		alert(title+content);
		
		if(title==""){
			alert("제목을 입력하세요!");
			$(frm.title).focus();
		}else if(content==""){
			alert("내용을 입력하세요!");
			$(frm.content).focus();
		}else{
			frm.submit();
		}
		
	});

</script>
</html>