package orders;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;


@WebServlet(value= {"/orders/list","/orders/insert"})
public class OrdersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		OrdersDAO odao=new OrdersDAO();
		
		switch(request.getServletPath()) {
		case "/orders/list" :
			System.out.println("/orders/list");
			ArrayList<OrdersVO> list=odao.list(request.getParameter("order_id"));
			JSONArray jArray=new JSONArray();
			for(OrdersVO vo:list) {
				JSONObject obj=new JSONObject();
					obj.put("prod_id", vo.getProd_id());
					obj.put("prod_name", vo.getProd_name());
					obj.put("company", vo.getCompany());
					obj.put("price", vo.getPrice());
					obj.put("quantity", vo.getQuantity());
					obj.put("sum", vo.getQuantity()*vo.getPrice());
					jArray.add(obj);
			}
			out.println(jArray);
			break;
			
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		OrdersVO vo=new OrdersVO();
		OrdersDAO dao=new OrdersDAO();
		vo.setOrder_id(request.getParameter("order_id"));
		vo.setProd_id(request.getParameter("prod_id"));
		String quantity=request.getParameter("quantity");
		vo.setQuantity(Integer.parseInt(quantity));
		String price=request.getParameter("price");
		vo.setPrice(Integer.parseInt(price));
		
		switch(request.getServletPath()) {
		case "/orders/insert" :

			
			dao.insert(vo);
			break;
		}
		
	}

}
