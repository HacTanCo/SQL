package view;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Scanner;

import bean.hangbean;
import bo.hangbo;
import dao.hangdao;

public class hangview {
	public static void main(String[] args) {
	
	try {
		hangbo hb = new hangbo();
		hangdao hd = new hangdao();
		Scanner sc = new Scanner(System.in);
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		ArrayList<hangbean> ds = hb.gethang();
		
		hb.ketnoi();
		for(hangbean i : ds)
			System.out.println(i.toString());
		hb.luucsdl();
		//THEM
		System.out.println("\nThem 1 mat hang !!!");
		while(true) {
			System.out.print("nhap ma hang: ");
			String ma =sc.nextLine();
			if(hd.checkma(ma) == true)
				System.out.println("\nma da ton tai vui long nhap lai !!!");
			else {
				System.out.print("nhap ten hang: ");
				String tenhang = sc.nextLine();
				System.out.print("nhap ngay nhap hang (dd/MM/yyyy): ");
				String ngay = sc.nextLine();
				System.out.print("nhap so luong hang: ");
				int sl = sc.nextInt();
				System.out.print("nhap gia ban : ");
				double gb = sc.nextDouble();
				sc.nextLine();
				hb.them(ma, tenhang, new java.sql.Date(sdf.parse(ngay).getTime()), sl, gb);
				System.out.println("Da them !!!");
				break;
			}
		}
		
		for(hangbean i : ds)
			System.out.println(i.toString());
		//XOA
		System.out.println("\nXoa 1 mat hang !!!");
		while(true) {
			System.out.print("nhap ma de xoa: ");
			String x = sc.nextLine();
			if(hb.xoa(x)>0) {
				System.out.println("da xoa thanh cong !!!");
				break;
			}
			else {
				System.out.println("\nkhong tim thay ma hang de xoa, Nhap lai !!!");
			}
		}
		
				
		for(hangbean i : ds)
			System.out.println(i.toString());
		
//		//SUA
		System.out.println("\nSua 1 mat hang !!!");
		while(true) {
			System.out.print("nhap ma hang: ");
			String ma =sc.nextLine();
			if(hd.checkma(ma) == false) {
				System.out.println("\nkhong tim thay ma de sua, Nhap lai !!!");
			}
			else {
				System.out.print("nhap ten hang: ");
				String tenhang = sc.nextLine();
				System.out.print("nhap ngay nhap hang (dd/MM/yyyy): ");
				String ngay = sc.nextLine();
				System.out.print("nhap so luong hang: ");
				int sl = sc.nextInt();
				System.out.print("nhap gia ban : ");
				double gb = sc.nextDouble();
				if(hb.sua(ma, tenhang, new java.sql.Date(sdf.parse(ngay).getTime()), sl, gb)>0) {
					System.out.println("DA sua thanh cong !!!");
					break;
				}
			}
		}
		for(hangbean i : ds)
			System.out.println(i.toString());
		
//		//TIM KIEM
		sc.nextLine();
		System.out.println("\nTim 1 mat hang !!!");
		System.out.print("Nhap ten hang can tim: ");
		String th = sc.nextLine();
		int dem = 0;
		for(hangbean i : hb.timkiem(th)) {
			System.out.println(i.toString());
			dem++;
		}
		if(dem==0) System.out.println("Khong co mat hang ten: " + th);
		
		
//		hb.luufile();
		hb.savefile();
	} catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
}
}
