package user;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.print.attribute.ResolutionSyntax;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.connector.Request;
import org.json.simple.JSONObject;


@WebServlet(value= {"/login","/logout","/user/list","/user/insert", "/user/delete", "/user/update"})
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis=null;
		UserDAO dao=new UserDAO();
		
		switch(request.getServletPath()) {
		case "/logout":
			HttpSession session=request.getSession();
			session.invalidate();
			response.sendRedirect("/login");
			break;
		case "/login":
			dis=request.getRequestDispatcher("login.jsp");
			dis.forward(request, response);
			break;
		case "/user/update":
			String id=request.getParameter("id");
			String uname=request.getParameter("uname");
			try {
				dao.update(id,uname);
				
			}catch(Exception e) {
				System.out.println(e.toString());
			}
			
			response.sendRedirect("list");
		
			break;
		
		
		case "/user/delete":
			id=request.getParameter("id");
			try {
			dao.delete(id);
			response.sendRedirect("list");
			
			}catch(Exception e) {
				System.out.println(e.toString());
			}
			break;
			
		case "/user/list":
			//System.out.println("/user/list....");
			
			try {
				ArrayList<UserVO> list=dao.list();
				request.setAttribute("list", list);
			}catch(Exception e)
				{System.out.println(e.toString());
			}
			
			dis=request.getRequestDispatcher("list.jsp");
			dis.forward(request, response);
			break;
			
		case"/user/insert":
			//System.out.println("/user/insert....");
			dis=request.getRequestDispatcher("insert.jsp");
			dis.forward(request, response);
			break;
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		UserDAO dao=new UserDAO();
		UserVO vo=null;
		String id=request.getParameter("id");
		String pass=request.getParameter("pass");
		
		switch(request.getServletPath()) {
		
		
		case "/login" :
		
			UserDAO udao=new UserDAO();
			try {
			vo=udao.loginCheck(id,pass);
			
			JSONObject jObject=new JSONObject();
			jObject.put("id",vo.getId());
			jObject.put("name",vo.getUname());
			PrintWriter out=response.getWriter();
			out.print(jObject);
			HttpSession session=request.getSession();
			session.setAttribute("id", vo.getId());
			session.setAttribute("name", vo.getUname());
			}catch(Exception e) {
				System.out.println(e.toString());
			}
			System.out.println(id+pass);
			break;
			
		case "/user/insert":
			System.out.println("/user/insert post....");
		
			String uname=request.getParameter("uname");
			
			vo=new UserVO();
			vo.setId(id);
			vo.setPass(pass);
			vo.setUname(uname);
			
			try {
				dao.insert(vo);
				response.sendRedirect("list");
			}catch(Exception e) {
				System.out.println(e.toString());
			}
			
			break;
		}
	}

}
