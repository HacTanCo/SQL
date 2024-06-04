package bean;

public class dienthoaibean {
	private String mdt,tdt,hsx;
	private float gia;
	public dienthoaibean() {
		super();
		// TODO Auto-generated constructor stub
	}
	public dienthoaibean(String mdt, String tdt, String hsx, float gia) {
		super();
		this.mdt = mdt;
		this.tdt = tdt;
		this.hsx = hsx;
		this.gia = gia;
	}
	public String getMdt() {
		return mdt;
	}
	public void setMdt(String mdt) {
		this.mdt = mdt;
	}
	public String getTdt() {
		return tdt;
	}
	public void setTdt(String tdt) {
		this.tdt = tdt;
	}
	public String getHsx() {
		return hsx;
	}
	public void setHsx(String hsx) {
		this.hsx = hsx;
	}
	public float getGia() {
		return gia;
	}
	public void setGia(float gia) {
		this.gia = gia;
	}
	@Override
	public String toString() {
		return mdt + ";" + tdt + ";" + hsx + ";" + gia;
	}
}
