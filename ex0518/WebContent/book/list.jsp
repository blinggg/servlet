<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
   <title>한빛 미디어</title>
   <link rel="stylesheet" href="../home.css"/>
</head>
<body>
   <div id="page">
      <div id="header"><jsp:include page="../header.jsp"/></div>
      <div id="center">
         <div id="menu"><jsp:include page="../menu.jsp"/></div>
         <div id="content">
            <!-- 여기부터 출력할 내용 작성시작 -->
            <h2>[책정보]</h2>
            <div id="search">
               <form action="list" name="frm">
                  <select name="key">
                     <option value="code"   <c:out value="${key=='code'?'selected':''}"/>>책코드</option>
                     <option value="title"  <c:out value="${key=='title'?'selected':''}"/>>책제목</option>
                     <option value="writer" <c:out value="${key=='writer'?'selected':''}"/>>책저자</option>
                  </select>
                  <input type="text" name="word" value="${word}">
                  <input type="submit" value="검색">
                  <input type="hidden" name="page" value="${page}">
                  검색수:${count}
               </form>
            </div>
            <table id="tbl" width=700>
            <tr class="title">
               <td width=100>책코드</td>
               <td width=400>책제목</td>
               <td width=100>저자</td>
               <td width=100>가격</td>
            </tr>
            <c:forEach items="${list}" var="vo">
            <tr class="row">
               <td width=100 class="center">${vo.code}</td>
               <td width=400>${vo.title}</td>
               <td width=100 class="center">${vo.writer}</td>
               <td width=100 class="number"><fmt:formatNumber value="${vo.price}" pattern="#,###원"/></td>
            </tr>
            </c:forEach>
            </table>
            <div id="pagination">
               <c:if test="${page==totPage && totPage>1}">
                        <button id="btnPre">◀</button>
                        <button id="btnNext" disabled>▶</button>
                     </c:if>
                     <c:if test="${page==1 && totPage>1}">
                        <button id="btnPre" disabled>◀</button>
                        <button id="btnNext">▶</button>
                     </c:if>
                     <c:if test="${page==1 && totPage==1}">
                        <button id="btnPre" disabled>◀</button>
                        <button id="btnNext" disabled>▶</button>
                     </c:if>
                     <c:if test="${page>1 && totPage>page}">
                        <button id="btnPre">◀</button>
                        <button id="btnNext">▶</button>
                     </c:if>
               [${page}/${totPage}]
            </div>
            <!-- 여기부터 출력할 내용 작성종료 -->
         </div>
      </div>
      <div id="footer"><jsp:include page="../footer.jsp"/></div>
   </div>
</body>
<script>
   var totPage="${totPage}";
   var page=$(frm.page).val();
   
   //이전버튼 클릭시
   $("#btnPre").on("click", function(){
      page--;
      $(frm.page).val(page);
      $(frm).submit();
   });
   
   //다음버튼 클릭시
   $("#btnNext").on("click", function(){
      page++;
      $(frm.page).val(page);
      $(frm).submit();
   });
</script>
</html>