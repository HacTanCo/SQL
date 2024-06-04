package bo;

import java.io.FileWriter;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import bean.hangbean;
import dao.hangdao;
import dao.ketnoidao;

public class hangbo {
	public ArrayList<hangbean> ds = new ArrayList<hangbean>();
	public ArrayList<String> ds1 = new ArrayList<String>();
	hangdao hd = new hangdao();
	ketnoidao knd = new ketnoidao();
	
	public void ketnoi() throws Exception {
		knd.ketnoi();
	}
	public ArrayList<hangbean> gethang() throws Exception {
		ds = hd.gethang();
		return ds;
	}
	public void luucsdl() throws Exception {
		hd.luucsdl();
	}
	
	public int them(String mh, String th, Date nnh, int sl, double gb)  throws Exception{
		ds.add(new hangbean(mh, th, nnh, sl, gb));
		return hd.them(mh, th, nnh, sl, gb);
	}
	public int xoa(String key) throws Exception{
		for(hangbean i : ds)
			if(i.getMh().equals(key)) {
				ds.remove(i);
				return hd.xoa(key);
			}
		return 0;
	}
	public int sua(String mh, String th, Date nnh, int sl, double gb) throws Exception{
		for(hangbean i : ds) {
			if(i.getMh().equals(mh)) {
				i.setTh(th);
				i.setNnh(nnh);
				i.setSl(sl);
				i.setGb(gb);
				return hd.sua(mh, th, nnh, sl, gb);
			}
		}
		return hd.sua(mh, th, nnh, sl, gb);
	}
	public ArrayList<hangbean> timkiem(String x) throws Exception {
		return hd.timkiem(x);
	}
	public void savefile() throws Exception{
		FileWriter fw = new FileWriter("hang.txt");
		PrintWriter pw = new PrintWriter(fw);
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		for(hangbean i : ds) {
			pw.print(i.getMh()+","+i.getTh()+","+sdf.format(i.getNnh())+","+i.getSl()+","+i.getGb()+"\n");
		}
		pw.close();
	}
}
