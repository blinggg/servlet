<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[강좌등록]</title>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<STYLE>
	#tbl td{border:1px solid #515A5A;}
	.title{background:#76D7C4;}
	.row:hover{background:#1ABC9C;color:white;cursor:pointer;}
	#tbl{border-collapse:collapse;margin-bottom:10px;}
</STYLE>
</head>
<body>
	<h1>[강좌등록]</h1>
	<form action=insert method=post name=frm>
	<table id=tbl border=1 width=500>
		<tr>
			<td>강좌번호</td>
			<td><input type=text name=lcode maxlength=4></td>
		</tr>
		<tr>	
			<td>강좌명</td>
			<td><input type=text name=lname></td>
		</tr>
		<tr>
			<td>강의실</td>
			<td>
				<select name=room>
					<option>506</option>
					<option selected>414</option>
					<option>510</option>
					<option>304</option>
					<option>101</option>
				</select>	
			</td>
		</tr>
		<tr>
			<td>강의시간수</td>
			<td>
			<input type=radio value=2 name=hours checked>2
			<input type=radio value=3 name=hours>3
			<input type=radio value=4 name=hours>4
			</td>
		</tr>
		<tr>
			<td>지도교수</td>
			<td>
				<select name=instructor>
				<c:forEach items="${plist}" var="vo">
				<option value="${vo.pcode}">${vo.pcode}:${vo.pname}:${vo.dept}</option>
				</c:forEach>
				</select>
			</td>
		</tr>
	</table>
	<input type=submit value=저장>
	<input type=reset value=취소>
	<input type=button value=목록 onClick="location.href='list'">
	</form>
</body>
<script>

	//유효성 검사하기
	$(frm).submit(function(e){
		e.preventDefault();
		if(!confirm("저장하시겠습니까?")) return;
		var lcode=$(frm.lcode).val();
		var lname=$(frm.lname).val();
		if(lcode.length !=4){
			alert("강좌번호를 4자리로 입력하세요!");
			$(frm.lcode).focus();
		}else if(lname==""){
			alert("강좌명을 입력하세요!");
			$(frm.lname).focus();
		}else{
			frm.submit();
		}
	});

</script>
</html>