package bean;

import java.sql.Date;

public class hangbean {
	private String mh,th;
	private java.sql.Date nnh;
	private int sl;
	private double gb;
	public hangbean() {
		super();
		// TODO Auto-generated constructor stub
	}
	public hangbean(String mh, String th, Date nnh, int sl, double gb) {
		super();
		this.mh = mh;
		this.th = th;
		this.nnh = nnh;
		this.sl = sl;
		this.gb = gb;
	}
	public String getMh() {
		return mh;
	}
	public void setMh(String mh) {
		this.mh = mh;
	}
	public String getTh() {
		return th;
	}
	public void setTh(String th) {
		this.th = th;
	}
	public java.sql.Date getNnh() {
		return nnh;
	}
	public void setNnh(java.sql.Date nnh) {
		this.nnh = nnh;
	}
	public int getSl() {
		return sl;
	}
	public void setSl(int sl) {
		this.sl = sl;
	}
	public double getGb() {
		return gb;
	}
	public void setGb(double gb) {
		this.gb = gb;
	}
	@Override
	public String toString() {
		return mh + "," + th + "," + nnh + "," + sl + "," + gb;
	}
	
	
}
