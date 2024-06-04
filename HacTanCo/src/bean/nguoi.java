package bean;

public class nguoi {
	private String hvt,lhd;
	private Double hsl;
	public nguoi() {
		super();
		// TODO Auto-generated constructor stub
	}
	public nguoi(String hvt, String lhd, Double hsl) {
		super();
		this.hvt = hvt;
		this.lhd = lhd;
		this.hsl = hsl;
	}
	public String getHvt() {
		return hvt;
	}
	public void setHvt(String hvt) {
		this.hvt = hvt;
	}
	public String getLhd() {
		return lhd;
	}
	public void setLhd(String lhd) {
		this.lhd = lhd;
	}
	public Double getHsl() {
		return hsl;
	}
	public void setHsl(Double hsl) {
		this.hsl = hsl;
	}
	@Override
	public String toString() {
		return hvt +";"+ lhd +";"+ hsl;
	}
	
}
