package book;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import bbs.BBSVO;
import bbs.DataBase;

public class BookDAO {
	//���� �����ϱ�
	public void update(BookVO vo) {
		try {
			String sql="update goodsinfo set title=?, writer=?, price=? where code=?";
			PreparedStatement ps=DataBase.CON.prepareStatement(sql);
			ps.setString(1, vo.getTitle());
			ps.setString(2, vo.getWriter());
			ps.setInt(3, vo.getPrice());
			ps.setString(4, vo.getCode());
			ps.execute();
			
		}catch(Exception e) {
			System.out.println(e.toString());
		}
	}
	
	//���� �����ϱ�
	public void delete(String code) {
		try {
			String sql="delete from goodsinfo where code=?";
			PreparedStatement ps=DataBase.CON.prepareStatement(sql);
			ps.setString(1, code);
			ps.execute();
			
		}catch(Exception e) {
			System.out.println(e.toString());
		}
		
	}
	//���� �б�
	public BookVO read(String code) {
		BookVO vo=new BookVO();
		
		try {
			String sql="select * from goodsinfo where code=?";
			PreparedStatement ps=DataBase.CON.prepareStatement(sql);
			ps.setString(1, code);
			ResultSet rs=ps.executeQuery();
			
			if(rs.next()){
				vo.setCode(rs.getString("code"));
				vo.setTitle(rs.getString("title"));
				vo.setWriter(rs.getString("writer"));
				vo.setPrice(rs.getInt("price"));
			}
		}catch(Exception e) {
			System.out.println("������� �б�:"+e.toString());
		}
		return vo;
	}
	
	//���� ���
	public int insert(BookVO vo) {
		int count=0;
		
		try {
			String sql="call add_book(?,?,?,?,?)";
			CallableStatement cs=DataBase.CON.prepareCall(sql);
			cs.setString(1,vo.getCode());
			cs.setString(2, vo.getTitle());
			cs.setString(3, vo.getWriter());
			cs.setInt(4, vo.getPrice());
			cs.registerOutParameter(5, java.sql.Types.INTEGER);
			cs.execute();
			
			count=cs.getInt(5);
			
		}catch(Exception e) {
			System.out.println("�������:"+e.toString());
		}
		
		return count;
	}
	//������� ����ϱ�
	public JSONObject list(String key,String word,int page, int perPage) {
		JSONObject jObject=new JSONObject();
		
		try {
			String sql="call list_goods(?,?,?,?,?)";
			CallableStatement cs=DataBase.CON.prepareCall(sql);
			cs.setString(1, key);
			cs.setString(2, word);
			cs.setInt(3, (page-1)*perPage);
			cs.setInt(4, perPage);
			cs.registerOutParameter(5, java.sql.Types.INTEGER);
			cs.execute();
			
			int count=cs.getInt(5);
			ResultSet rs=cs.getResultSet();
			
			jObject.put("count", count); //��ü ������ ����
			jObject.put("page", page);	//���� ������
			jObject.put("perPage", perPage);	//���������� ��µ� ����
			
			int totPage=count%perPage==0?count/perPage:(count/perPage)+1;
			jObject.put("totPage", totPage); //��ü������
			
			JSONArray array=new JSONArray();
			while(rs.next()) {
				JSONObject obj=new JSONObject();
				obj.put("code", rs.getString("code"));
				obj.put("title", rs.getString("title"));
				obj.put("writer", rs.getString("writer"));
				//DecimalFormat df=new DecimalFormat("#,###");
				obj.put("price",rs.getInt("price"));
				array.add(obj);
			}
			jObject.put("array",array);
			
		}catch(Exception e) {
			System.out.println("�������:"+e.toString());
		}
		
		
		return jObject;
	}
}
