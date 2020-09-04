<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
				<h2>[도서목록]</h2>
				<div id=search>
					<form name=frm>
						<select name=key>
							<option value=code <c:out value="${key=='code'?'selected':''}"/>>책코드</option>
							<option value=title <c:out value="${key=='title'?'selected':''}"/>>책제목</option>
							<option value=writer <c:out value="${key=='writer'?'selected':''}"/>>책저자</option>
						</select>
						<input type=text name=word value="${word}">
						<input type=submit value=검색 id=btnSearch>
						검색수:${count}
						<input type=text name=page value="${page}">
					</form>
				</div>
				<table id=tbl width=700>
					<tr class=title>
						<td>책코드</td>
						<td>책제목</td>
						<td>책저자</td>
						<td>판매가</td>
					</tr>
					<c:forEach items="${list}" var="vo">
					
						<tr class=row>
						<td class=center>${vo.code}</td>
						<td>${vo.title}</td>
						<td class=center>${vo.writer}</td>
						<td class=number><fmt:formatNumber value="${vo.price}" pattern="#,###원"></fmt:formatNumber></td>
					</tr>
				</c:forEach>
				</table>
				<div id=pagination>
					<button id=btnPre>◀</button>
					<button id=btnNext>▶</button>
					[${page}/${totPage}]
				</div>
		
			<!-- 여기부터 출력할 내용 작성종료 -->
		</div>
		<div id=footer><jsp:include page="../footer.jsp"></jsp:include></div>
		</div>
	</div>
</body>
<script>
	var totPage="${totPage}";
	var count="${count}";
	var page="${page}";
	
	//이전버튼 사용중지
	if(page==1){
        $("#btnPre").attr('disabled','true');
	}
	
	//다음버튼 사용중지
	if(page==totPage){
        $("#btnNext").attr('disabled','true');
  	}
	
	//검색결과가 없을 때 이전, 다음 페이지 숨기기
	if(count==0){
		$("#pagination").hide();
	}
	
	//검색버튼을 눌렀을 때(1페이지로 출력하기)
	$("#btnSearch").on("click", function(){
		alert("!");
		$(frm.page).val(1);
		$(frm).submit();
	});
	
	//엔터키를 눌렀을 때
	/*$(frm.word).keydown(function(key){
		if(key.keyCode==13){
			$(frm.page).val(1);
			$(frm).submit();
		}
	});*/
	
	//이전버튼을 눌렀을 때
	$("#btnPre").on("click", function(){
		page--;
		$(frm.page).val(page);
		$(frm).submit();
	
	});
	
	//다음버튼을 눌렀을 때
	$("#btnNext").on("click", function(){
		page++
		$(frm.page).val(page);
		$(frm).submit();
	
	});

	

</script>
</html>