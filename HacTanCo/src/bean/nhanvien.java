package bean;

public class nhanvien extends nguoi {
	private String mnv;

	public nhanvien() {
		super();
		// TODO Auto-generated constructor stub
	}

	public nhanvien(String mnv ,String hvt, String lhd, Double hsl) {
		super(hvt, lhd, hsl);
		this.mnv = mnv;
	}

	public String getMnv() {
		return mnv;
	}

	public void setMnv(String mnv) {
		this.mnv = mnv;
	}

	@Override
	public String toString() {
		return  mnv + ";" + super.toString();
	}
	
}
