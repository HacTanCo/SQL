package bean;

public class giangvien extends nguoi {
	private String mgv;
	private Double pc;
	public giangvien() {
		super();
		// TODO Auto-generated constructor stub
	}
	public giangvien(String mgv,String hvt, String lhd, Double hsl, Double pc) {
		super(hvt, lhd, hsl);
		this.mgv = mgv;
		this.pc = pc;
	}
	public String getMgv() {
		return mgv;
	}
	public void setMgv(String mgv) {
		this.mgv = mgv;
	}
	public Double getPc() {
		return pc;
	}
	public void setPc(Double pc) {
		this.pc = pc;
	}
	@Override
	public String toString() {
		return  mgv  + ";" + super.toString() + ";" + pc ;
	}
	
}
