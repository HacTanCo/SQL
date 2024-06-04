package bean;

import java.sql.Date;

public class DienthoaiBean extends khachhangbean{
	private String ls;

	public DienthoaiBean(String mdv, String tdv, String tkh, String mkh, Date ndk, String ls) {
		super(mdv, tdv, tkh, mkh, ndk);
		this.ls = ls;
	}

	public String getLs() {
		return ls;
	}

	public void setLs(String ls) {
		this.ls = ls;
	}
	@Override
	public String toString() {
		return super.toString() + "," + ls;
	}
}
