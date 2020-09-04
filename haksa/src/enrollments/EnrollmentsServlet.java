package enrollments;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;


@WebServlet(value= {"/es","/ec", "/ec/insert", "/ec/delete","/enroll/update"})
public class EnrollmentsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		JSONObject jObject=new JSONObject();
		EnrollmentsDAO edao=new EnrollmentsDAO();
		
		switch(request.getServletPath()) {
		case "/es":
			System.out.println("/get/es");
			jObject=edao.es(request.getParameter("lcode"));
			out.println(jObject); //json 객체는 브라우저에 출력해야 핸들바에서 사용 가능함!
			break;
			
		case "/ec":
			jObject=edao.ec(request.getParameter("scode"));
			out.println(jObject);
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out=response.getWriter();
		EnrollmentsDAO edao=new EnrollmentsDAO();
		String scode=request.getParameter("scode");
		String lcode=request.getParameter("lcode");
		
		switch(request.getServletPath()) {
		case "/enroll/update":
			String strGrade=request.getParameter("grade");
			int grade=Integer.parseInt(strGrade);
			edao.update(lcode, scode, grade);
			break;
		case "/ec/insert":
			System.out.println("/enroll/insert");
			int count=edao.insert(scode, lcode);
			JSONObject jObject=new JSONObject();
			jObject.put("count", count);
			out.println(jObject);
			break;
		case "/ec/delete":
			edao.delete(scode, lcode);
			break;
		}
	}
}
