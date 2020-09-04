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
				<h2>[사용자목록]</h2>
				<div id=search>
					<form name=frm>
						<select name=key>
							<option value=name <c:out value="${key=='name'?'selected':''}"/>>이름</option>
							<option value=id <c:out value="${key=='id'?'selected':''}"/>>아이디</option>
							<option value=job <c:out value="${key=='job'?'selected':''}"/>>직업</option>
							<option value=tel <c:out value="${key=='tel'?'selected':''}"/>>전화번호</option>
						</select>
						<input type=text name=word value="${word}">
						<input type=submit value=검색 id=btnSearch>
						검색수:${count}
						<input type=text name=page value="${page}">
					</form>
				</div>
			<table id=tbl width=700>
					<tr class=title>
						<td width=100>이름</td>
						<td>아이디</td>
						<td width=100>직업</td>
						<td width=200>전화번호</td>
					</tr>
					<c:forEach items="${list}" var="vo">
					
						<tr class=row>
						<td width=100 class=center>${vo.name}</td>
						<td>${vo.id}</td>
						<td width=100 class=center>${vo.job}</td>
						<td width=100 class=center>${vo.tel}</td>
					</tr>
				</c:forEach>
				</table>	
			<div id=pagination>
					<button id=btnPre>◀</button>
					<button id=btnNext>▶</button>
					[${page}/${totPage}]
			</div>
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