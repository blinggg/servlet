package mall;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import database.Database;
import database.SqlVO;

public class MallDAO {
	//업체목록 출력 메소드
   public JSONObject list(SqlVO vo) {
      JSONObject jObject=new JSONObject();
      try {
         String sql="{call list(?,?,?,?,?,?,?,?,?)}";
         CallableStatement cs=Database.CON.prepareCall(sql);
         cs.setString(1,"mall");
         cs.setString(2,vo.getKey());
         cs.setString(3,vo.getWord());
         cs.setString(4,vo.getOrder());
         cs.setString(5,vo.getDesc());
         cs.setInt(6,vo.getPage());
         cs.setInt(7,vo.getPerPage());
         cs.registerOutParameter(8,oracle.jdbc.OracleTypes.CURSOR);
         cs.registerOutParameter(9,oracle.jdbc.OracleTypes.INTEGER);
         cs.execute();
         ResultSet rs=(ResultSet)cs.getObject(8);
         int count=cs.getInt(9);
         
         JSONArray jArray=new JSONArray();
         while(rs.next()) {
            JSONObject obj=new JSONObject();
            obj.put("mall_id",rs.getString("mall_id"));
            obj.put("mall_name",rs.getString("mall_name"));
            obj.put("manager",rs.getString("manager"));
            obj.put("address",rs.getString("address"));
            obj.put("mall_id",rs.getString("mall_id"));
            obj.put("tel",rs.getString("tel"));
            obj.put("email",rs.getString("email"));
            jArray.add(obj);
         }
         jObject.put("array",jArray);
         jObject.put("count",count);
         jObject.put("perPage",vo.getPerPage());
         jObject.put("page",vo.getPage());
         
         int totPage=count%vo.getPerPage()==0?
               count/vo.getPerPage():count/vo.getPerPage()+1;
               jObject.put("totPage",totPage);
      }catch(Exception e){
         System.out.println("업체목록 출력:"+ e.toString());
      }
      return jObject;
   }
}