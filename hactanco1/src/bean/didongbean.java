package bean;

import java.sql.Date;

public class didongbean extends dienthoaibean{
	private Date nhhbh;
	private int dlbn;
	public didongbean() {
		super();
		// TODO Auto-generated constructor stub
	}
	public didongbean(String mdt, String tdt, String hsx, float gia, Date nhhbh, int dlbn) {
		super(mdt, tdt, hsx, gia);
		this.nhhbh = nhhbh;
		this.dlbn = dlbn;
	}
	public Date getNhhbh() {
		return nhhbh;
	}
	public void setNhhbh(Date nhhbh) {
		this.nhhbh = nhhbh;
	}
	public int getDlbn() {
		return dlbn;
	}
	public void setDlbn(int dlbn) {
		this.dlbn = dlbn;
	}
	@Override
	public String toString() {
		return  super.toString()+";" + nhhbh + ";" + dlbn ;
	}
	
	
}
