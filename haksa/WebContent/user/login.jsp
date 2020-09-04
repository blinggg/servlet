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
   <style>
      #divContent{height:500px;}
      #divContent table{margin-top:100px;}
   </style>
</head>
<body>
   <div id="divPage">
      <div id="divTop"><jsp:include page="../header.jsp"/></div>
      <div id="divCenter">
         <div id="divMenu"><jsp:include page="../menu.jsp"/></div>
         <div id="divContent">
         <!--여기에 내용출력 시작---------------------------- -->
         <form name=frm action=login method=post>
	         <table>
	            <tr>
	               <td class="title" width=300 colspan=2>
	                  <h1>로그인</h1>
	               </td>
	            </tr>
	            <tr>
	               <td class="title" width=150>아이디</td>
	               <td><input type="text" name=id></td>
	            </tr>
	            <tr>
	               <td class="title" width=150>비밀번호</td>
	               <td><input type="password" name=pass></td>
	            </tr>
	            <tr>
	               <td colspan=2 style=text-align:center;>
	               		<input type=submit value=로그인>
	               </td>
	            </tr>
	                  
	         </table>
         </form>  
         <!--여기에 내용출력 종료---------------------------- -->
         </div>
      </div>
      <div id="divBottom"><jsp:include page="../footer.jsp"/></div>
   </div>
</body>
<script>
	
	//로그인 체크하기
	$(frm).submit(function(e){
		var id=$(frm.id).val();
		var pass=$(frm.pass).val();
		e.preventDefault();
		$.ajax({
			type:"post",
			url:"login",
			data:{"id":id, "pass":pass},
			dataType:"json",
			success:function(data){
				if(data.check==0){
					alert("아이디가 존재하지 않습니다.");
				}else if(data.check==1){
					alert("아이디와 비밀번호가 틀립니다.");
				}else{
					location.href="/haksa/index.jsp";
				}
			}
			
		});
	});

</script>
</html>