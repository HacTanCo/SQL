package bo;

import java.util.ArrayList;

import bean.nguoi;
import bean.nhanvien;
import dao.ketnoidao;
import dao.nguoidao;

public class nguoibo {
	public ArrayList<String> ds = new ArrayList<String>();
	public ArrayList<nguoi> dshople = new ArrayList<nguoi>();
	public ArrayList<nguoi> dsriengbiet = new ArrayList<nguoi>();
	public ArrayList<nhanvien> dsnv = new ArrayList<nhanvien>();
	public nguoidao nd = new nguoidao();
	public ketnoidao knd = new ketnoidao();
	
//	public void ketnoi () throws Exception{
//		knd.ketnoi();
//	}
	public void hienthids() throws Exception{
		nd.hienthids();
	}
	public void hienthihopleandsavefile() throws Exception {
		nd.hienthihopleandsavefile();
	}
	public void hienthiriengbiet() throws Exception {
		nd.hienthiriengbiet();
	}
	public void luunhanviencsdl() throws Exception {
		nd.luunhanviencsdl();
	}
	public void luugiangviencsdl() throws Exception {
		nd.luugiangviencsdl();
	}
	public void TK() throws Exception{
		nd.TK();
	}
	public static void main(String[] args)throws Exception {
		nguoibo nb = new nguoibo();
		nb.hienthids();
		nb.hienthihopleandsavefile();
		nb.hienthiriengbiet();
		nb.luunhanviencsdl();
		nb.luugiangviencsdl();
		nb.TK();
	}
}
