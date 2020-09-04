package bbs;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import book.DataBase;

public class BBSDAO {
	//데이터갯수 출력하기
		public int count(String key, String word){
			int count=0;
			
			try {
				String sql="select count(*) total from bbs where " + key + " like ? limit 0,5";
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
	public ArrayList<BBSVO> list(String key, String word, int page){
		ArrayList<BBSVO> list=new ArrayList<BBSVO>();
		try {
			String sql="select * from bbs where " + key + " like ? order by seqno desc limit ?,5";
			PreparedStatement ps=DataBase.CON.prepareStatement(sql);
			ps.setString(1, "%"+word+"%");
			ps.setInt(2, (page-1)*5);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				BBSVO vo=new BBSVO();
				vo.setSeqno(rs.getInt("seqno"));
				vo.setTitle(rs.getString("title"));
				vo.setWriter(rs.getString("writer"));
				vo.setWdate(rs.getString("wdate"));
				list.add(vo);
			}
		}catch(Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
}
