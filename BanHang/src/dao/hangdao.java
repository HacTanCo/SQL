package dao;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Scanner;

import bean.hangbean;

public class hangdao {
	public ArrayList<hangbean> gethang() throws Exception {
		
		ArrayList<hangbean> ds = new ArrayList<hangbean>();
		FileReader fr = new FileReader("hang.txt");
		BufferedReader br = new BufferedReader(fr);
		while(true) {
			String l = br.readLine();
			if(l=="" || l==null) break;
			String che[] = l.split("[,]");
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			//String mh, String th, Date nnh, int sl, double gb
			ds.add(new hangbean(che[0],che[1] ,new java.sql.Date(sdf.parse(che[2]).getTime()) ,Integer.parseInt(che[3]) , Double.parseDouble(che[4])));
		}
		br.close();
		return ds;
	}
	public boolean checkma(String mahang) throws Exception {
		String sql = "select * from hang where mh=?";
		PreparedStatement ps = ketnoidao.cn.prepareStatement(sql);
		ps.setString(1, mahang);
		ResultSet rs = ps.executeQuery();
		boolean kq = rs.next();
		rs.close();
		return kq;
	}
	public void luucsdl() throws Exception {
		ketnoidao knd = new ketnoidao();
		knd.ketnoi();
		hangdao hd = new hangdao();
		String sql = "insert into hang(mh,th,nnh,sl,gb) values (?,?,?,?,?)";
		PreparedStatement ps = ketnoidao.cn.prepareStatement(sql);
		for(hangbean i : hd.gethang()) {
			if(checkma(i.getMh()) == true) break;
			ps.setString(1, i.getMh());
			ps.setString(2, i.getTh());
			ps.setDate(3, i.getNnh());
			ps.setInt(4, i.getSl());
			ps.setDouble(5, i.getGb());
			ps.executeUpdate();
		}
		System.out.println("Luu thanh cong tu File -> CSDL");
	}
	
	public int them(String mh, String th, Date nnh, int sl, double gb)  throws Exception{
		if(checkma(mh) == true) return 0;
		String sql = "insert into hang(mh,th,nnh,sl,gb) values (?,?,?,?,?)";
		PreparedStatement ps = ketnoidao.cn.prepareStatement(sql);
		ps.setString(1, mh);
		ps.setString(2, th);
		ps.setDate(3, nnh);
		ps.setInt(4, sl);
		ps.setDouble(5, gb);
		return ps.executeUpdate();
		
	}
	public int xoa(String key) throws Exception{
		String sql = "delete from hang where mh = ?";
		PreparedStatement ps = ketnoidao.cn.prepareStatement(sql);
		ps.setString(1, key);
		return ps.executeUpdate();
	}
	public int sua(String mh, String th, Date nnh, int sl, double gb) throws Exception{
		String sql = "update hang set th=?,nnh=?,sl =?,gb = ? where mh = ?";
		PreparedStatement ps = ketnoidao.cn.prepareStatement(sql);
		ps.setString(1, th);
		ps.setDate(2, nnh);
		ps.setInt(3, sl);
		ps.setDouble(4, gb);
		ps.setString(5, mh);
		return ps.executeUpdate();
	}
	public ArrayList<hangbean> timkiem(String x) throws Exception {
		ArrayList<hangbean> ds = new ArrayList<hangbean>();
		String sql = "select * from hang where th like ?";
		PreparedStatement ps = ketnoidao.cn.prepareStatement(sql);
		ps.setString(1, "%"+x+"%");
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			String mh = rs.getString("mh");
			String th = rs.getString("th");
			Date nnh = rs.getDate("nnh");
			int sl = rs.getInt("sl");
			double gb = rs.getDouble("gb");
			ds.add(new hangbean(mh, th, nnh, sl, gb));
		}
		rs.close();
		return ds;
	}
//	public static void main(String[] args) {
//		Scanner sc = new Scanner(System.in);
//		try {
//			hangdao hd = new hangdao();
//			for(hangbean i : hd.gethang())
//				System.out.println(i.toString());
//			hd.luucsdl();
			//THEM
//			while(true) {
//				System.out.print("\nnhap ma hang: ");
//				String ma =sc.nextLine();
//				if(hd.checkma(ma) == true)
//					System.out.println("\nma da ton tai vui long nhap lai !!!");
//				else {
//					System.out.print("nhap ten hang: ");
//					String tenhang = sc.nextLine();
//					SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
//					System.out.print("nhap ngay nhap hang (dd/MM/yyyy): ");
//					String ngay = sc.nextLine();
//					System.out.print("nhap so luong hang: ");
//					int sl = sc.nextInt();
//					System.out.print("nhap gia ban : ");
//					double gb = sc.nextDouble();
//					sc.nextLine();
//					hd.them(ma, tenhang, new java.sql.Date(sdf.parse(ngay).getTime()), sl, gb);
//					System.out.println("Da them !!!");
//					break;
//				}
//			}
			
			
			//XOA
//			System.out.print("nhap ma de xoa: ");
//			String x = sc.nextLine();
//			if(hd.xoa(x)>0) System.out.println("da xoa thanh cong !!!");
//			else System.out.println("khong tim thay ma hang de xoa !!!");
			
			//SUA
//			System.out.print("\nnhap ma hang: ");
//			String ma =sc.nextLine();
//			if(hd.checkma(ma) == false) {
//				System.out.println("khong tim thay ma de sua");
//				return;
//			}
//			System.out.print("nhap ten hang: ");
//			String tenhang = sc.nextLine();
//			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
//			System.out.print("nhap ngay nhap hang (dd/MM/yyyy): ");
//			String ngay = sc.nextLine();
//			System.out.print("nhap so luong hang: ");
//			int sl = sc.nextInt();
//			System.out.print("nhap gia ban : ");
//			double gb = sc.nextDouble();
//			if(hd.sua(ma, tenhang, new java.sql.Date(sdf.parse(ngay).getTime()), sl, gb)>0) System.out.println("da sua");
			
			//TIM KIEM
//			System.out.print("Nhap ten hang can tim: ");
//			String th = sc.nextLine();
//			for(hangbean i : hd.timkiem(th)) {
//				System.out.println(i.toString());
//			}
			
			
//		} catch (Exception e) {
//			// TODO: handle exception
//			e.printStackTrace();
//		}
//	}
}
	
