package book;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(value={"/book/list"})
public class BookServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	      RequestDispatcher dis=null;
	      BookDAO dao=new BookDAO();
	      
	      switch(request.getServletPath()) {
	      case "/book/list":
	         String key=request.getParameter("key")==null?"code":request.getParameter("key");
	         String word=request.getParameter("word")==null?"":request.getParameter("word");
	         String strPage=request.getParameter("page")==null?"1":request.getParameter("page");
	         int page=Integer.parseInt(strPage);
	         
	         //System.out.println(key + "...." + word + "..." + page);
	         
	         //전체페이지 구하기
	         int count=dao.count(key, word);
	         int totPage=0;
	         if(count%10==0) {
	            totPage=count/10;
	         }else {
	            totPage=(count/10)+1;
	         }
	         
	         request.setAttribute("key", key);
	         request.setAttribute("word", word);
	         request.setAttribute("page", page);
	         request.setAttribute("totPage", totPage);
	         request.setAttribute("count", count);
	         request.setAttribute("list", dao.list(key, word, page));
	         dis=request.getRequestDispatcher("list.jsp");
	         dis.forward(request, response);
	         break;
	      }
	   }

	   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	   }
	}
