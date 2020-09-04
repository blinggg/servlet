/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.0.5
 * Generated at: 2020-09-04 09:37:17 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.book;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class insert_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("\t\t\t\t<h2>[도서등록]</h2>\r\n");
      out.write("\t\t\t\t<table id=tbl>\r\n");
      out.write("\t\t\t\t\t<tr class=row>\r\n");
      out.write("\t\t\t\t\t\t<td class=title>코드</td>\r\n");
      out.write("\t\t\t\t\t\t<td><input type=text id=txtCode size=50></td>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t<tr class=row>\r\n");
      out.write("\t\t\t\t\t\t<td class=title>책제목</td>\r\n");
      out.write("\t\t\t\t\t\t<td><input type=text id=txtTitle size=50></td>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t<tr class=row>\r\n");
      out.write("\t\t\t\t\t\t<td class=title>책저자</td>\r\n");
      out.write("\t\t\t\t\t\t<td><input type=text id=txtWriter size=50></td>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t<tr class=row>\r\n");
      out.write("\t\t\t\t\t\t<td class=title>가격</td>\r\n");
      out.write("\t\t\t\t\t\t<td><input type=number id=txtPrice size=50></td>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t</table>\r\n");
      out.write("\t\t\t\t<input type=button id=btnInsert value=저장>\r\n");
      out.write("\t\t\t\t<input type=reset value=취소>\r\n");
      out.write("\t\t\t<!-- 여기부터 출력할 내용 작성종료 -->\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<div id=footer>");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "../footer.jsp", out, false);
      out.write("</div>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</div>\r\n");
      out.write("</body>\r\n");
      out.write("<script>\r\n");
      out.write("\t//저장버튼을 눌렀을 때\r\n");
      out.write("\t$(\"#btnInsert\").on(\"click\", function(){\r\n");
      out.write("\t\tif(!confirm(\"등록하시겠습니까?\")) return;\r\n");
      out.write("\t\tvar code=$(\"#txtCode\").val();\r\n");
      out.write("\t\tvar title=$(\"#txtTitle\").val();\r\n");
      out.write("\t\tvar writer=$(\"#txtWriter\").val();\r\n");
      out.write("\t\tvar price=$(\"#txtPrice\").val();\r\n");
      out.write("\t\tif(code==\"\"|| title==\"\"||writer==\"\" || price==\"\"){\r\n");
      out.write("\t\t\talert(\"모든 값을 입력해주세요!\");\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t}else{\r\n");
      out.write("\t\t\t$.ajax({\r\n");
      out.write("\t\t\t\ttype:\"post\",\r\n");
      out.write("\t\t\t\turl:\"/book/insert\",\r\n");
      out.write("\t\t\t\tdata:{\"code\":code, \"title\":title, \"writer\":writer, \"price\":price},\r\n");
      out.write("\t\t\t\tdataType:\"json\",\r\n");
      out.write("\t\t\t\tsuccess:function(data){\r\n");
      out.write("\t\t\t\t\tif(data.count==0){\r\n");
      out.write("\t\t\t\t\t\talert(\"저장되었습니다~\");\r\n");
      out.write("\t\t\t\t\t\tlocation.href=\"list\";\r\n");
      out.write("\t\t\t\t\t}else{\r\n");
      out.write("\t\t\t\t\t\talert(\"이미 도서목록이 존재합니다.\");\r\n");
      out.write("\t\t\t\t\t\t$(\"#txtCode\").focus();\r\n");
      out.write("\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t});\r\n");
      out.write("\t\t}\r\n");
      out.write("\t});\r\n");
      out.write("\r\n");
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