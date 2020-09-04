<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>24/7 TFS</title>
<link rel="stylesheet" href="home.css">
</head>
<body>
	<div id="divPage">
		<div id="divCenter">
			<div id="divTop"><jsp:include page="top.jsp" /></div>
			<div id="main">
				<table id="bigMenu">
					<tr>
						<td id="logo" style="width: 50%"><a href=""><img
								src="tfs_logo.JPG"></a></td>
						<td class="bigMenus"><a class=aclass href="">상품리스트</a></td>
						<td class="bigMenus"><a class=aclass href="">현황관리</a></td>
						<td class="bigMenus"><a class=aclass href="">등록관리</a></td>
						<td class="bigMenus"><a class=aclass href="">이건어때요</a></td>
					</tr>
				</table>
				<div id="divContent" style="width: 100%; margin: auto">
					<!--여기에 내용출력 시작---------------------------- -->
					<div id="content">
						<div id="banners">
							<img class=banners src=mainbanner.jpg><img class=banners
								src=sideBanner.jpg>
						</div>
					</div>
					<div id="bannerDiv">
						<table id="midMenu">
							<tr>
								<td><a class=aTag href="">공지사항</a></td>
								<td><a class=aTag href="">사회공헌</a></td>
								<td><a class=aTag href="">보도자료</a></td>
								<td><a class=aTag href="">이벤트</a></td>
								<td style="width: 55%"></td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<div id="container">
				<img id="leftBro" src=leftbro.jpg><img id="rightSis"
					src=rightsis.jpg>
				<table id="menuContainer">
					<tr style="height: 70px">
						<td id=menu1><a href=""><img src=login1.jpg></a></td>
						<td id=menu2><a href=""><img src=login2.jpg></a></td>
						<td id=menu3><a href=""><img src=ceosay.jpg></a></td>
						<td id=menu4><a href=""><img src=newdel.jpg></a></td>
					</tr>
					<tr style="height: 180px">
						<td id=menu1-1><img src=log1.jpg></td>
						<td id=menu1-2><img src=log2.jpg></td>
						<td id=menu1-3><img style="margin-bottom: 130px;" src=ceo.jpg><img
							style="margin-left: 22px;" src=button.jpg></td>
						<td id=menu1-4><img style="margin-bottom: 130px;" src=del.jpg><img
							style="margin-left: 22px;" src=button.jpg></td>
					</tr>
				</table>
			</div>
			<!--여기까지가 내용입니다.---------------------------- -->
			<div id="divFoot" style="text-align: center"><jsp:include
					page="footer.jsp" /></div>
		</div>
	</div>
</body>
</html>