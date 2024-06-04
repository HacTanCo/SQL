package dao;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import bean.giangvien;
import bean.nguoi;
import bean.nhanvien;

public class nguoidao {
	public ArrayList<String> ds = new ArrayList<String>();
	public ArrayList<nguoi> dshople = new ArrayList<nguoi>();
	public ArrayList<nguoi> dsriengbiet = new ArrayList<nguoi>();
	public ArrayList<nhanvien> dsnv = new ArrayList<nhanvien>();
	
	public void hienthids() throws Exception{
		FileReader fr = new FileReader("ds.txt");
		BufferedReader br = new BufferedReader(fr);
		while(true) {
			String l = br.readLine();
			if(l == "" || l == null) break;
			ds.add(l);
		}
		br.close();
		System.out.println("Danh sach tu file ds.txt !!!");
		for(String i : ds) {
			System.out.println(i);
		}
	}
	public void hienthihopleandsavefile() throws Exception {
		FileReader fr = new FileReader("ds.txt");
		BufferedReader br = new BufferedReader(fr);
		while(true) {
			String l = br.readLine();
			if(l == null || l == "" )
				break;
			String[] c = l.split("[;]");
			if(c.length == 4 && (c[2].equals("chinhthuc") || c[2].equals("hopdong") ) )
				dshople.add(new nhanvien(c[0],c[1],c[2], Double.parseDouble(c[3])));
			else if(c.length == 5 && (c[2].equals("chinhthuc") || c[2].equals("hopdong") ))
				dshople.add(new giangvien(c[0],c[1],c[2],Double.parseDouble(c[3]),Double.parseDouble(c[4])));
		}
		br.close();
		
		FileWriter fw = new FileWriter("ketqua.txt");
		PrintWriter pw = new PrintWriter(fw);
		System.out.println("--------------------------");
		System.out.println("Danh sach cac hang hop le !!!");
		for(nguoi i : dshople) {
			if(i instanceof nhanvien) {
				System.out.println(((nhanvien)i).toString());
				pw.println(((nhanvien)i).toString());
			}
			else if(i instanceof giangvien) {
				System.out.println(((giangvien)i).toString());
				pw.println(((giangvien)i).toString());
			}
		}
		pw.close();
	}
	public void hienthiriengbiet() throws Exception {
		FileReader fr = new FileReader("ketqua.txt");
		BufferedReader br = new BufferedReader(fr);
		while(true) {
			String l = br.readLine();
			if(l == null || l == "") break;
			String[] c = l.split("[;]");
			if(c.length == 4)
				dsriengbiet.add(new nhanvien(c[0],c[1],c[2], Double.parseDouble(c[3])));
			else if(c.length == 5 )
				dsriengbiet.add(new giangvien(c[0],c[1],c[2],Double.parseDouble(c[3]),Double.parseDouble(c[4])));
		}
		br.close();
		System.out.println("--------------------------");
		System.out.println("Danh sach nhan vien !!!");
		for(nguoi i : dsriengbiet) {
			if(i instanceof nhanvien)
				System.out.println(((nhanvien)i).toString());
		}
		System.out.println("--------------------------");
		System.out.println("Danh sach Giang vien !!!");
		for(nguoi i : dsriengbiet) {
			if(i instanceof giangvien)
				System.out.println(((giangvien)i).toString());
		}
	}
	
