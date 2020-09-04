<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
			<div id="divHeader"><h2>강 좌 정 보</h2></div>
			<form name="frm" action="update" method="post">
		    	<table>
		        	<tr>
			            <td class="title" width=150>강좌번호</td><td><input type="text" size=10 name="lcode" value="${vo.lcode}" readonly></td>
			            <td class="title" width=150>강의실</td><td><input type="text" size=5 name="room" value="${vo.room}"></td>
			            <td class="title" width=150>강의시수</td><td><input type="text" size=5 name="hours" value="${vo.hours}"></td>
		        	</tr>
		        	<tr>
			            <td class="title" width=150>강좌이름</td><td colspan=3><input type="text" size=60 name="lname" value="${vo.lname}"></td>
			            <td class="title">최대수강인원</td><td><input type="text" size=5 name="capacity" value="${vo.capacity}"></td>
		        	</tr>
		        	<tr>
			            <td width=150 class="title">담당교수</td>
			            <td width=400 colspan=3>
			                <input type="text" size=5 name="pcode" value="${vo.instructor}">
			                <input type="text" size=10 name="pname" value="${vo.pname}">
			            </td>
		            	<td class="title">수강신청인원</td><td><input type="text" size=5 name="persons" value="${vo.persons}"></td>
		        	</tr>
		    	</table>
			    <div id="pagination">
			        <input type="submit" value="저장" id="btnInsert">
			        <input type="reset" value="취소">
			        <input type="button" value="삭제" id="btnDelete">
			    </div>
			</form>
			<!--여기에 내용출력 종료---------------------------- -->
			<div id="divHeader"><h2>성 적 입 력</h2></div>
			<div id=divCondition style=width:790px;>
			<button id=btnUpdate>선택저장</button>
			</div>
			<table id=tbl width=790></table>
			<script id="temp" type="text/x-handlebars-template">
 				<tr class="title">
 					<td><input type=checkbox id=chkAll></td>
 					<td>학생번호</td>
 					<td>학생이름</td>
					<td>학과</td>
 					<td>지도교수</td>
 					<td>학년</td>
 					<td>수강신청일</td>
					<td width=100>점수</td>
 				</tr>
 				{{#each array}}
 				<tr class="row">
					<td style=text-align:center;><input type=checkbox class=chk></td>
 					<td class="scode">{{scode}}</td>
 					<td class="sname">{{sname}}</td>
 					<td class="dept">{{dept}}</td>
 					<td class="pname">{{pname}}</td>
 					<td class="year">{{year}}</td>
 					<td class="edate">{{edate}}</td>
					<td><input type=text value={{grade}} maxlength=3 class=grade size=3><button class=btnUpdate>수정</button></td>
 				</tr>
 				{{/each}}
 			</script>
			</div>
		</div>
		<div id="divBottom"><jsp:include page="../footer.jsp"/></div>
	</div>
</body>
<script>
	var lcode="${vo.lcode}";
	var lname="${vo.lname}";
	
	getList();
	
	//점수를 잘못 입력했을 때 alert 출력 후 원래값으로 돌려놓기
	var preGrade;
	$("#tbl").on("focus", ".row .grade", function(){
		preGrade=$(this).val();
	});
	
	$("#tbl").on("change", ".row .grade", function(){
		var row=$(this).parent().parent(e);
		var grade=row.find(".grade").val();
		if(grade<0||grade>100){
			alert("점수를 0~100 사이의 값을 입력하세요.");
			$(this).val(preGrade);
			$(this).focus();
		
		}
	});
	
	//점수 수정버튼을 눌렀을 때
	$("#tbl").on("click", ".row button", function(){
		var scode=$(this).parent().parent().find(".scode").html();
		var grade=$(this).parent().find(".grade").val();
		if(!confirm(scode+" 의 점수를 "+ grade + "점으로 수정하시겠습니까?")) return;
		
		if(grade<0 || grade>100){
			alert("점수를 다시 입력하세요!");
			$(this).parent().find(".grade").focus();			
			$(this).parent().find(".grade").val("");
		}else{
		$.ajax({
			type:"post",
			url:"/haksa/enroll/update",
			data:{"lcode":lcode,"scode":scode,"grade":grade},
			success:function(){
					}
				});
			alert("점수가 수정되었습니다.");
			getList();
			
			}

	});
	
	//선택 저장버튼을 눌렀을 때
	$("#btnUpdate").on("click", function(){
		if(!confirm("선택한 학생들의 점수를 수정하시겠습니까?")) return;
		$("#tbl .row .chk:checked").each(function(){
			var row=$(this).parent().parent();
			var scode=row.find(".scode").html();
			var grade=row.find(".grade").val();
			
			if(grade<0 || grade>100){
				alert("점수를 다시 입력하세요!");
				row.find(".grade").focus();			
				row.find(".grade").val("");
				
			}else{
			
			$.ajax({
				type:"post",
				url:"/haksa/enroll/update",
				data:{"lcode":lcode,"scode":scode,"grade":grade},
				success:function(){

					}
				});
				alert("점수가 수정되었습니다.");
				getList();
			}
		});
		
	});
		
	//전체 체크버튼 눌렀을 때
	$("#tbl").on("click","#chkAll", function(){
		if($(this).is(":checked")){
			$("#tbl .row .chk").each(function(){
				$(this).prop("checked",true);
			});
		}else{
			$("#tbl .row .chk").each(function(){
				$(this).prop("checked",false);
			});
		}
	});
	
	//각 행에 있는 체크버튼을 눌렀을 때 전체체크버튼 속성 바꾸기!
	$("#tbl").on("click", ".row .chk", function(){
		var query=true;
		$("#tbl .row .chk").each(function(){
			if(!$(this).is(":checked"))
				query=false;
		});
			if(query){
				$("#tbl #chkAll").prop("checked", true);
			}else{
				$("#tbl #chkAll").prop("checked", false);
			}
	});
			
	//성적입력 리스트 출력하기
	function getList(){
	
		$.ajax({
			type:"get",
			url:"/haksa/es",
			data:{"lcode":lcode},
			dataType:"json",
			success:function(data){
				//alert(".");
				var template = Handlebars.compile($("#temp").html());
		 		$("#tbl").html(template(data));
			}
		});	
	}
	
	$("#btnDelete").on("click", function(){
		if(!confirm(lname + "을(를) 삭제하시겠습니까?")) return;
		$.ajax({
			type:"get",
			url:"delete",
			data:{"lcode":lcode},
			dataType:"json",
			success:function(data){
				if(data.count==0){
					alert(lname + " 삭제되었습니다.");
					location.href="list.jsp";
				}else{
					alert(data.count + "명이 수강신청했습니다.");
				}
			}
		});
	});
	
	$(frm).submit(function(e){
		e.preventDefault();
		if(!confirm("강좌를 수정하시겠습니까?")) return;
		frm.submit();
	});
	
	$(frm.pcode).on("click", function(){
		window.open("/haksa/professors/listAll.jsp","adivor","width=320,height=300,top=200,left=900");
	});
</script>
</html>


