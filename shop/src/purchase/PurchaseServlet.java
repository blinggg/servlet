package purchase;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import database.SqlVO;


@WebServlet(value= {"/purchase/list","/purchase/read","/purchase/insert"})
public class PurchaseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		PurchaseDAO purdao=new PurchaseDAO();
		SqlVO svo=new SqlVO();
		String key=request.getParameter("key")==null?"order_id":request.getParameter("key");
		String word=request.getParameter("word")==null?"":request.getParameter("word");
		String order=request.getParameter("order")==null?"order_id":request.getParameter("order");
		String desc=request.getParameter("desc")==null?"":request.getParameter("desc");
		String page=request.getParameter("page")==null?"1":request.getParameter("page");
		String perPage=request.getParameter("perPage")==null?"2":request.getParameter("perPage");
		svo.setKey(key);
		svo.setWord(word);
		svo.setOrder(order);
		svo.setDesc(desc);
		svo.setPage(Integer.parseInt(page));
		svo.setPerPage(Integer.parseInt(perPage));
		
		switch(request.getServletPath()){
		case "/purchase/list":
			out.println(purdao.list(svo));
		break;
		
		case "/purchase/read":
			PurchaseVO vo=purdao.read(request.getParameter("order_id"));
			JSONObject jObject=new JSONObject();
			jObject.put("order_id", vo.getOrder_id());
			jObject.put("name", vo.getName());
			jObject.put("address", vo.getAddress());
			jObject.put("tel", vo.getTel());
			jObject.put("email", vo.getEmail());
			jObject.put("pdate", vo.getPdate());
			
			if(vo.getPayType().equals("0")) {
				jObject.put("payType","무통장");
				}else {
				jObject.put("payType","카드");
				}
			if(vo.getStatus().equals("0")) {
				jObject.put("status","처리중");
				
			}else {
				jObject.put("status","완료");
			}
			out.println(jObject);
			break;
		}

	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		PrintWriter out=response.getWriter();
		PurchaseVO vo=new PurchaseVO();
		vo.setName(request.getParameter("name"));
		vo.setAddress(request.getParameter("address"));
		vo.setEmail(request.getParameter("email"));
		vo.setTel(request.getParameter("tel"));
		vo.setPayType(request.getParameter("payType"));
		vo.setStatus(request.getParameter("status"));
		PurchaseDAO dao=new PurchaseDAO();
		

		switch(request.getServletPath()) {
		case "/purchase/insert":
			String order_id=dao.insert(vo);
			JSONObject jObject=new JSONObject();
			jObject.put("order_id",order_id);
			System.out.println(vo.getOrder_id());
			out.println(jObject);
			break;
			
		}
	}

}
