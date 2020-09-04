<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
<div><%@include file="../menu.jsp" %></div>
	<title>[학생목록]</title>
<STYLE>
	#tbl td{text-align:center;border:1px solid #515A5A;}
	.title{background:#76D7C4;}
	.row:hover{background:#1ABC9C;color:white;cursor:pointer;}
	#tbl{border-collapse:collapse;}
</STYLE>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
</head>
<body>
	<h1>[학생목록]</h1>
	<a href=insert>학생등록하기</a>
		<table id=tbl border=1 width=700>
			<tr class=title>
				<td>학생번호</td>
				<td>학생</td>
				<td>학과</td>
				<td>학년</td>
				<td>생년월일</td>
				<td>교수명</td>
			</tr>
			<c:forEach items="${array}" var="vo">
			<tr class=row>
				<td class=scode>${vo.scode}</td>
				<td>${vo.sname}</td>
				<td>${vo.dept}</td>
				<td>${vo.year}</td>
				<td>${vo.birthday}</td>
				<td>${vo.pname}</td>
			</tr>
			</c:forEach>
		</table>
<div id=bottom><%@include file="../bottom.jsp" %></div>
</body>
<script>
	//학생정보 보기
	$("#tbl").on("click"," .row", function(){
		var scode=$(this).find(".scode").html();
		//alert(scode);
		location.href="read?scode="+scode;
	});

</script>



</html>