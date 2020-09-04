package product;


import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import database.Database;
import database.SqlVO;

public class ProductDAO {
	//상품 삭제하기
	public int delete(String prod_id) {
		int count=-1;
		try {
			String sql="{call del_product(?,?)}";
			CallableStatement cs=Database.CON.prepareCall(sql);
			cs.setString(1, prod_id);
			cs.registerOutParameter(2, oracle.jdbc.OracleTypes.INTEGER);
			cs.execute();
			count=cs.getInt(2);
		}catch(Exception e) {
			System.out.println("상품삭제:"+e.toString());
		}
		return count;
	}
	
	//상품 수정하기
	public void update(ProductVO vo) {
		try {
			String sql="update product set prod_name=?, company=?, mall_id=?, price1=?, price2=?, detail=?, image=?, prod_del=? where prod_id=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getProd_name());
			ps.setString(2, vo.getCompany());
			ps.setString(3, vo.getMall_id());
			ps.setInt(4, vo.getPrice1());
			ps.setInt(5, vo.getPrice2());
			ps.setString(6, vo.getDetail());
			ps.setString(7, vo.getImage());
			ps.setString(8, vo.getProd_del());
			ps.setString(9, vo.getProd_id());
			ps.execute();
		
		
		
		}catch(Exception e) {
			System.out.println("상품수정:"+e.toString());
		}
	}
	//새로운 상품 등록하기
	public void insert(ProductVO vo) {
		try {
			 String sql="insert into product(prod_id,prod_name,company,mall_id,price1,price2,detail,image) values(?,?,?,?,?,?,?,?)";
			 PreparedStatement ps=Database.CON.prepareStatement(sql);
			 ps.setString(1, vo.getProd_id());
			 ps.setString(2, vo.getProd_name());
			 ps.setString(3, vo.getCompany());
			 ps.setString(4, vo.getMall_id());
			 ps.setInt(5, vo.getPrice1());
			 ps.setInt(6, vo.getPrice2());
			 ps.setString(7, vo.getDetail());
			 ps.setString(8, vo.getImage());
			 ps.execute();
			 
			 }catch(Exception e) {
			 System.out.println("상품 등록:" + e.toString());
			}

	}
	
	//새로운 상품코드 얻기
	public String getID() {
		String id="";
		try {
			String sql="select max(prod_id) id from product";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				String maxID=rs.getString("id").substring(1);
				id="P"+(Integer.parseInt(maxID)+1);
				
			}
			
		}catch(Exception e) {
			System.out.println("새로운 상품코드 얻기:"+e.toString());
		}
		return id;
	}
	
	//상품정보
	public ProductVO read(String prod_id) {
		ProductVO vo=new ProductVO();
		try {
			String sql="select p.*,mall_name from product p, mall m where p.mall_id=m.mall_id and p.prod_id=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1,prod_id);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				vo.setProd_id(rs.getString("prod_id"));
				vo.setProd_name(rs.getString("prod_name"));
				vo.setPrice1(rs.getInt("price1"));
				vo.setPrice2(rs.getInt("price2"));
				vo.setMall_id(rs.getString("mall_id"));
				vo.setMall_name(rs.getString("mall_name"));
				vo.setProd_del(rs.getString("prod_del"));
				vo.setCompany(rs.getString("company"));
				vo.setDetail(rs.getString("detail"));
				vo.setImage(rs.getString("image"));
				
			}
		}catch(Exception e) {
			System.out.println("상품정보"+e.toString());
		}
		return vo;
	}
	
	//상품목록 출력
	public JSONObject list(SqlVO vo) {
		JSONObject jObject=new JSONObject();
		try {
			String sql="{call list(?,?,?,?,?,?,?,?,?)}";
			CallableStatement cs=Database.CON.prepareCall(sql);
			cs.setString(1,"(select p.*, mall_name from product p, mall m where p.mall_id=m.mall_id)");
			cs.setString(2,vo.getKey());
			cs.setString(3, vo.getWord());
			cs.setString(4, vo.getOrder());
			cs.setString(5, vo.getDesc());
			cs.setInt(6, vo.getPage());
			cs.setInt(7, vo.getPerPage());
			cs.registerOutParameter(8, oracle.jdbc.OracleTypes.CURSOR);
			cs.registerOutParameter(9, oracle.jdbc.OracleTypes.INTEGER);
			cs.execute();
			ResultSet rs=(ResultSet)cs.getObject(8);
			int count=cs.getInt(9);
			
			JSONArray jArray=new JSONArray();
			while(rs.next()) {
				JSONObject obj=new JSONObject();
				obj.put("prod_id", rs.getString("prod_id"));
				obj.put("prod_name", rs.getString("prod_name"));
				obj.put("company", rs.getString("company"));
				obj.put("price1", rs.getInt("price1"));
				obj.put("price2", rs.getInt("price2"));
				obj.put("mall_name", rs.getString("mall_name"));
				obj.put("image", rs.getString("image"));
				obj.put("prod_del", rs.getString("prod_del"));
				jArray.add(obj);
			}
			jObject.put("array",jArray);
			jObject.put("count",count);
			jObject.put("perPage",vo.getPerPage());
			jObject.put("page", vo.getPage());
			
			int totPage=count%vo.getPerPage()==0?
					count/vo.getPerPage():count/vo.getPerPage()+1;
			jObject.put("totPage",totPage);
			System.out.println(jObject);
		}catch(Exception e) {
			System.out.println("상품목록 출력:"+e.toString());
		}
		
		return jObject;
	}
}
