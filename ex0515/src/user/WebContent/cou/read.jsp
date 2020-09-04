<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[강좌정보]</title>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script> 
<STYLE>
	#tbl td,#etbl td{border:1px solid #515A5A;}
	.title{background:#76D7C4;}
	.row:hover{background:#1ABC9C;color:white;cursor:pointer;}
	#tbl, #etbl{border-collapse:collapse;margin-bottom:10px;}
	#etbl{text-align:center;}
	select{height:25px;}
</STYLE>
</head>
<body>
	<h1>[강좌정보]</h1>
	<form action=update method=post name=frm>
	<table id=tbl border=1 width=500>
		<tr>
			<td>강좌번호</td>
			<td><input type=text name=lcode maxlength=4 value="${vo.lcode}" readonly></td>
		</tr>
		<tr>	
			<td>강좌명</td>
			<td><input type=text name=lname value="${vo.lname}"></td>
		</tr>
		<tr>
			<td>강의실</td>
			<td>
				<select name=room>
					<option <c:out value="${vo.room.equals('506')?'selected':''}"/>>506</option>
					<option <c:out value="${vo.room.equals('414')?'selected':''}"/>>414</option>
					<option <c:out value="${vo.room.equals('510')?'selected':''}"/>>510</option>
					<option <c:out value="${vo.room.equals('304')?'selected':''}"/>>304</option>
					<option <c:out value="${vo.room.equals('101')?'selected':''}"/>>101</option>
				</select>	
			</td>
		</tr>
		<tr>
			<td>강의시간수</td>
			<td>
			<input type=radio value=2 name=hours <c:out value="${vo.hours==2?'checked':''}"/>>2
			<input type=radio value=3 name=hours <c:out value="${vo.hours==3?'checked':''}"/>>3
			<input type=radio value=4 name=hours <c:out value="${vo.hours==4?'checked':''}"/>>4
			</td>
		</tr>
		<tr>
			<td>지도교수</td>
			<td>
				<select name=instructor>
				<c:forEach items="${plist}" var="v">
					<option value="${v.pcode}" <c:out value="${vo.instructor==v.pcode?'selected':''}"/>>${v.pcode}:${v.pname}:${v.dept}</option>
				</c:forEach>
				</select>
			</td>
		</tr>
	</table>
	<input type=submit value=수정>
	<input type=button value=삭제 id=btnDelete> 
	<input type=reset value=취소>
	<input type=button value=목록 onClick="location.href='list'">
	</form>
	<div id=enroll>
		<h1>[수강신청]</h1>
		<table id=etbl border=1 width=500></table>
		<script id="temp" type="text/x-handlebars-template">
			<tr class=title>
				<td>학생코드</td>
				<td>학생명</td>
				<td>수강신청일</td>
				<td>점수</td>
				<td>점수수정</td>
			</tr>

			{{#each.}}
			<tr class=row>
				<td class=scode>{{scode}}</td>
				<td>{{sname}}</td>
				<td>{{edate}}</td>
				<td><input class=grade type=text value={{grade}} size=5></td>
				<td><button>점수수정</button></td>
			</tr>
			{{/each}}
	</script>
	</div>
	
	
</body>
<script>
	var lcode="${vo.lcode}";
	
	getList();
	//수정버튼을 클릭했을 때
	$("#etbl").on("click", ".row button", function(){
		//alert("수정");
		var row=$(this).parent().parent();
		var scode=row.find(".scode").html();
		var grade=row.find(".grade").val();
		//alert(scode+grade);
		if(!confirm(scode+"학생의 점수를 수정하시겠습니까?")) return;
		if(grade<0 || grade>100){
			alert("점수를 다시 입력하세요!");
			row.find(".grade").focus();
			row.find(".grade").val("");
			
		}else{
			
			$.ajax({
				type:"post",
				url:"/enroll/update",
				data:{"lcode":lcode, "grade":grade, "scode":scode},
				dataType:"json",
				success:function(data){
					//alert(".");
					var temp=Handlebars.compile($("#temp").html());
			     	$("#etbl").html(temp(data));
			}
		});
			alert("수정되었습니다!");
	}
});
	
	//특정강좌를 수강신청한 학생목록 보이기
	function getList(){
		$.ajax({
			type:"get",
			url:"/cou/enroll",
			data:{"lcode":lcode},
			dataType:"json",
			success:function(data){
				//alert(".");
				var temp=Handlebars.compile($("#temp").html());
		     	$("#etbl").html(temp(data));
		}
	});
}

	//유효성 검사하기
	$(frm).submit(function(e){
		e.preventDefault();
		if(!confirm("수정하시겠습니까?")) return;
			frm.submit();
	});
	
	//삭제버튼을 눌렀을 때
	$("#btnDelete").on("click", function(){
		var lcode="${vo.lcode}";
		if(!confirm("학번"+lcode+"의 학생목록을 삭제하시겠습니까?")) return;
		frm.action="delete";
		frm.method="post";
		frm.submit();
	});


</script>
</html>