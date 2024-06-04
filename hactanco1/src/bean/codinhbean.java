package bean;

public class codinhbean extends dienthoaibean {
	private String ms;

	public codinhbean() {
		super();
		// TODO Auto-generated constructor stub
	}

	public codinhbean(String mdt, String tdt, String hsx, float gia, String ms) {
		super(mdt, tdt, hsx, gia);
		this.ms = ms;
	}

	public String getMs() {
		return ms;
	}

	public void setMs(String ms) {
		this.ms = ms;
	}

	@Override
	public String toString() {
		return  super.toString() + ";" + ms ;
	}
	
}
