/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.0.5
 * Generated at: 2020-09-04 09:37:19 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.user;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class list_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<meta charset=\"UTF-8\">\r\n");
      out.write("   <script src=\"http://code.jquery.com/jquery-1.9.1.js\"></script>\r\n");
      out.write("   <script src=\"https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js\"></script>\r\n");
      out.write("   \r\n");
      out.write("<title>한빛미디어</title>\r\n");
      out.write("\t<link rel=\"stylesheet\" href=\"../home.css\"/>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("\t<div id=page>\r\n");
      out.write("\t\t<div id=header>");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "../header.jsp", out, false);
      out.write("</div>\r\n");
      out.write("\t\t<div id=center>\r\n");
      out.write("\t\t\t<!-- 여기부터 출력할 내용 -->\r\n");
      out.write("\t\t\t<div id=menu>");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "../menu.jsp", out, false);
      out.write("\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t\t<div id=content>\r\n");
      out.write("\t\t\t\t<h2>[회원목록]</h2>\r\n");
      out.write("\t\t\t\t<div id=search>\r\n");
      out.write("\t\t\t\t\t\t<select id=key>\r\n");
      out.write("\t\t\t\t\t\t\t<option value=id>아이디</option>\r\n");
      out.write("\t\t\t\t\t\t\t<option value=name>이름</option>\r\n");
      out.write("\t\t\t\t\t\t\t<option value=job>직업</option>\r\n");
      out.write("\t\t\t\t\t\t\t<option value=tel>전화번호</option>\r\n");
      out.write("\t\t\t\t\t\t</select>\r\n");
      out.write("\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t<input type=text id=word>\r\n");
      out.write("\t\t\t\t\t\t<select id=perPage>\r\n");
      out.write("\t\t\t\t\t\t\t<option value=5>5행씩 출력</option>\r\n");
      out.write("\t\t\t\t\t\t\t<option value=10>10행씩 출력</option>\r\n");
      out.write("\t\t\t\t\t\t\t<option value=15>15행씩 출력</option>\r\n");
      out.write("\t\t\t\t\t\t</select>\r\n");
      out.write("\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t<input type=button value=검색 id=btnSearch>\r\n");
      out.write("\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t검색수:<span id=count></span>\t\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t<table id=tbl width=700></table>\r\n");
      out.write("\t\t\t\t<script id=\"temp\" type=\"text/x-handlebars-template\">\r\n");
      out.write("\t\t\t\t\t<tr class=title>\r\n");
      out.write("\t\t\t\t\t\t<td width=100>아이디</td>\r\n");
      out.write("\t\t\t\t\t\t<td width=300>이름</td>\r\n");
      out.write("\t\t\t\t\t\t<td width=100>직업</td>\r\n");
      out.write("\t\t\t\t\t\t<td width=200>전화번호</td>\t\t\t\t\t\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t{{#each list}}\r\n");
      out.write("\t\t\t\t\t<tr class=row>\r\n");
      out.write("\t\t\t\t\t\t<td>{{id}}</td>\r\n");
      out.write("\t\t\t\t\t\t<td>{{name}}</td>\r\n");
      out.write("\t\t\t\t\t\t<td>{{job}}</td>\r\n");
      out.write("\t\t\t\t\t\t<td>{{tel}}</td>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t{{/each}}\r\n");
      out.write("\t\t\t</script>\r\n");
      out.write("\t\t\t<div id=pagination style=\"margin-top:10px;text-align:center;\">\r\n");
      out.write("\t\t\t\t<button id=btnPre>◀</button>\r\n");
      out.write("\t\t\t\t<button id=btnNext>▶</button>\r\n");
      out.write("\t\t\t\t[<span id=spage></span>\r\n");
      out.write("\t\t\t\t/<span id=stotPage></span>]\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t\t<!-- 여기부터 출력할 내용 작성종료 -->\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<div id=footer>");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "../footer.jsp", out, false);
      out.write("</div>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</div>\r\n");
      out.write("</body>\r\n");
      out.write("<script>\r\n");
      out.write("\tvar key;\r\n");
      out.write("\tvar word;\r\n");
      out.write("\tvar page=1;\r\n");
      out.write("\tvar perPage;\r\n");
      out.write("\tvar totPage;\r\n");
      out.write("\t\r\n");
      out.write("\tgetList();\r\n");
      out.write("\t\r\n");
      out.write("\t//출력할 데이터를 선택하는 순간 데이터 보이기\r\n");
      out.write("\t$(\"#perPage\").change(function(){\r\n");
      out.write("\t\tpage=1;\r\n");
      out.write("\t\tgetList();\r\n");
      out.write("\t});\r\n");
      out.write("\t\r\n");
      out.write("\t//첫 페이지일때 이전버튼 속성정하기\r\n");
      out.write("\tif(page==1){\r\n");
      out.write("\t\t$(\"#btnPre\").attr(\"disabled\", true);\r\n");
      out.write("\t}else{\r\n");
      out.write("\t\t$(\"#btnPre\").attr(\"disabled\", false);\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\t//마지막 페이지일때 다음 버튼 속성정하기\r\n");
      out.write("\tif(page==totPage){\r\n");
      out.write("\t\t$(\"#btnNext\").attr(\"disabled\", true);\r\n");
      out.write("\t}else{\r\n");
      out.write("\t\t$(\"#btnNext\").attr(\"disabled\", false);\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\t//이전버튼을 눌렀을 때\r\n");
      out.write("\t$(\"#btnPre\").on(\"click\",function(){\r\n");
      out.write("\t\tpage--;\r\n");
      out.write("\t\tgetList();\r\n");
      out.write("\t});\r\n");
      out.write("\t\r\n");
      out.write("\t//다음 버튼을 눌렀을 때\r\n");
      out.write("\t$(\"#btnNext\").on(\"click\",function(){\r\n");
      out.write("\t\tpage++;\r\n");
      out.write("\t\tgetList();\r\n");
      out.write("\t});\r\n");
      out.write("\t\r\n");
      out.write("\t//검색 후 엔터키를 눌렀을 때\r\n");
      out.write("\t$(\"#word\").keydown(function(key){\r\n");
      out.write("\t\tif(key.keyCode==13){\r\n");
      out.write("\t\t\tpage=1;\r\n");
      out.write("\t\t\tgetList();\r\n");
      out.write("\t\t}\r\n");
      out.write("\t});\r\n");
      out.write("\t\r\n");
      out.write("\t//검색 버튼을 눌렀을 때\r\n");
      out.write("\t$(\"#btnSearch\").on(\"click\", function(){\r\n");
      out.write("\t\tpage=1;\r\n");
      out.write("\t\tgetList();\r\n");
      out.write("\t});\r\n");
      out.write("\t\r\n");
      out.write("\tfunction getList(){\r\n");
      out.write("\t\tkey=$(\"#key\").val();\r\n");
      out.write("\t\tword=$(\"#word\").val();\r\n");
      out.write("\t\tperPage=$(\"#perPage\").val();\r\n");
      out.write("\t\t//alert(\"...\");\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t$.ajax({\r\n");
      out.write("\t\t\ttype:\"get\",\r\n");
      out.write("\t\t\turl:\"/user/list.json\",\r\n");
      out.write("\t\t\tdata:{\"key\":key, \"word\":word, \"page\":page, \"perPage\":perPage},\r\n");
      out.write("\t\t\tdataType:\"json\",\r\n");
      out.write("\t\t\tsuccess:function(data){\r\n");
      out.write("\t\t\t\t//alert(\"...\");\r\n");
      out.write("\t\t\t\tvar temp=Handlebars.compile($(\"#temp\").html());\r\n");
      out.write("\t\t\t\t$(\"#tbl\").html(temp(data));\r\n");
      out.write("\t\t\t\t$(\"#count\").html(data.count);\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\tif(data.count==0){\r\n");
      out.write("\t\t\t\t\t$(\"#pagination\").hide();\r\n");
      out.write("\t\t\t\t}else{\r\n");
      out.write("\t\t\t\t\t$(\"#pagination\").show();\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\tif(page==1){\r\n");
      out.write("\t\t\t\t\t$(\"#btnPre\").attr(\"disabled\", true);\r\n");
      out.write("\t\t\t\t}else{\r\n");
      out.write("\t\t\t\t\t$(\"#btnPre\").attr(\"disabled\", false);\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\tif(page==data.totPage){\r\n");
      out.write("\t\t\t\t\t$(\"#btnNext\").attr(\"disabled\", true);\r\n");
      out.write("\t\t\t\t}else{\r\n");
      out.write("\t\t\t\t\t$(\"#btnNext\").attr(\"disabled\", false);\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t$(\"#spage\").html(page);\r\n");
      out.write("\t\t\t\t$(\"#stotPage\").html(data.totPage);\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t});\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("</script>\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}