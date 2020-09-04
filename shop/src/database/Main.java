package database;

import java.util.ArrayList;

import org.json.simple.JSONObject;

import mall.MallDAO;
import orders.OrdersDAO;
import orders.OrdersVO;
import product.ProductDAO;

public class Main {

	public static void main(String[] args) {
		//커넥션 확인하기
		System.out.println(Database.CON);
		SqlVO vo=new SqlVO();
		vo.setKey("prod_name");
		vo.setWord("");
		vo.setOrder("prod_id");
		vo.setDesc("desc");
		vo.setPage(1);
		vo.setPerPage(2);
		
		ProductDAO pdao=new ProductDAO();
		OrdersDAO odao=new OrdersDAO();
		JSONObject jObject=pdao.list(vo);
		ArrayList<OrdersVO> list=odao.list("order_id");
		System.out.println(jObject);

	}
}