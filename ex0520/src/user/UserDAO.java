package user;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import bbs.DataBase;

public class UserDAO {
	  //회원가입
    public JSONObject insert(UserVO vo) {
       JSONObject jObject=new JSONObject();
       try {
          String sql="call add_user(?,?,?,?)";
          CallableStatement cs=DataBase.CON.prepareCall(sql);
          cs.setString(1,vo.getId());
          cs.setString(2,vo.getPassword());
          cs.setString(3,vo.getName());
          cs.registerOutParameter(4,java.sql.Types.INTEGER);
          cs.execute();
          jObject.put("count",cs.getInt(4));
          
       }catch(Exception e) {
          System.out.println("회원가입:"+e.toString());
       }
       return jObject;   
    }
    
    //로그인 체크
    public UserVO loginCheck(String id,String password) {
       UserVO vo=new UserVO();
       try {
          String sql="select * from userinfo where id=? and password=?";
          PreparedStatement ps=DataBase.CON.prepareStatement(sql);
          ps.setString(1,id);
          ps.setString(2,password);
          ResultSet rs=ps.executeQuery();
          if(rs.next()) {
             vo.setId(rs.getString("id"));
             vo.setName(rs.getString("name"));
          }
       }catch(Exception e) {
          System.out.println("로그인체크:"+e.toString());
       }
       return vo;
    }
    
    //사용자목록 출력
	public JSONObject list(String key, String word, int page, int perPage){
		JSONObject jObject=new JSONObject();
		try {
			String sql="call list_user(?,?,?,?,?)";
			CallableStatement cs=DataBase.CON.prepareCall(sql);
			cs.setString(1, key);
			cs.setString(2, word);
			cs.setInt(3,(page-1)*perPage);
			cs.setInt(4, perPage);
			cs.registerOutParameter(5, java.sql.Types.INTEGER);
			cs.execute();
			
			int count=cs.getInt(5);
			jObject.put("count", count);//전체 데이터 개수
			
			ResultSet rs=cs.getResultSet();
			
			jObject.put("page", page); // 현재 페이지
			jObject.put("perPage", perPage); // 페이지당 출력건수
			int totPage=count%perPage==0?count/perPage:(count/perPage)+1;
			jObject.put("totPage", totPage); // 전체 페이지

			JSONArray jArray=new JSONArray();
			while(rs.next()) {
				JSONObject obj=new JSONObject();
				obj.put("name", rs.getString("name"));
				obj.put("id", rs.getString("id"));
				obj.put("job", rs.getString("job"));
				obj.put("tel", rs.getString("tel"));
				jArray.add(obj);
			}
			jObject.put("list", jArray);	//리스트 출력하기

			
		}catch(Exception e) {
			System.out.println("회원목록:"+e.toString());
		}

		return jObject;
	}
}
