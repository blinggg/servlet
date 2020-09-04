package api;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(value= {"/naver/blog","/naver/book"})
public class NaverServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		String query=request.getParameter("query");
		String strStart=request.getParameter("start");
	    int start=Integer.parseInt(strStart);
	    String strDisplay=request.getParameter("display");
	    int display=Integer.parseInt(strDisplay);
		String url="";
		
		switch(request.getServletPath()) {
		case "/naver/blog":
		url="https://openapi.naver.com/v1/search/blog";
			break;
			
		case "/naver/book":
			url="https://openapi.naver.com/v1/search/book";
			break;
			
		}
		String result=NaverAPI.main(url,query,start,display);
		out.println(result);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
