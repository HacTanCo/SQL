package bo;

import java.util.ArrayList;

import bean.DienthoaiBean;
import bean.InternetBean;
import dao.KetNoiDao;
import dao.KhachHangDao;

public class KhachHangBo {
	KetNoiDao knd = new KetNoiDao();
	KhachHangDao khd = new KhachHangDao();
	public void KetNoiCSDLDao() throws Exception {
		knd.KetNoiCSDLDao();
	}
	public void HienThiVaLayDuLieu() throws Exception {
		khd.HienThiVaLayDuLieu();
	}
	public ArrayList<InternetBean> HienThiI(){
		return khd.HienThiI();
	}
	public ArrayList<DienthoaiBean> HienThiD(){
		return khd.HienThiD();
	}
	public ArrayList<InternetBean> hienthisql()throws Exception {
		return khd.hienthisql();
	}
	public ArrayList<InternetBean> hienthisqlnnn()throws Exception {
		return khd.hienthisqlnnn();
	}
	
}
