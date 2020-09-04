<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  

<div class="menuItem"><a href="/haksa/index.jsp">Home</a></div>


	<c:if test="${id!=null}">
		<div class="menuItem"><a href="/haksa/professors/list.jsp">교수목록</a></div>
		<div class="menuItem"><a href="/haksa/professors/insert.jsp">교수등록</a></div>
		<div class="menuItem"><a href="/haksa/students/list.jsp">학생목록</a></div>
		<div class="menuItem"><a href="/haksa/students/insert.jsp">학생등록</a></div>
		<div class="menuItem"><a href="/haksa/courses/list.jsp">강좌목록</a></div>
		<div class="menuItem"><a href="/haksa/courses/insert.jsp">강좌등록</a></div>
		<div class="menuLogin" style=float:right;>
			<span style=font-size:12px>안녕하세요! ${name}님</span>
			<a href="/haksa/user/logout">로그아웃</a>
		</div>
	</c:if>
	<c:if test="${id==null}">
		
			<div class="menuItem"><a href="/haksa/user/login.jsp">교수목록</a></div>
			<div class="menuItem"><a href="/haksa/user/login.jsp">교수등록</a></div>
			<div class="menuItem"><a href="/haksa/user/login.jsp">학생목록</a></div>
			<div class="menuItem"><a href="/haksa/user/login.jsp">학생등록</a></div>
			<div class="menuItem"><a href="/haksa/user/login.jsp">강좌목록</a></div>
			<div class="menuItem"><a href="/haksa/user/login.jsp">강좌등록</a></div>		
			<div class="menuLogin" style=float:right;>
				<a href="/haksa/user/login.jsp">로그인</a>
			</div>
	</c:if>
