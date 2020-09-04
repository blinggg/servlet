package cart;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import orders.OrdersVO;
import product.ProductDAO;
import product.ProductVO;


@WebServlet(value= {"/cart/insert", "/cart/update"})
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session=request.getSession();
		ArrayList<OrdersVO> listCart=
				(ArrayList<OrdersVO>)session.getAttribute("listCart");
		String prod_id=request.getParameter("prod_id");
		ProductDAO pdao=new ProductDAO();
		ProductVO productvo=pdao.read(prod_id);
		OrdersVO cartVO=new OrdersVO();
		switch(request.getServletPath()) {
		case "/cart/insert" :
				System.out.println(productvo);
				cartVO.setProd_id(productvo.getProd_id());
				cartVO.setProd_name(productvo.getProd_name());
				cartVO.setPrice(productvo.getPrice1());
				cartVO.setQuantity(1);
				cartVO.setSum(cartVO.getPrice1()*cartVO.getQuantity());
				
				boolean isfind=false; //카트의 상품 존재 여부 체크하기
				if(listCart==null) {
					listCart=new ArrayList<OrdersVO>();
				}else {
					for(OrdersVO oldVO:listCart) {
						if(oldVO.getProd_id().equals(prod_id)) {
							oldVO.setQuantity(oldVO.getQuantity()+1);
							oldVO.setSum(oldVO.getPrice1()*oldVO.getQuantity());
							isfind=true;
						}
					}
					
				}
				if(!isfind) listCart.add(cartVO);
				session.setAttribute("listCart", listCart);
				break;
		case "/cart/update":
			String strQuantity=request.getParameter("quantity");
			int quantity=Integer.parseInt(strQuantity);
			for(OrdersVO oldVO:listCart) {
				if(oldVO.getProd_id().equals(prod_id)) {
					oldVO.setQuantity(quantity);
					oldVO.setSum(oldVO.getPrice1()*oldVO.getQuantity());
					
				}
			}
			break;
		}	
	}
}
