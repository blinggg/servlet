package book;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import jdk.nashorn.internal.ir.RuntimeNode.Request;

public class BookDAO {
	//데이터갯수 출력하기
	public int count(String key, String word){
		int count=0;
		
		try {
			String sql="select count(*) total from goodsinfo where " + key + " like ? limit 0,5";
			PreparedStatement ps=DataBase.CON.prepareStatement(sql);
			ps.setString(1, "%"+word+"%");
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				count=rs.getInt("total");
			}
		}catch(Exception e) {
			System.out.println(e.toString());
		}
		return count;
	}
	//도서목록 출력하기
	public ArrayList<BookVO> list(String key, String word,int page){
			ArrayList<BookVO> array=new ArrayList<BookVO>();
		try {
			String sql="select * from goodsinfo where " + key + " like ? limit ?,5";
			PreparedStatement ps=DataBase.CON.prepareStatement(sql);
			ps.setString(1, "%"+word+"%");
			ps.setInt(2, (page-1)*5);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				BookVO vo=new BookVO();
				vo.setCode(rs.getNString("code"));
				vo.setTitle(rs.getString("title"));
				vo.setWriter(rs.getString("writer"));
				vo.setPrice(rs.getInt("price"));
				array.add(vo);
			}
		}catch(Exception e) {
			System.out.println("도서목록출력하기:"+e.toString());
		}
		return array;
	}
}
