<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">

	<title>[강좌목록]</title>
<STYLE>
	#tbl td{text-align:center;border:1px solid #515A5A;}
	.title{background:#76D7C4;}
	.row:hover{background:#1ABC9C;color:white;cursor:pointer;}
	#tbl{border-collapse:collapse;}
</STYLE>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
</head>
<body>
<div><%@include file="../menu.jsp" %></div>
	<h1>[강좌목록]</h1>
	<a href=insert>강좌등록하기</a>
		<table id=tbl border=1 width=700>
			<tr class=title>
				<td>강좌번호</td>
				<td>강좌명</td>
				<td>강의시간수</td>
				<td>강의실</td>
				<td>담당교수번호</td>
				<td>교수명</td>
			</tr>
			<c:forEach items="${array}" var="vo">
			<tr class=row>
				<td class=lcode>${vo.lcode}</td>
				<td>${vo.lname}</td>
				<td>${vo.hours}</td>
				<td>${vo.room}</td>
				<td>${vo.instructor}</td>
				<td>${vo.pname}</td>
			</tr>
			</c:forEach>
		</table>
<div id=bottom><%@include file="../bottom.jsp" %></div>
</body>
<script>
	//학생정보 보기
	$("#tbl").on("click",".row", function(){
		var lcode=$(this).find(".lcode").html();
		//alert(scode);
		location.href="read?lcode="+lcode;
	});

</script>

</html>