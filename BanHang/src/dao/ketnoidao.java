package dao;
import java.sql.Connection;
import java.sql.DriverManager;

public class ketnoidao {
	public static Connection cn;
	public void ketnoi() throws Exception{
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		System.out.println("Da tim thay HQTCSDL");
		cn = DriverManager.getConnection("jdbc:sqlserver://HIPC\\SQLEXPRESS:1433;databaseName=BaiTap; user=sa; password=123");
		System.out.println("Da ket noi thanh cong\n");
	}
//	public static void main(String[] args) {
//		try {
//			ketnoidao knd = new ketnoidao();
//			knd.ketnoi();
//		} catch (Exception e) {
//			// TODO: handle exception
//		}
//	}
}
