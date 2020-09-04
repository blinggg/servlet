package ex01;

import java.io.IOException;
import java.sql.*;
import java.sql.DriverManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jdk.nashorn.internal.ir.RuntimeNode.Request;


@WebServlet("/join")
public class JoinServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String id=request.getParameter("id");
		String pass=request.getParameter("pass");
		String name=request.getParameter("uname");
		
		try { 
		     String driver = "oracle.jdbc.driver.OracleDriver";
		     String url = "jdbc:oracle:thin:@localhost:1521:xe";
		     String user = "haksa";
		     String password = "pass";

		     Class.forName(driver);
		     Connection con=DriverManager.getConnection(url, user, password);
		     
		     String sql="insert into tbl_user(id,pass,uname) values(?,?,?)";
		     PreparedStatement ps=con.prepareStatement(sql);
		     ps.setString(1, id);
		     ps.setString(2, pass);
		     ps.setString(3, name);
		     ps.execute();
		     
		     response.sendRedirect("result.jsp?name="+name);
		    
			}catch(Exception e) {
				System.out.println(e.toString());
			}
	
	}
}

