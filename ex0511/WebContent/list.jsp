<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="ex02.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[사용자 목록]</title>
</head>
<body>
	<h1>사용자 목록</h1>
	<table border=1 width=300>
		<tr>
			<td>아이디</td>
			<td>비밀번호</td>
			<td>성명</td>
		</tr>
		<%	
			ArrayList<UserVO> list=
			(ArrayList<UserVO>)request.getAttribute("list");
			for(UserVO vo:list){
				out.println("<tr>");
				out.println("<td>"+vo.getId()+"</td>");
				out.println("<td>"+vo.getPass()+"</td>");
				out.println("<td>"+vo.getUname()+"</td>");
				out.println("</tr>");				
			}
		%>
	</table>
	<a href="insert">회원가입</a>
</body>
</html>