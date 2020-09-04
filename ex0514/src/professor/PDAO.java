package professor;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import courses.CVO;
import user.UserVO;

public class PDAO {
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
	   
	 //교수 목록출력
	   public ArrayList<PVO> list() throws Exception{
		   ArrayList<PVO> list=new ArrayList<PVO>();
		   String sql="select * from professors";
		   PreparedStatement ps=con().prepareStatement(sql);
		   ResultSet rs=ps.executeQuery();
		   while(rs.next()) {
			   PVO vo=new PVO();
			   vo.setPcode(rs.getString("pcode"));
			   vo.setPname(rs.getString("pname"));
			   vo.setSalary(rs.getInt("salary"));
			   vo.setTitle(rs.getString("title"));
			   vo.setHiredate(rs.getDate("hiredate"));
			   vo.setDept(rs.getString("dept"));
			   list.add(vo);
		   }
		   return list;
	   }
	 //교수등록 메서드
	   public void insert(PVO vo)throws Exception{
		   String sql="insert into professors(pcode,pname,dept,title,hiredate,salary) values(?,?,?,?,sysdate,?)";
		   PreparedStatement ps=con().prepareStatement(sql);
		   ps.setString(1,vo.getPcode());
		   ps.setString(2,vo.getPname());
		   ps.setString(3,vo.getDept());
		   ps.setString(4,vo.getTitle());
		   //ps.setString(1,vo.getPcode());
		   ps.setInt(5,vo.getSalary());
		  
		   ps.execute();
	   }
	   
	   //교수 삭제 메서드
	   public void delete(String pcode)throws Exception{
		   String sql="delete from professors where pcode=?";
		   PreparedStatement ps=con().prepareStatement(sql);
		   ps.setString(1,pcode);
		   ps.execute();
	   }
	   
	   //교수읽기
	   public PVO read(String pcode)throws Exception{
		   PVO vo=new PVO();
		   String sql="select * from professors where pcode=?";
		   PreparedStatement ps=con().prepareStatement(sql);
		   ps.setString(1, pcode);
		   ResultSet rs=ps.executeQuery();
		   if(rs.next()) {
			   vo.setPcode(rs.getString("pcode"));
			   vo.setPname(rs.getString("pname"));
			   vo.setSalary(rs.getInt("salary"));
			   vo.setTitle(rs.getString("title"));
			   vo.setHiredate(rs.getDate("hiredate"));
			   vo.setDept(rs.getString("dept"));
		   }
		   return vo;
	   }
	   
	   //교수목록 수정하기
	   public void update(PVO vo)throws Exception{
		   String sql="update professors set pname=?, dept=?, title=?, salary=? where pcode=?";
		   PreparedStatement ps=con().prepareStatement(sql);
		 
		   ps.setString(1,vo.getPname());
		   ps.setString(2,vo.getDept());
		   ps.setString(3,vo.getTitle());
		   //ps.setString(1,vo.getPcode());
		   ps.setInt(4,vo.getSalary());
		   ps.setString(5, vo.getPcode());
		   ps.execute();
	   }
}
