<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
  <link rel="stylesheet" href="../home.css">
</head>
<body>
	<div id="divPage">
		<div id="divMenu"><jsp:include page="../menu.jsp" /></div>
		<!--내용 입력 시작 ---------------------- -->
		<div id="divHeader">
			<h2>상 품 등 록</h2>
		</div>
		<form name="frm" action="insert" method="post" enctype="multipart/form-data"> <!-- 이밎 서브밋 -->
			<table id="tbl">
				<tr>
					<td class="title" width=100>상품코드</td>
					<td width=100><input type="text" name="prod_id" size=10></td>
					<td class="title" width=100>제조원/수입원</td>
					<td width=200><input type="text" name="company" size=27></td>
					<td class="title" width=100>판매가격</td>
					<td width=100><input type="text" name="price1" size=10></td>
				</tr>
				<tr>
					<td class="title">업체코드</td>
					<td colspan=3><input type="text" name="mall_id" size=10><input
						type="text" name="mall_name" size=47></td>
					<td class="title">일반가격</td>
					<td><input type="text" name="price2" size=10></td>
				</tr>
				<tr>
					<td class="title">상품이름</td>
					<td colspan=5><input type="text" name="prod_name" size=99></td>
				</tr>
				<tr>
					<td class="title">상품이미지</td>
					<td colspan=5><img src="http://placehold.it/150x120" id="image" width=150 /> 
					<input type="file" name="image"accept="image/*" style="visibility:hidden;"></td>
				</tr>
				<tr>
					<td class="title">상품설명</td>
					<td colspan=5><textarea rows="10" cols="100" name="detail"></textarea></td>
				</tr>
			</table>
			<div id="pagination">
				<input type="submit" value="저장"> 
				<input type="reset" value="취소">
			</div>
		</form>
		 <!--내용 입력 종료 ---------------------- -->
	</div>
</body>
<script>
	//업로드할 이미지 불러오기
	$("#image").on("click", function(){
		$(frm.image).click();	
	
	});
	
	//이미지 미리보기
	$(frm.image).on("change",function(e){
		var reader=new FileReader();
		reader.onload=function(e){
			$("#image").attr("src", e.target.result);
		}
		reader.readAsDataURL(this.files[0]);
	});
	
	//업체코드 가져오기
	$.ajax({
		type:"get",
		url:"id",
		dataType:"json",
		success:function(data){
			$(frm.prod_id).val(data.id);
		}
	});
	
	//업체목록 불러오기
	$(frm.mall_id).on("click", function(){
		window.open('/shop/mall/listAll.jsp','mall','width=400,height=300,top=200,left=900');
	});
</script>



</html>