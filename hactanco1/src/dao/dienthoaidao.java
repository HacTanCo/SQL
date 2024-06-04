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

import bean.codinhbean;
import bean.didongbean;
import bean.dienthoaibean;

public class dienthoaidao {
	public ArrayList<dienthoaibean> hople = new ArrayList<dienthoaibean>();
	public SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	
	public void infilevahople() throws Exception{
		FileReader fr = new FileReader("hactanco.txt");
		BufferedReader br = new BufferedReader(fr);
		System.out.println("Danh sach tu file hactanc.txt !!!");
		System.out.println("-------------------------------");
		while(true) {
			String l = br.readLine();
			if(l==null || l=="")break;
			System.out.println(l);
			String[] c = l.split("[;]");
			if (c.length == 5 && c[0].startsWith("CD") && c[0].substring(2).matches("\\d{4}")) {
				hople.add(new codinhbean(c[0], c[1], c[2], Float.parseFloat(c[3]), c[4]));
			}
			if (c.length == 6 && c[0].startsWith("DD") && c[0].substring(2).matches("\\d{4}")) {
				hople.add(new didongbean(c[0],c[1], c[2], Float.parseFloat(c[3]), new Date(sdf.parse(c[4]).getTime()), Integer.parseInt(c[5])));
			}
		}
		br.close();
		System.out.println("-------------------------------");
		System.out.println("\nDanh sach sau hop le !!!");
		System.out.println("-------------------------------");
		FileWriter fw = new FileWriter("ketqua.txt");
		PrintWriter pw = new PrintWriter(fw);
		for(dienthoaibean i : hople) {
			if(i instanceof didongbean) {
				System.out.println(i.toString());
				pw.println(i);
			}
			if(i instanceof codinhbean) {
				System.out.println(i.toString());
				pw.println(i);
			}
		}
		pw.close();
		System.out.println("-------------------------------");
	}
	public void inriengbiet() throws Exception{
		System.out.println("\nDanh sach dien thoai co dinh !!!");
		System.out.println("-------------------------------");
		for(dienthoaibean i : hople ) {
			if(i instanceof codinhbean) {
				System.out.println(i.toString());
			}
		}
		System.out.println("-------------------------------");
		
		System.out.println("\nDanh sach dien thoai di dong !!!");
		System.out.println("-------------------------------");
		for(dienthoaibean i : hople ) {
			if(i instanceof didongbean) {
				System.out.println(i.toString());
			}
		}
		System.out.println("-------------------------------");
	}
	public boolean checkma(String x)throws Exception{
		String sql = "select * from didong where mdt = ?";
		PreparedStatement ps = ketnoidao.cn.prepareStatement(sql);
		ps.setString(1, x);
		ResultSet rs = ps.executeQuery();
		boolean check = rs.next();
		rs.close();
		return check;
	}
	public void them(String mdt, String tdt, String hsx, float gia, Date nhhbh, int dlbn)throws Exception {
		String sql = "insert into didong(mdt,tdt,hsx,gia,nhhbh,dlbn) values(?,?,?,?,?,?)";
		PreparedStatement ps = ketnoidao.cn.prepareStatement(sql);
		ps.setString(1, mdt);
		ps.setString(2, tdt);
		ps.setString(3, hsx);
		ps.setFloat(4, gia);
		ps.setDate(5, nhhbh);
		ps.setInt(6, dlbn);
		ps.executeUpdate();
	}
	public void add() throws Exception{
		for(dienthoaibean i : hople) {
			if(i instanceof didongbean) {
				if(!checkma(i.getMdt())) {
					them(i.getMdt(), i.getTdt(), i.getHsx(), i.getGia(), ((didongbean) i).getNhhbh(), ((didongbean) i).getDlbn());
				}
			}
		}
		System.out.println("Luu DATA -> CSDL thanh cong !!!");
	}

}
