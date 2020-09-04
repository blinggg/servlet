package user;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import bbs.DataBase;

public class UserDAO {
	  //ȸ������
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
          System.out.println("ȸ������:"+e.toString());
       }
       return jObject;   
    }
    
    //�α��� üũ
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
          System.out.println("�α���üũ:"+e.toString());
       }
       return vo;
    }
    
    //����ڸ�� ���
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
			jObject.put("count", count);//��ü ������ ����
			
			ResultSet rs=cs.getResultSet();
			
			jObject.put("page", page); // ���� ������
			jObject.put("perPage", perPage); // �������� ��°Ǽ�
			int totPage=count%perPage==0?count/perPage:(count/perPage)+1;
			jObject.put("totPage", totPage); // ��ü ������

			JSONArray jArray=new JSONArray();
			while(rs.next()) {
				JSONObject obj=new JSONObject();
				obj.put("name", rs.getString("name"));
				obj.put("id", rs.getString("id"));
				obj.put("job", rs.getString("job"));
				obj.put("tel", rs.getString("tel"));
				jArray.add(obj);
			}
			jObject.put("list", jArray);	//����Ʈ ����ϱ�

			
		}catch(Exception e) {
			System.out.println("ȸ�����:"+e.toString());
		}

		return jObject;
	}
}
