package user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

@WebServlet(value= {"/user/login","/user/logout"})
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		switch(request.getServletPath()) {
			case "/user/logout":
				HttpSession session=request.getSession();
				session.invalidate();
				response.sendRedirect("login.jsp");
				break;
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out=response.getWriter();
		String id=request.getParameter("id");
		String pass=request.getParameter("pass");
		String name=request.getParameter("name");
		UserDAO udao=new UserDAO();
		
		switch(request.getServletPath()) {
		
		case "/user/login":
			UserVO vo=udao.login(id);
			
			int check=0; //id가 없는경우
			if(vo.getId()!=null) {
				if(vo.getPass().equals(pass)) {
					check=2;	//pass가 일치하는 경우
					HttpSession session=request.getSession();
					session.setAttribute("id", vo.getId());
					session.setAttribute("name", vo.getName());
				}else{
					check=1;	//pass가 일치하지 않는 경우
				}
			}
			System.out.println("check:"+check);
			JSONObject jObject=new JSONObject();
			jObject.put("check",check);
			out.print(jObject);
			break;
		}
	}

}
