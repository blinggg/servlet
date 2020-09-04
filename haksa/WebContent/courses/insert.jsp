<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>학사관리시스템</title>
	<link rel="stylesheet" href="../home.css">
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
</head>
<body>
	<div id="divPage">
		<div id="divTop"><jsp:include page="../header.jsp"/></div>
		<div id="divCenter">
			<div id="divMenu"><jsp:include page="../menu.jsp"/></div>
			<div id="divContent">
			<!--여기에 내용출력 시작---------------------------- -->
			<div id="divHeader"><h2>강 좌 등 록</h2></div>
			<form name="frm" action="insert" method="post">
		    	<table>
		        	<tr>
			            <td class="title" width=150>강좌번호</td><td><input type="text" size=10 name="lcode" value="C406"></td>
			            <td class="title" width=150>강의실</td><td><input type="text" size=5 name="room" value="302"></td>
			            <td class="title" width=150>강의시수</td><td><input type="text" size=5 name="hours" value="3"></td>
		        	</tr>
		        	<tr>
			            <td class="title" width=150>강좌이름</td><td colspan=3><input type="text" size=60 name="lname" value="자바프로그래밍"></td>
			            <td class="title">최대수강인원</td><td><input type="text" size=5 name="capacity" value="30"></td>
		        	</tr>
		        	<tr>
			            <td width=150 class="title">담당교수</td>
			            <td width=400 colspan=3>
			                <input type="text" size=5 name="pcode">
			                <input type="text" size=10 name="pname">
			            </td>
		            	<td class="title">수강신청인원</td><td><input type="text" size=5 name="persons" value="28"></td>
		        	</tr>
		    	</table>
			    <div id="pagination">
			        <input type="submit" value="저장" id="btnInsert">
			        <input type="reset" value="취소">
			    </div>
			</form>
			<!--여기에 내용출력 종료---------------------------- -->
			</div>
		</div>
		<div id="divBottom"><jsp:include page="../footer.jsp"/></div>
	</div>
</body>
<script>
	$(frm).submit(function(e){
		e.preventDefault();
		if(!confirm("새로운 강좌를 등록하시겠습니까?")) return;
		
		var lcode=$(frm.lcode).val();
		$.ajax({
			type:"get",
			url:"ck",
			data:{"lcode":lcode},
			dataType:"json",
			success:function(data){
				if(data.count==0){
					frm.submit();
				}else{
					alert("이미 사용한 코드입니다.");
					$(frm.lcode).focus();
				}
			}
		});
	});
	
	$(frm.pcode).on("click", function(){
		window.open("/haksa/professors/listAll.jsp","adivor","width=320,height=300,top=200,left=900");
	});
</script>
</html>


