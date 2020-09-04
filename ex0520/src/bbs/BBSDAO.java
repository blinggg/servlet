package bbs;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import javafx.scene.chart.PieChart.Data;

public class BBSDAO {
	//게시글 읽기
	public BBSVO read(int seqno) {
		BBSVO vo=new BBSVO();
		
		try {
			String sql="select * from bbs where seqno=?";
			PreparedStatement ps=DataBase.CON.prepareStatement(sql);
			ps.setInt(1, seqno);
			ResultSet rs=ps.executeQuery();
			
			if(rs.next()){
				vo.setContent(rs.getString("content"));
				vo.setTitle(rs.getString("title"));
				vo.setSeqno(rs.getInt("seqno"));
				vo.setWriter(rs.getString("writer"));
				
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");
				vo.setWdate(sdf.format(rs.getTimestamp("wdate")));
			}
		}catch(Exception e) {
			System.out.println("게시글 읽기:"+e.toString());
		}
		return vo;
	}
	
	//게시판 글쓰기
	public boolean insert(BBSVO vo) {
		boolean success=false;
		
		try {
			String sql="insert into bbs(title, writer, content) values(?,?,?)";
			PreparedStatement ps=DataBase.CON.prepareStatement(sql);
			ps.setString(1, vo.getTitle());
			ps.setString(2, vo.getWriter());
			ps.setString(3, vo.getContent());
			ps.execute();
			success=true;
		}catch(Exception e) {
			success=false;
			System.out.println("게시판 글쓰기:"+e.toString());
		}
		return success;
		
	}
	
	//게시판 글읽기
	public JSONObject list(String key, String word, String order, String desc, int page, int perPage){
		JSONObject jObject=new JSONObject();
		try {
			String sql="call list('bbs',?,?,?,?,?,?)";
			CallableStatement cs=DataBase.CON.prepareCall(sql);
			cs.setString(1, key);
			cs.setString(2, word);
			cs.setString(3, order);
			cs.setString(4, desc);
			cs.setInt(5,(page-1)*perPage);
			cs.setInt(6, perPage);
		
			cs.executeQuery();
			
			ResultSet rs=cs.getResultSet();
			
			JSONArray jArray=new JSONArray();
			while(rs.next()) {
				JSONObject obj=new JSONObject();
				obj.put("seqno", rs.getInt("seqno"));
				obj.put("title", rs.getString("title"));
				obj.put("writer", rs.getString("writer"));
				obj.put("wdate", rs.getString("wdate"));
				jArray.add(obj);
			}
			jObject.put("list", jArray);	//리스트 출력하기

			cs.getMoreResults(); //다음 Result로 이동
			
			 rs=cs.getResultSet();
	         int count=0;
	         if(rs.next()) {
	            count=rs.getInt("total");
	         }
			
	        jObject.put("count", count);//전체 데이터 개수
			jObject.put("page", page); // 현재 페이지
			jObject.put("perPage", perPage); // 페이지당 출력건수
			int totPage=count%perPage==0?count/perPage:(count/perPage)+1;
			jObject.put("totPage", totPage); // 전체 페이지
				
		}catch(Exception e) {
			System.out.println("게시판목록:"+e.toString());
		}

		return jObject;
	}
}
