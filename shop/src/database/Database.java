package database;

import java.sql.Connection;
import java.sql.DriverManager;

public class Database{
	 public static Connection CON;
	 static {
	 try {
	 Class.forName ("oracle.jdbc.driver.OracleDriver");
	 CON=DriverManager.getConnection("jdbc:oracle:thin:@127.0.0.1:1521:xe", "shop", "pass");
	 System.out.println("立加己傍");
	 } catch(Exception e) { System.out.println("立加角菩:" + e.toString()); }
	 }
	}