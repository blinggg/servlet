package students;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import database.Database;
import database.SqlVO;

public class StudentsDAO {
	//�л�����
	public int delete(String scode) {
		int count=-1;
		try {
			String sql="call del_student(?,?)";
			CallableStatement cs=Database.CON.prepareCall(sql);
			cs.setString(1, scode);
			cs.registerOutParameter(2, java.sql.Types.INTEGER);
			cs.execute();
			count=cs.getInt(2);
		}catch(Exception e) {
			System.out.println("�л�����:" + e.toString());
		}
		return count;
	}
	//�л����
	public void insert(StudentsVO vo) {
		try {
			String sql="insert into students(scode,sname,dept,year,birthday,advisor) values(?,?,?,?,?,?)";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getScode());
			ps.setString(2, vo.getSname());
			ps.setString(3, vo.getDept());
			ps.setString(4, vo.getYear());
			ps.setDate(5, vo.getBirthday());
			ps.setString(6, vo.getAdvisor());		
			ps.execute();
		}catch(Exception e) {
			System.out.println("�л����:" + e.toString());
		}
	}
	//�л���������
	public void update(StudentsVO vo) {
		try {
			String sql="update students set sname=?,dept=?,year=?,birthday=?,advisor=? where scode=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getSname());
			ps.setString(2, vo.getDept());
			ps.setString(3, vo.getYear());
			ps.setDate(4, vo.getBirthday());
			ps.setString(5, vo.getAdvisor());
			ps.setString(6, vo.getScode());
			ps.execute();
		}catch(Exception e) {
			System.out.println("�л���������:" + e.toString());
		}
	}

	//�л������б�
	public StudentsVO read(String scode) {
		StudentsVO vo=new StudentsVO();
		try {
			String sql="select s.*, pname from students s left join professors on advisor=pcode where scode=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, scode);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				vo.setScode(rs.getString("scode"));
				vo.setSname(rs.getString("sname"));
				vo.setDept(rs.getString("dept"));
				vo.setYear(rs.getString("year"));
				vo.setAdvisor(rs.getString("advisor"));
				vo.setPname(rs.getString("pname"));
				vo.setBirthday(rs.getDate("birthday"));
			}
		}catch(Exception e) {
			System.out.println("�л������б�:" + e.toString());
		}
		return vo;
	}
	
	//�л�������
	public JSONObject list(SqlVO vo) {
		JSONObject jObject=new JSONObject();
		try {
			String sql="call list(?,?,?,?,?,?,?)";
			CallableStatement cs=Database.CON.prepareCall(sql);
			String tbl="(select s.*,pname from students s left join professors on advisor=pcode) tbl";
			cs.setString(1, tbl);
			cs.setString(2, vo.getKey());
			cs.setString(3, vo.getWord());
			cs.setString(4, vo.getOrder());
			cs.setString(5, vo.getDesc());
			cs.setInt(6, vo.getPage());
			cs.setInt(7, vo.getPerPage());
			cs.execute();
			
			//�л����
			ResultSet rs=cs.getResultSet();
			JSONArray jArray=new JSONArray();
			while(rs.next()) {
				JSONObject obj=new JSONObject();
				obj.put("scode", rs.getString("scode"));
				obj.put("sname", rs.getString("sname"));
				obj.put("dept", rs.getString("dept"));
				obj.put("year", rs.getString("year"));
				obj.put("birthday", rs.getString("birthday"));
				obj.put("pname", rs.getString("pname"));
				obj.put("advisor", rs.getString("advisor"));
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
			System.out.println("�л����:" + e.toString());
		}
		return jObject;
	}
}
