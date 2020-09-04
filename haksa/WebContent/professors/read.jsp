<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>학사관리시스템</title>
	<link rel="stylesheet" href="../home.css">
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
   	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
</head>
<body>
	<div id="divPage">
		<div id="divTop"><jsp:include page="../header.jsp"/></div>
		<div id="divCenter">
			<div id="divMenu"><jsp:include page="../menu.jsp"/></div>
			<div id="divContent">
			<!--여기에 내용출력 시작---------------------------- -->
			<div id="divHeader"><h2>교 수 정 보</h2></div>
			<form name="frm" action="update" method="post">
 				<table>
 					<tr>
 						<td width=100 class="title">교수번호</td>
 						<td width=100><input type="text" name="pcode" size=10  value="${vo.pcode}" readonly></td>
 						<td width=100 class="title">교수학과</td>
						<td width=100>
 							<select name="dept">
 								<option <c:out value="${vo.dept=='전산'?'selected':''}"/>>전산</option>
 								<option <c:out value="${vo.dept=='전자'?'selected':''}"/>>전자</option>
 								<option <c:out value="${vo.dept=='건축'?'selected':''}"/>>건축</option>
							</select>
 						</td>
 						<td width=100 class="title">임용일자</td>
 						<td>
 							<input type="text" name="yy"  maxlength=4 size=2 value="${fn:substring(vo.hiredate,0,4)}">년
 							<input type="text" name="mm"  maxlength=4 size=2 value="${fn:substring(vo.hiredate,5,7)}">월
 							<input type="text" name="dd"  maxlength=4 size=2 value="${fn:substring(vo.hiredate,8,10)}">일
 						</td>
 					</tr>
 					<tr>
 						<td width=100 class="title">교수이름</td>
 						<td width=100><input type="text" name="pname" value="${vo.pname}" size=10></td>
 						<td width=100 class="title">교수급여</td>
 						<td><input type="text" name="salary" value="${vo.salary}"></td>
 						<td width=100 class="title">교수직급</td>
 						<td>
 							<input type="radio" value=정교수 name="title" <c:out value="${vo.title=='정교수'?'checked':''}"/>>정교수
 							<input type="radio" value=부교수 name="title" <c:out value="${vo.title=='부교수'?'checked':''}"/>>부교수
 							<input type="radio" value=조교수 name="title" <c:out value="${vo.title=='조교수'?'checked':''}"/>>조교수
 						</td>
 					</tr>
 				</table>
 				<div id="pagination">
 				<input type=submit value=수정>
 				<input type=reset value=취소>
 				<input type=button value=삭제 id=btnDelete>
 				</div>
 			</form>
 			<table id="ctbl" style=width:810px;></table>
			<script id="ctemp" type="text/x-handlebars-template">
 				<tr class="title">
 					<td>강좌번호</td>
 					<td>강좌이름</td>
 					<td>강의실</td>
 					<td>강의시수</td>
 					<td>최대수강인원</td>
					<td>수강신청인원</td>
					<td>강좌정보</td>
 				</tr>
 				{{#each cArray}}
 				<tr class="row">
 					<td class="lcode">{{lcode}}</td>
 					<td class="lname">{{lname}}</td>
 					<td class="room">{{room}}</td>
 					<td class="hours">{{hours}}</td>
 					<td class="capacity">{{capacity}}</td>
 					<td class="persons">{{persons}}</td>
					<td><button id=btncour>강좌정보</button>
 				</tr>
 				{{/each}}
 			</script>
 			<table id="stbl" style=width:810px;></table>
			<script id="stemp" type="text/x-handlebars-template">
 				<tr class="title">
 					<td>학생번호</td>
 					<td>학생이름</td>
					<td>학생학과</td>					
					<td>학년</td>
 					<td>생년월일</td>
					<td>학생정보</td>
 				</tr>
 				{{#each sArray}}
 				<tr class="row">
 					<td class="scode">{{scode}}</td>
 					<td class="sname">{{sname}}</td>
 					<td class="dept">{{dept}}</td>
 					<td class="year">{{year}}</td>
 					<td class="birthday">{{birthday}}</td>
					<td><button id=btnstu>학생정보</button></td>
 				</tr>
 				{{/each}}
 			</script>		
			<!--여기에 내용출력 종료---------------------------- -->
			</div>
		</div>
		<div id="divBottom"><jsp:include page="../footer.jsp"/></div>
	</div>
</body>
<script>

	var pcode="${vo.pcode}";
	var pname="${vo.pname}";
	
	//강좌정보로 이동하기
	$("#ctbl").on("click",".row button", function(){
		var lcode=$(this).parent().parent().find(".lcode").html();
		alert(lcode);
		location.href="../courses/read?lcode="+lcode;
	});
	
	//학생정보로 이동하기
	$("#stbl").on("click",".row button", function(){
		var scode=$(this).parent().parent().find(".scode").html();
		alert(scode);
		location.href="../students/read?scode="+scode;
	});
	
	getList();
	
	function getList(){
		pcode=$(frm.pcode).val();
		$.ajax({
			type:"get",
			url:"cslist",
			data:{"pcode":pcode},
			dataType:"json",
			success:function(data){
				alert(pcode);
				var template = Handlebars.compile($("#ctemp").html());
		 		$("#ctbl").html(template(data));
				var template = Handlebars.compile($("#stemp").html());
		 		$("#stbl").html(template(data));
			}

		});
		
	}
	
	//alert(pcode,pname);
	
	//교수정보 삭제하기
	$("#btnDelete").on("click",function(){
		if(!confirm(pname+"교수를 삭제하시겠습니까?")) return;
		$.ajax({
			type:"get",
			url:"delete",
			data:{"pcode":pcode},
			dataType:"json",
			success:function(data){
				if(data.scount==0 && data.ccount==0){
					alert("삭제되었습니다!");
					location.href="list.jsp";
				}else{
					alert("지도학생:"+data.scount+"담당과목:"+data.ccount);
				}
			}
		});
	});
	
	//교수 정보 수정하기
	$(frm).submit(function(e){
		e.preventDefault();
		if(!confirm("교수 정보를 수정하시겠습니까?")) return;	
			frm.submit();
	});

</script>
<script src="../home.js"></script>
</html>