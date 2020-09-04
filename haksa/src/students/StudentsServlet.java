package students;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import courses.CoursesDAO;
import database.SqlVO;
import professors.ProfessorsDAO;


@WebServlet(value= {"/students/list","/students/read", "/students/update", "/students/insert", "/students/delete"})
public class StudentsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		StudentsDAO sdao=new StudentsDAO();
		CoursesDAO cdao=new CoursesDAO();
		switch(request.getServletPath()) {
		
		case "/students/read":
			StudentsVO vo=sdao.read(request.getParameter("scode"));
			request.setAttribute("vo", vo);
			request.setAttribute("clist", cdao.listAll());
			RequestDispatcher dis=request.getRequestDispatcher("read.jsp");
			dis.forward(request, response);
			break;
		case "/students/list":
			 SqlVO sqlVO=new SqlVO();
			 String key=request.getParameter("key")==null?"scode":request.getParameter("key");
			 String word=request.getParameter("word")==null?"":request.getParameter("word");
			 String order=request.getParameter("order")==null?"scode":request.getParameter("order");
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
		PrintWriter out=response.getWriter();
		JSONObject jObject=new JSONObject();
		
		StudentsVO vo=new StudentsVO();
		vo.setScode(request.getParameter("scode"));
		vo.setSname(request.getParameter("sname"));
		vo.setDept(request.getParameter("dept"));
		vo.setYear(request.getParameter("year"));
		vo.setAdvisor(request.getParameter("advisor"));
		try {
			java.sql.Date birthday=
					Date.valueOf(request.getParameter("birthday"));
			vo.setBirthday(birthday);
		}catch(Exception e) {}
		
		StudentsDAO sdao=new StudentsDAO();
		
		switch(request.getServletPath()) {
		case "/students/update":
			sdao.update(vo);
			break;
		case "/students/insert":
			StudentsVO v=sdao.read(vo.getScode());
			if(v.getScode()==null) {
				sdao.insert(vo);
				jObject.put("count", "0");
			}else {
				jObject.put("count", "1");
			}
			out.println(jObject);
			break;
		case "/students/delete":
			jObject.put("count", sdao.delete(vo.getScode()));
			out.println(jObject);
			break;
		}
	}
}







