package ex02;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(value= {"/list", "/insert"})
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doGet....");
		RequestDispatcher dis=null;
		
		switch(request.getServletPath()) {
		case "/list":
		
			UserDAO dao=new UserDAO();
			ArrayList<UserVO> list=dao.list();
			request.setAttribute("list", list);
			dis=request.getRequestDispatcher("list.jsp");
			dis.forward(request, response);
			break;
		
		case "/insert":
			dis=request.getRequestDispatcher("join.html");
			dis.forward(request, response);
			break;
		
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		switch(request.getServletPath()) {
		case "/insert":
			System.out.println("post.....");
			//dbø° ¿˙¿Â
		}
	
	}

}
