package user;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.connector.Request;


@WebServlet(value= {"/user/list","/user/insert", "/user/delete", "/user/update"})
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis=null;
		UserDAO dao=new UserDAO();
		
		switch(request.getServletPath()) {
		
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
		request.setCharacterEncoding("UTF-8");
		UserDAO dao=new UserDAO();
		
		switch(request.getServletPath()) {
		
			
		case "/user/insert":
			System.out.println("/user/insert post....");
			String id=request.getParameter("id");
			String pass=request.getParameter("pass");
			String uname=request.getParameter("uname");
			
			UserVO vo=new UserVO();
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
