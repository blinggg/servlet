package database;
import java.sql.*;
public class Database {
	public static Connection CON;
	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			CON=DriverManager.getConnection("jdbc:mysql://localhost:3306/haksadb", "haksa", "pass");
			System.out.println("立加己傍");
		}catch(Exception e) {
			System.out.println("立加角菩:" + e.toString());
		}
	}
}
