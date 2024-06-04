package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class KetNoiDao {
	public static Connection cn;
	public void KetNoiCSDLDao() throws Exception {
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		System.out.println("Ket Noi");
		cn = DriverManager.getConnection("jdbc:sqlserver://ADMIN\\DATSQL : 1433;databaseName= QlKhachHang; user= sa; password=123");
		System.out.println("Ket Noi CSDL");
	}
	
	
}