package ex01;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/hap")
public class HServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1부터 100까지의 합
		int sum=0;
		for(int i=0; i<=100; i++) {
			sum=sum+i;
		}
		
		//1부터 100까지 짝수의 합
		int esum=0;
		for(int i=0; i<=100; i+=2){
			esum=esum+i;
		}
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();
		out.println("<html>");
		out.println("<body>");
		out.println("<h1>1~100까지의합계:"+sum+"</h1>");
		out.println("<h1>1~100까지 짝수의합계:"+esum+"</h1>");
		out.println("</body>");
		out.println("</html>");
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}

}
