package dao;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import bean.DienthoaiBean;
import bean.InternetBean;
import bean.khachhangbean;

public class KhachHangDao {
	public SimpleDateFormat DateFormat = new SimpleDateFormat("dd/MM/yyyy");
	public SimpleDateFormat DSQLF = new SimpleDateFormat("dd-MM-yyyy");
	ArrayList<InternetBean> dsi = new ArrayList<InternetBean>();
	ArrayList<DienthoaiBean> dsd = new ArrayList<DienthoaiBean>();
	public void HienThiVaLayDuLieu() throws Exception {
		FileReader r = new FileReader("ds.txt");
		BufferedReader R = new BufferedReader(r);
		while (true) {
			String Line = R.readLine();
			if (Line == null || Line == "") break;
			System.out.println(Line);
			String[] C = Line.split("[,]");
			if (C.length == 6) {
				if(C[0].equals("IN")) {
					Date ngay = new Date(DateFormat.parse(C[4]).getTime() ) ;
					dsi.add(new InternetBean(C[0] , C[1] , C[2] , C[3],ngay , C[5]));
				}
				if (C[0].equals("DT")) {
					Date ngay = new Date(DateFormat.parse(C[4]).getTime() ) ;
					dsd.add(new DienthoaiBean(C[0] , C[1] , C[2] , C[3],ngay , C[5]));
				}
			}
		}
		R.close();
	}
	public ArrayList<InternetBean> HienThiI(){
		for (InternetBean i:dsi) {
			System.out.println(i.toString());
		}
		return dsi;
	}
	public ArrayList<DienthoaiBean> HienThiD(){
		for (DienthoaiBean i:dsd) {
			System.out.println(i.toString());
		}
		return dsd;
	}
	// CSDL
	public void themIn(String mdv, String tdv, String tkh, String mkh, Date ndk, String bt) throws Exception{
		String sql = "insert into Internet (mdv,tdv,  tkh, mkh, ndk, bt) values(? , ? , ? , ? , ? , ?)";
		PreparedStatement cmd = KetNoiDao.cn.prepareStatement(sql);
		cmd.setString(1, mdv);
		cmd.setString(2, tdv);
		cmd.setString(3, tkh);
		cmd.setString(4, mkh);
		cmd.setDate(5, ndk);
		cmd.setString(6, bt);
		cmd.executeUpdate();
	}
	public boolean checkma(String ma)throws Exception{
		String sql = " Select * from Internet where mkh = ?";
		PreparedStatement cmd = KetNoiDao.cn.prepareStatement(sql);
		cmd.setString(1, ma);
		ResultSet rs = cmd.executeQuery();
		boolean ok = rs.next();
		rs.close();
		return ok;
	}
	public ArrayList<InternetBean> hienthisql()throws Exception {
		ArrayList<InternetBean> ds = new ArrayList<InternetBean>();
		String sql = "Select * from Internet";
		PreparedStatement cmd = KetNoiDao.cn.prepareStatement(sql);
		ResultSet rs = cmd.executeQuery();
		while(rs.next()) {
			Date ngay = new Date(DSQLF.parse(rs.getString(5)).getTime() ) ;
			ds.add(new InternetBean(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), ngay, rs.getString(6)));
		}
		rs.close();
		return ds;
	}
	public ArrayList<InternetBean> hienthisqlnnn()throws Exception {
		ArrayList<InternetBean> ds = new ArrayList<InternetBean>();
		String sql = "SELECT * FROM Internet WHERE ndk IN (SELECT MIN (ndk) FROM Internet)";
		PreparedStatement cmd = KetNoiDao.cn.prepareStatement(sql);
		ResultSet rs = cmd.executeQuery();
		while(rs.next()) {
			Date ngay = new Date(DSQLF.parse(rs.getString(5)).getTime() ) ;
			ds.add(new InternetBean(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), ngay, rs.getString(6)));
		}
		rs.close();
		return ds;
	}
	public void Duyet() throws Exception {
		System.out.println("---------------------------");
		for (InternetBean i:dsi) {
			if (checkma(i.getMkh())) {
				System.out.println("Ko");
			}
			else { 
				System.out.println("DC");
				themIn(i.getMdv(), i.getTdv(), i.getTkh(),i.getMkh() ,i.getNdk() , i.getBt());
			}
		}
	}
}
