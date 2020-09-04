package courses;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import professor.PDAO;
import professor.PVO;
import students.SDAO;
import students.SVO;


@WebServlet(value= {"/cou/list", "/cou/insert", "/cou/delete", "/cou/read", "/cou/update"})
public class CServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis=null;
		CDAO dao=new CDAO();
		PDAO pdao=new PDAO();
		
		switch(request.getServletPath()) {
		case "/cou/list":
			System.out.println("/cou/get/list");
			try {
				ArrayList<CVO> list=dao.list();
				request.setAttribute("array", list);
			}catch(Exception e) {
				System.out.println(e.toString());
			}
			
			dis=request.getRequestDispatcher("list.jsp");
			dis.forward(request, response);
			break;
			
		case "/cou/insert":
			System.out.println("/cou/get/insert");

			try {
				ArrayList<PVO> plist=pdao.list();
				request.setAttribute("plist", plist);
			}catch(Exception e) {
				System.out.println(e.toString());
			}
			dis=request.getRequestDispatcher("insert.jsp");
			dis.forward(request, response);
			
			break;
		case "/cou/delete":
			System.out.println("/cou/get/delete");
			break;
		case "/cou/read":
			System.out.println("/cou/get/read");
			String lcode=request.getParameter("lcode");
			try {
				request.setAttribute("vo",dao.read(lcode));
				ArrayList<PVO> plist=pdao.list();
				request.setAttribute("plist", plist);
			}catch(Exception e) {
				System.out.println(e.toString());
			}
			
			dis=request.getRequestDispatcher("read.jsp");
			dis.forward(request, response);
			break;
		case "/cou/update":
			System.out.println("/cou/get/update");
			break;
			
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		CDAO dao=new CDAO();
		CVO vo=new CVO();
		switch(request.getServletPath()) {
		case "/cou/list":
			System.out.println("/cou/post/list");
			break;
			
		case "/cou/insert":
			System.out.println("/cou/post/insert");
			try {
	            vo.setLcode(request.getParameter("lcode"));
	            vo.setLname(request.getParameter("lname"));
	            vo.setRoom(request.getParameter("room"));
	            String hours=request.getParameter("hours");
	            vo.setHours(Integer.parseInt(hours));
	            vo.setInstructor(request.getParameter("instructor"));
	            System.out.println(vo.getInstructor());
	            dao.insert(vo);
	         }catch(Exception e) {
	            System.out.println(e.toString());
	         }
	         response.sendRedirect("list");
			break;
			
		case "/cou/delete":
			System.out.println("/cou/post/delete");
			String lcode=request.getParameter("lcode");
			try{dao.delete(lcode);
			}catch(Exception e) {
				System.out.println(e.toString());
			}
			response.sendRedirect("list");
			break;
		case "/cou/read":
			System.out.println("/cou/post/read");
			break;
		case "/cou/update":
			System.out.println("/cou/post/update");
			vo.setLcode(request.getParameter("lcode"));
			vo.setLname(request.getParameter("lname"));
			String hours=request.getParameter("hours");
			vo.setHours(Integer.parseInt(hours));
			vo.setRoom(request.getParameter("room"));
			vo.setInstructor(request.getParameter("instructor"));
			System.out.println(vo.toString());
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
