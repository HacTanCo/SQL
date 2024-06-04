package bo;

import java.util.ArrayList;

import bean.codinhbean;
import bean.didongbean;
import bean.dienthoaibean;
import dao.dienthoaidao;
import dao.ketnoidao;

public class dienthoaibo {
	ketnoidao knd = new ketnoidao();
	dienthoaidao dtd = new dienthoaidao();
	public void ketnoidao()throws Exception{
		knd.ketnoidao();
	}
	public void infilevahople() throws Exception{
		dtd.infilevahople();
	}
	public void inriengbiet() throws Exception{
		dtd.inriengbiet();
	}
	public void add() throws Exception{
		dtd.add();
	}
	public ArrayList<dienthoaibean> hople() throws Exception{
		return dtd.hople;
	}
}
