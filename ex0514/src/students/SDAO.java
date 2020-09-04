package students;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import professor.PVO;

public class SDAO {
	//데이터베이스 접속
	   public Connection con() throws Exception{
	      
		  String driver = "oracle.jdbc.driver.OracleDriver";
	      String url = "jdbc:oracle:thin:@localhost:1521:xe";
	      String user = "haksa";
	      String password = "pass";

	      Class.forName(driver);
	      Connection con=DriverManager.getConnection(url, user, password);
	      
	      return con;
	   }
	   
	 //학생 목록출력
	   public ArrayList<SVO> list() throws Exception{
		   ArrayList<SVO> list=new ArrayList<SVO>();
		   String sql="select s.*, pname from students s, professors where pcode=advisor";
		   PreparedStatement ps=con().prepareStatement(sql);
		   ResultSet rs=ps.executeQuery();
		   while(rs.next()) {
			   SVO vo=new SVO();
			   vo.setScode(rs.getString("scode"));
			   vo.setSname(rs.getString("sname"));
			   vo.setDept(rs.getString("dept"));
			   vo.setYear(rs.getInt("year"));
			   vo.setBirthday(rs.getString("birthday"));
			   vo.setPname(rs.getString("pname"));
			   list.add(vo);
		   }
		   return list;

	   } 
	   
	 //학생등록 메서드
	   public void insert(SVO vo)throws Exception{
		   String sql="insert into students(scode,sname,dept,year,advisor,birthday) values(?,?,?,?,?,?)";
		   PreparedStatement ps=con().prepareStatement(sql);
		   ps.setString(1, vo.getScode());
		   ps.setString(2, vo.getSname());
		   ps.setString(3, vo.getDept());
		   ps.setInt(4, vo.getYear());
		   ps.setString(5, vo.getAdvisor());
		   ps.setString(6, vo.getBirthday());
		   ps.execute();
	   }
	   
	//학생읽기
	   public SVO read(String scode)throws Exception{
		   SVO vo=new SVO();
		   String sql="select * from students where scode=?";
		   PreparedStatement ps=con().prepareStatement(sql);
		   ps.setString(1, scode);
		   ResultSet rs=ps.executeQuery();
		   
		   if(rs.next()) {
			   vo.setScode(rs.getString("scode"));
			   vo.setSname(rs.getString("sname"));
			   vo.setDept(rs.getString("dept"));
			   vo.setYear(rs.getInt("year"));
			   vo.setBirthday(rs.getString("birthday"));
			   vo.setAdvisor(rs.getString("advisor"));
		   } 
		   return vo;
	   }
	   
	  //학생목록 삭제하기
	   public void delete(String scode)throws Exception{
		   String sql="delete from students where scode=?";
		   PreparedStatement ps=con().prepareStatement(sql);
		   ps.setString(1,scode);
		   ps.execute();
	   }
	   
	  //학생목록 수정하기
	   public void update(SVO vo)throws Exception{
		   String sql="update students set sname=?, dept=?, year=?, advisor=? where scode=?";
		   PreparedStatement ps=con().prepareStatement(sql);
		   ps.setString(1, vo.getSname());
		   ps.setString(2, vo.getDept());
		   ps.setInt(3, vo.getYear());
		   ps.setString(4, vo.getAdvisor());
		   ps.setString(5, vo.getScode());
		   ps.execute();
	   }
	   
}
