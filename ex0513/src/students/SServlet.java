package students;

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


@WebServlet(value= {"/stu/list", "/stu/insert", "/stu/delete", "/stu/update", "/stu/read"})
public class SServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
   
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis=null;
		SDAO dao=new SDAO();
		PDAO pdao=new PDAO();
		switch(request.getServletPath()) { //리퀘스트의 주소가 무엇이니?
		case "/stu/list":
			//System.out.println("get/stu/list");
			try {
				ArrayList<SVO> list=dao.list();
				request.setAttribute("array", list);
			}catch(Exception e) {
				System.out.println(e.toString());
			}
			
			dis=request.getRequestDispatcher("list.jsp");
			dis.forward(request, response);
			break;
		case "/stu/insert":
			//System.out.println("get/stu/insert");
			
			try {
				ArrayList<PVO> plist=pdao.list();
				request.setAttribute("plist", plist);
			}catch(Exception e) {
				System.out.println(e.toString());
			}
			dis=request.getRequestDispatcher("insert.jsp");
			dis.forward(request, response);
			break;
		case "/stu/delete":
			
		case "/stu/update":
			System.out.println("get/stu/update");
			break;
		case "/stu/read":
			System.out.println("get/stu/read");
			String scode=request.getParameter("scode");
			try {
				request.setAttribute("vo",dao.read(scode));
				ArrayList<PVO> plist=pdao.list();
				request.setAttribute("plist", plist);
			}catch(Exception e) {
				System.out.println(e.toString());
			}
			
			dis=request.getRequestDispatcher("read.jsp");
			dis.forward(request, response);
			break;
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		SDAO dao=new SDAO();
		SVO vo=new SVO();
		switch(request.getServletPath()) { //리퀘스트의 주소가 무엇이니?
		
		case "/stu/list":
			break;
			
		case "/stu/insert":
			System.out.println("post/stu/insert");
			System.out.println("post/stu/list");
			vo.setScode(request.getParameter("scode"));
			vo.setSname(request.getParameter("sname"));
			vo.setDept(request.getParameter("dept"));
			String year=request.getParameter("year");
			vo.setYear(Integer.parseInt(year));
			vo.setBirthday(request.getParameter("birthday"));
			vo.setAdvisor(request.getParameter("advisor"));
			System.out.println(vo.toString());
			try {
				dao.insert(vo);
			}catch(Exception e) {
				System.out.println(e.toString());
			}
			response.sendRedirect("list");
			break;
			
		case "/stu/delete":
			System.out.println("post/stu/delete");
			String scode=request.getParameter("scode");
			try{dao.delete(scode);
			}catch(Exception e) {
				System.out.println(e.toString());
			}
			response.sendRedirect("list");
			break;
			
		case "/stu/update":
			System.out.println("post/stu/update");
			vo.setScode(request.getParameter("scode"));
			vo.setSname(request.getParameter("sname"));
			vo.setDept(request.getParameter("dept"));
			year=request.getParameter("year");
			vo.setYear(Integer.parseInt(year));
			vo.setBirthday(request.getParameter("birthday"));
			vo.setAdvisor(request.getParameter("advisor"));
			System.out.println(vo.toString());
			try {
				dao.update(vo);
			}catch(Exception e) {
				System.out.println(e.toString());
			}
			response.sendRedirect("list");
			break;
		case "/stu/read":
			System.out.println("post/stu/read");
			break;
		}
	}

}
