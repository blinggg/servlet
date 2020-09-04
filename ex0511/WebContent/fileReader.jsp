<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 읽기</title>
</head>
<body>
	<h1>[파일 읽기]</h1>
	<%
		BufferedReader reader=null;
		try{
			String filePath=application.getRealPath("/WEB-INF/input.txt");
			reader=new BufferedReader(new FileReader(filePath));
			
			while(true){
				String str=reader.readLine();
				if(str==null){
					break;
				}
				out.println("<h1>"+str+"</h1>");
			}
			reader.close();
			
		}catch(Exception e)
		
		{out.println(e.toString());}
	
	%>
	
</body>
</html>