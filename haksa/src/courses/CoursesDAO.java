package courses;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import database.Database;
import database.SqlVO;

public class CoursesDAO {
	//���»���
	public int delete(String lcode) {
		int count=-1;
		try {
			String sql="select count(*) cnt from enrollments where lcode=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, lcode);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				count=rs.getInt("cnt");
			}
			if(count==0) {
				sql="delete from courses where lcode=?";
				ps=Database.CON.prepareStatement(sql);
				ps.setString(1, lcode);
				ps.execute();
			}
		}catch(Exception e) {
			System.out.println("���»���:" + e.toString());
		}
		return count;
	}
	//���¼���
	public void update(CoursesVO vo) {
		try {
			String sql="update courses set lname=?,room=?,hours=?,capacity=?,persons=?,instructor=? where lcode=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getLname());
			ps.setString(2, vo.getRoom());
			ps.setInt(3, vo.getHours());
			ps.setInt(4, vo.getCapacity());
			ps.setInt(5, vo.getPersons());
			ps.setString(6, vo.getInstructor());
			ps.setString(7, vo.getLcode());
			ps.execute();
		}catch(Exception e) {
			System.out.println("���µ��:" + e.toString());
		}
	}
	
	//���������б�
	public CoursesVO read(String lcode) {
		CoursesVO vo=new CoursesVO();
		try {
			String sql="select c.*, pname from courses c left join professors on pcode=instructor where lcode=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, lcode);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				vo.setLcode(rs.getString("lcode"));
				vo.setLname(rs.getString("lname"));
				vo.setRoom(rs.getString("room"));
				vo.setInstructor(rs.getString("instructor"));
				vo.setPname(rs.getString("pname"));
				vo.setHours(rs.getInt("hours"));
				vo.setCapacity(rs.getInt("capacity"));
				vo.setPersons(rs.getInt("persons"));
			}
		}catch(Exception e) {
			System.out.println("���������б�:" + e.toString());
		}
		return vo;
	}
	
	//���µ��
	public void insert(CoursesVO vo) {
		try {
			String sql="insert into courses(lcode,lname,room,hours,instructor,capacity,persons) values(?,?,?,?,?,?,?)";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getLcode());
			ps.setString(2, vo.getLname());
			ps.setString(3, vo.getRoom());
			ps.setInt(4, vo.getHours());
			ps.setString(5, vo.getInstructor());
			ps.setInt(6, vo.getCapacity());
			ps.setInt(7, vo.getPersons());
			ps.execute();
		}catch(Exception e) {
			System.out.println("���µ��:" + e.toString());
		}
	}
	//�����ڵ�üũ
	public int checkCode(String lcode) {
		int count=-1;
		try {
			String sql="select count(*) cnt from courses where lcode=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, lcode);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				count=rs.getInt("cnt");
			}
		}catch(Exception e) {
			System.out.println("�����ڵ�üũ:" + e.toString());
		}
		return count;
	}
	
	//��簭�¸�� ���
	public ArrayList<CoursesVO> listAll(){
		ArrayList<CoursesVO> list=new ArrayList<CoursesVO>();
		try {
			String sql="select c.*, pname from courses c left join professors on instructor=pcode";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				CoursesVO vo=new CoursesVO();
				vo.setLcode(rs.getString("lcode"));
				vo.setLname(rs.getString("lname"));
				vo.setPname(rs.getString("pname"));
				list.add(vo);
			}
		}catch(Exception e) {
			System.out.println("��簭�¸��:" + e.toString());
		}
		return list;
	}
	//���¸�����
	public JSONObject list(SqlVO vo) {
		JSONObject jObject=new JSONObject();
		try {
			String sql="call list(?,?,?,?,?,?,?)";
			CallableStatement cs=Database.CON.prepareCall(sql);
			String tbl="(select c.*,pname from courses c left join professors on instructor=pcode) tbl";
			cs.setString(1, tbl);
			cs.setString(2, vo.getKey());
			cs.setString(3, vo.getWord());
			cs.setString(4, vo.getOrder());
			cs.setString(5, vo.getDesc());
			cs.setInt(6, vo.getPage());
			cs.setInt(7, vo.getPerPage());
			cs.execute();
			
			//���¸��
			ResultSet rs=cs.getResultSet();
			JSONArray jArray=new JSONArray();
			while(rs.next()) {
				JSONObject obj=new JSONObject();
				obj.put("lcode", rs.getString("lcode"));
				obj.put("lname", rs.getString("lname"));
				obj.put("room", rs.getString("room"));
				obj.put("hours", rs.getString("hours"));
				obj.put("capacity", rs.getString("capacity"));
				obj.put("persons", rs.getString("persons"));
				obj.put("pname", rs.getString("pname"));
				jArray.add(obj);
			}
			jObject.put("array", jArray);
			
			//�˻� ����Ÿ ����
			cs.getMoreResults();
			rs=cs.getResultSet();
			int count=0;
			if(rs.next()) { count=rs.getInt("total"); }
			int perPage = vo.getPerPage();
			int totPage = count%perPage==0?count/perPage:count/perPage+1;
			jObject.put("count", count); //��ü����Ÿ
			jObject.put("page", vo.getPage());//����������
			jObject.put("perPage", vo.getPerPage());//�������� ����
			jObject.put("totPage", totPage);//��ü������
			
		}catch(Exception e) {
			System.out.println("���¸��:" + e.toString());
		}
		return jObject;
	}
}
