package bean;

import java.sql.Date;

public class InternetBean extends khachhangbean{
	private String bt;

	public InternetBean(String mdv, String tdv, String tkh, String mkh, Date ndk, String bt) {
		super(mdv, tdv, tkh, mkh, ndk);
		this.bt = bt;
	}

	public String getBt() {
		return bt;
	}

	public void setBt(String bt) {
		this.bt = bt;
	}

	@Override
	public String toString() {
		return super.toString() + "," + bt;
	}
	
}
