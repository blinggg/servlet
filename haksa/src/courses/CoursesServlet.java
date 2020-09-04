package courses;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import database.SqlVO;
import professors.ProfessorsDAO;


@WebServlet(value= {"/courses/list","/courses/delete","/courses/update","/courses/read", "/courses/ck", "/courses/insert"})
public class CoursesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		CoursesDAO sdao=new CoursesDAO();
		JSONObject jObject=new JSONObject();
		
		switch(request.getServletPath()) {
		case "/courses/delete":
			int count=sdao.delete(request.getParameter("lcode"));
			jObject.put("count", count);
			out.println(jObject);
			break;
		case "/courses/read":
			request.setAttribute("vo",
					sdao.read(request.getParameter("lcode")));
			RequestDispatcher dis=request.getRequestDispatcher("read.jsp");
			dis.forward(request, response);
			break;
		case "/courses/ck":
			jObject.put("count", 
					sdao.checkCode(request.getParameter("lcode")));
			out.println(jObject);
			break;
		case "/courses/list":
			 SqlVO sqlVO=new SqlVO();
			 
			 String key=request.getParameter("key")==null?"lcode":request.getParameter("key");
			 String word=request.getParameter("word")==null?"":request.getParameter("word");
			 String order=request.getParameter("order")==null?"lcode":request.getParameter("order");
			 String desc=request.getParameter("desc")==null?"":request.getParameter("desc");
			 String page=request.getParameter("page")==null?"1":request.getParameter("page");
			 String perPage=request.getParameter("perPage")==null?"10":request.getParameter("perPage");
			 
			 sqlVO.setKey(key);
			 sqlVO.setWord(word);
			 sqlVO.setOrder(order);
			 sqlVO.setDesc(desc);
			 sqlVO.setPage(Integer.parseInt(page));
			 sqlVO.setPerPage(Integer.parseInt(perPage));
			 out.println(sdao.list(sqlVO));
			 break;
		 }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		CoursesVO vo=new CoursesVO();
		vo.setLcode(request.getParameter("lcode"));
		vo.setLname(request.getParameter("lname"));
		vo.setRoom(request.getParameter("room"));
		vo.setInstructor(request.getParameter("pcode"));
		vo.setHours(Integer.parseInt(request.getParameter("hours")));
		vo.setCapacity(Integer.parseInt(request.getParameter("capacity")));
		vo.setPersons(Integer.parseInt(request.getParameter("persons")));
		
		CoursesDAO cdao=new CoursesDAO();
		switch(request.getServletPath()) {
		case "/courses/insert":
			cdao.insert(vo);
			response.sendRedirect("list.jsp");
			break;
		case "/courses/update":
			cdao.update(vo);
			response.sendRedirect("list.jsp");
			break;			
		}
	}
}








