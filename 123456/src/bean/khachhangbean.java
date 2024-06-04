package bean;

import java.sql.Date;

public class khachhangbean {
	private String mdv , tdv ,tkh ,mkh ;
	private Date ndk;
	public khachhangbean(String mdv, String tdv, String tkh, String mkh, Date ndk) {
		super();
		this.mdv = mdv;
		this.tdv = tdv;
		this.tkh = tkh;
		this.mkh = mkh;
		this.ndk = ndk;
	}
	public String getMdv() {
		return mdv;
	}
	public void setMdv(String mdv) {
		this.mdv = mdv;
	}
	public String getTdv() {
		return tdv;
	}
	public void setTdv(String tdv) {
		this.tdv = tdv;
	}
	public String getTkh() {
		return tkh;
	}
	public void setTkh(String tkh) {
		this.tkh = tkh;
	}
	public String getMkh() {
		return mkh;
	}
	public void setMkh(String mkh) {
		this.mkh = mkh;
	}
	public Date getNdk() {
		return ndk;
	}
	public void setNdk(Date ndk) {
		this.ndk = ndk;
	}
	@Override
	public String toString() {
		return mdv + ',' +  tdv+ ',' +  tkh+ ',' +  mkh+ ',' + ndk;
	}
	

}