	public boolean checkmnv(String mnv) throws Exception {
		String sql = "select * from nhanvien where mnv=?";
		PreparedStatement ps = ketnoidao.cn.prepareStatement(sql);
		ps.setString(1, mnv);
		ResultSet rs = ps.executeQuery();
		boolean kq = rs.next();
		rs.close();
		return kq;
	}
	public void luunhanviencsdl() throws Exception {
		ketnoidao knd = new ketnoidao();
		knd.ketnoi();
		String sql = "insert into nhanvien(mnv,hvt,lhd,hsl) values (?,?,?,?)";
		PreparedStatement ps = ketnoidao.cn.prepareStatement(sql);
		for(nguoi i : dsriengbiet) {
			if(i instanceof nhanvien) {
				if(checkmnv(((nhanvien)i).getMnv()) == true) break;
				ps.setString(1, ((nhanvien)i).getMnv());
				ps.setString(2, ((nhanvien)i).getHvt());
				ps.setString(3, ((nhanvien)i).getLhd());
				ps.setDouble(4, ((nhanvien)i).getHsl());
				ps.executeUpdate();
			}
		}
		System.out.println("Luu thanh cong du lieu nhan vien tu File -> CSDL");
	}
	public boolean checkmgv(String mgv) throws Exception {
		String sql = "select * from giangvien where mgv=?";
		PreparedStatement ps = ketnoidao.cn.prepareStatement(sql);
		ps.setString(1, mgv);
		ResultSet rs = ps.executeQuery();
		boolean kq = rs.next();
		rs.close();
		return kq;
	}
	public void luugiangviencsdl() throws Exception {
		ketnoidao knd = new ketnoidao();
		knd.ketnoi();
		String sql = "insert into giangvien(mgv,hvt,lhd,hsl,pc) values (?,?,?,?,?)";
		PreparedStatement ps = ketnoidao.cn.prepareStatement(sql);
		for(nguoi i : dsriengbiet) {
			if(i instanceof giangvien) {
				if(checkmgv(((giangvien)i).getMgv()) == true) break;
				ps.setString(1, ((giangvien)i).getMgv());
				ps.setString(2, ((giangvien)i).getHvt());
				ps.setString(3, ((giangvien)i).getLhd());
				ps.setDouble(4, ((giangvien)i).getHsl());
				ps.setDouble(5, ((giangvien)i).getPc());
				ps.executeUpdate();
			}
			
		}
		System.out.println("Luu thanh cong du lieu giang vien tu File -> CSDL");
	}
	public void TK() throws Exception{
		ketnoidao knd = new ketnoidao();
		knd.ketnoi();
		String sql = "select lhd, COUNT(lhd) as soluong from nhanvien group by lhd";
		PreparedStatement ps = ketnoidao.cn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			String lhd = rs.getString("lhd");
			int sl = rs.getInt("soluong");
			System.out.println("Loai hop dong: "+lhd+", So luong : " + sl);
		}
		
	}
//	public ArrayList<nhanvien> getdsnv() throws Exception{
//		ketnoidao knd = new ketnoidao();
//		knd.ketnoi();
//		String sql = "select * from nhanvien";
//		PreparedStatement ps = ketnoidao.cn.prepareStatement(sql);
//		ResultSet rs = ps.executeQuery();
//		while(rs.next()) {
//			String mnv = rs.getString("mnv");
//			String hvt = rs.getString("hvt");
//			String lhd = rs.getString("lhd");
//			Double hsl = rs.getDouble("hsl");
//			dsnv.add(new nhanvien(mnv,hvt,lhd,hsl));
//		}
//		rs.close();
//		ps.close();
//		return dsnv;
//	}
//	public void thongke() throws Exception{
////		for(nhanvien i : getdsnv()) {
////			System.out.println(i.toString());
////		}
//		int ct=0,hd=0;
//		dsnv = getdsnv();
//		for(nhanvien i : dsnv) {
//			if(i.getLhd().equals("chinhthuc")) ct++;
//			else if(i.getLhd().equals("hopdong")) hd++;
//		}
//		System.out.print("Chinh thuc : "+ct+"\n");
//		System.out.print("Hop dong : "+hd+"\n");
//	}
	public static void main(String[] args) throws Exception{
		nguoidao nd = new nguoidao();
		nd.hienthids();
		nd.hienthihopleandsavefile();
		nd.hienthiriengbiet();
		nd.luunhanviencsdl();
		nd.luugiangviencsdl();
		nd.TK();
	}
}
