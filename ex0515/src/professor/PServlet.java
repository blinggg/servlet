package professor;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;


@WebServlet(value= {"/pro/list", "/pro/cslist","/pro/insert", "/pro/delete", "/pro/read", "/pro/update"})
public class PServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		RequestDispatcher dis=null;
		PDAO dao=new PDAO();
		PrintWriter out=response.getWriter();
		switch(request.getServletPath()){
		
			case "/pro/cslist":
				String pcode=request.getParameter("pcode");
				
				try {
					JSONObject jObject=dao.cslist(pcode);
					out.println(jObject);
				}catch(Exception e) {
					System.out.println(e.toString());
				}
				
				break;
				
				
				
			case "/pro/read":
				pcode=request.getParameter("pcode");
				
				try {
				PVO vo=dao.read(pcode);
				request.setAttribute("vo",vo);
				
				}catch(Exception e) {
					System.out.println(e.toString());
				}
				
				dis=request.getRequestDispatcher("read.jsp");
				dis.forward(request, response);
			break;
			
			case "/pro/delete":
				pcode=request.getParameter("pcode");
				try{dao.delete(pcode);
				}catch(Exception e) {
					System.out.println(e.toString());
				}
				response.sendRedirect("list");
				break;
				
			case "/pro/insert":
				dis=request.getRequestDispatcher("insert.jsp");
				dis.forward(request, response);
				break;
				
			case "/pro/list":
				try {
					request.setAttribute("list",dao.list());
				}catch(Exception e) {
					System.out.println(e.toString());
				}
				dis=request.getRequestDispatcher("list.jsp");
				dis.forward(request, response);
				break;
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		PDAO dao=new PDAO();
		switch(request.getServletPath()) {
		
		
		case "/pro/insert":
			System.out.println("post insert");
			PVO vo=new PVO();
			vo.setPcode(request.getParameter("pcode"));
			vo.setPname(request.getParameter("pname"));
			vo.setDept(request.getParameter("dept"));
			vo.setTitle(request.getParameter("title"));
			String strSalary=request.getParameter("salary");
			vo.setSalary(Integer.parseInt(strSalary));
			
			System.out.println(vo.toString());
			
			try {
				dao.insert(vo);
			}catch(Exception e) {
				System.out.println(e.toString());
			}
			response.sendRedirect("list");
			break;
			
		case "/pro/update":
			vo=new PVO();
			vo.setPcode(request.getParameter("pcode"));
			vo.setPname(request.getParameter("pname"));
			vo.setDept(request.getParameter("dept"));
			vo.setTitle(request.getParameter("title"));
			String setSalary=request.getParameter("salary");
			vo.setSalary(Integer.parseInt(setSalary));
			
			try {
				dao.update(vo);
			}catch(Exception e) {
				System.out.println(e.toString());
			}
			response.sendRedirect("list");
			break;
		}
	}

}
