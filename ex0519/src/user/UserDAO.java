package user;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import book.DataBase;

public class UserDAO {
	//데이터갯수 출력하기
	public int count(String key, String word){
		int count=0;
		
		try {
			String sql="select count(*) total from userinfo where " + key + " like ? limit 0,5";
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
public ArrayList<UserVO> list(String key, String word, int page){
	ArrayList<UserVO> list=new ArrayList<UserVO>();
	try {
		String sql="select * from userinfo where " + key + " like ? order by name limit ?,5";
		PreparedStatement ps=DataBase.CON.prepareStatement(sql);
		ps.setString(1, "%"+word+"%");
		ps.setInt(2, (page-1)*5);
		ResultSet rs=ps.executeQuery();
		while(rs.next()) {
			UserVO vo=new UserVO();
			vo.setName(rs.getString("name"));
			vo.setId(rs.getString("id"));
			vo.setPassword(rs.getString("password"));
			vo.setJob(rs.getString("job"));
			vo.setTel(rs.getString("tel"));
			list.add(vo);
		}
	}catch(Exception e) {
		System.out.println(e.toString());
	}
	return list;
 }
}
