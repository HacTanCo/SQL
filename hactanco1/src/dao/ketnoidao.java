package dao;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;

public class ketnoidao {
	public static Connection cn;
	public void ketnoidao()throws Exception{
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		System.out.println("Da tim thay HQTCSDL");
		cn = DriverManager.getConnection("jdbc:sqlserver://HIPC\\SQLEXPRESS:1433;databaseName=22T1020557; user=sa; password=123");
		System.out.println("Da ket noi thanh cong\n");
	}
	
}
