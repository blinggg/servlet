<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="user.*, java.util.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[사용자 목록 출력]</title>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
</head>
<body>
	<h1>[사용자 목록]</h1>
	<a href=insert>사용자 등록</a>
	<table id=tbl border=1 width=500>
		<tr class=title>
			<td>아이디</td>
			<td>비밀번호</td>
			<td>성명</td>
			<td>삭제</td>
			<td>수정</td>
		</tr>
	<c:forEach items="${list}" var="vo"> 
		<tr class=row>
			<td class=id>${vo.id}</td>
			<td>${vo.pass}</td>
			<td><input type=text class=uname value="${vo.uname}"></td>
			<td><button class=del>삭제</button></td>
			<td><button class=update>수정</button></td>
		</tr>
	</c:forEach>
	</table>
</body>
<script>
	//삭제버튼을 클릭했을 때
	$("#tbl").on("click",".row .del", function(){
		var row=$(this).parent().parent();
		var id=row.find(".id").html();
		if(!confirm(id+"을(를) 삭제하겠습니까?")) return;
		location.href="delete?id=" + id;
	});
	
	//수정버튼을 클릭했을 때
	$("#tbl").on("click",".row .update", function(){
		var row=$(this).parent().parent();
		var id=row.find(".id").html();
		var uname=row.find(".uname").val();
		if(!confirm(uname+"을(를) 수정하겠습니까?")) return;
		location.href="update?id=" + id + "&uname=" + uname;
	});

</script>
</html>