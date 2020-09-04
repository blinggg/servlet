package students;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import courses.CDAO;
import enroll.EDAO;
import enroll.EVO;
import professor.PDAO;
import professor.PVO;


@WebServlet(value= {"/stu/list", "/stu/enroll","/stu/insert", "/stu/delete", "/stu/update", "/stu/read"})
public class SServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
   
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		RequestDispatcher dis=null;
		SDAO dao=new SDAO();
		PDAO pdao=new PDAO();
		CDAO cdao=new CDAO();
		EDAO edao=new EDAO();
		switch(request.getServletPath()) { //������Ʈ�� �ּҰ� �����̴�?
		case "/stu/enroll":
			System.out.println("get/stu/enroll");
			String scode=request.getParameter("scode");
			try {
				ArrayList<EVO> slist=edao.slist(scode);
				JSONArray jArray=new JSONArray();
				for(EVO vo:slist) {
					JSONObject obj=new JSONObject();
					obj.put("lcode", vo.getLcode());
					obj.put("lname", vo.getLname());
					obj.put("edate", vo.getEdate());
					obj.put("grade", vo.getGrade());
					jArray.add(obj);
				}
				PrintWriter out=response.getWriter();
				out.println(jArray);
			}catch(Exception e){
				e.toString();
			}
				break;
			
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
			scode=request.getParameter("scode");
			try {
				request.setAttribute("clist",cdao.list());
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
		switch(request.getServletPath()) { //������Ʈ�� �ּҰ� �����̴�?
		
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
