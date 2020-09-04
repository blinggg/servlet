package orders;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import database.Database;

public class OrdersDAO {
	//주문상품 입력하기
	public void insert(OrdersVO vo) {
		try {
			String sql="insert into orders(order_id,prod_id,price,quantity) values(?,?,?,?)";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getOrder_id());
			ps.setString(2, vo.getProd_id());
			ps.setInt(3, vo.getPrice());
			ps.setInt(4, vo.getQuantity());
			ps.execute();
		}catch(Exception e) {
			System.out.println("주문상품 입력:"+e.toString());
		}
	}
	//특정 구매자의 상품 목록
	public ArrayList<OrdersVO> list(String order_id){
		ArrayList<OrdersVO> list=new ArrayList<OrdersVO>();
		try {
			String sql="select o.*, prod_name, company from orders o, product p where o.prod_id=p.prod_id and order_id=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, order_id);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				OrdersVO vo=new OrdersVO();
				 vo.setProd_id(rs.getString("prod_id"));
				 vo.setProd_name(rs.getString("prod_name"));
				 vo.setPrice(rs.getInt("price"));
				 vo.setQuantity(rs.getInt("quantity"));
				 vo.setCompany(rs.getString("company"));
				 list.add(vo);
			}
		}catch(Exception e) {
			System.out.println("특정 구매자의 상품목록 보기:"+e.toString());
		}
		return list;
	}
}
