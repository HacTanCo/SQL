package view;

import java.awt.BorderLayout;
import java.awt.EventQueue;
import java.util.ArrayList;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.table.DefaultTableModel;

import bean.DienthoaiBean;
import bean.InternetBean;
import bo.KhachHangBo;
import dao.KetNoiDao;

import javax.swing.JTabbedPane;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JButton;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

public class KhachHangView extends JFrame {

	private JPanel contentPane;
	private JTable tbI = new JTable();
	private JTable tbD = new JTable();
	public KhachHangBo khb = new KhachHangBo();
	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					KhachHangView frame = new KhachHangView();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}
	/**
	 * Create the frame.
	 */
	void HienI(ArrayList<InternetBean> ds) {
		DefaultTableModel Bang = new DefaultTableModel();
		Bang.addColumn("Ma DV");
		Bang.addColumn("Ten DV");
		Bang.addColumn("Ten KH");
		Bang.addColumn("Ma KH");
		Bang.addColumn("Ngay DK");
		Bang.addColumn("BT");
		for (InternetBean i:ds) {
			Bang.addRow(i.toString().split("[,]"));
		}
		tbI.setModel(Bang);
	}
	void HienD(ArrayList<DienthoaiBean> ds) {
		DefaultTableModel Bang = new DefaultTableModel();
		Bang.addColumn("Ma DV");
		Bang.addColumn("Ten DV");
		Bang.addColumn("Ten KH");
		Bang.addColumn("Ma KH");
		Bang.addColumn("Ngay DK");
		Bang.addColumn("Sim");
		for (DienthoaiBean i:ds) {
			Bang.addRow(i.toString().split("[,]"));
		}
		tbD.setModel(Bang);
	}
	public KhachHangView() throws Exception {
		khb.KetNoiCSDLDao();
		khb.HienThiVaLayDuLieu();
		
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 662, 300);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JTabbedPane tabbedPane = new JTabbedPane(JTabbedPane.TOP);
		tabbedPane.setBounds(0, 11, 224, 181);
		contentPane.add(tabbedPane);
		
		JScrollPane scrollPane = new JScrollPane();
		tabbedPane.addTab("Internet", null, scrollPane, null);
		
		scrollPane.setViewportView(tbI);
		
		JTabbedPane tabbedPane_1 = new JTabbedPane(JTabbedPane.TOP);
		tabbedPane_1.setBounds(306, 11, 224, 181);
		contentPane.add(tabbedPane_1);
		
		JScrollPane scrollPane_1 = new JScrollPane();
		tabbedPane_1.addTab("Dien Thoai", null, scrollPane_1, null);
		
		scrollPane_1.setViewportView(tbD);
		
		JButton btHTF = new JButton("Hien Thi File");
		btHTF.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent arg0) {
				HienI(khb.HienThiI());
				HienD(khb.HienThiD());
			}
		});
		btHTF.setBounds(220, 101, 89, 23);
		contentPane.add(btHTF);
		
		JButton btHTCSDL = new JButton("Hien Thi CSDL");
		btHTCSDL.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				try {
					HienI(khb.hienthisql());
				} catch (Exception e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			}
		});
		btHTCSDL.setBounds(10, 203, 114, 23);
		contentPane.add(btHTCSDL);
		
		JButton btHTLN = new JButton("Hien Thi Lau Nhat");
		btHTLN.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				try {
					HienI(khb.hienthisqlnnn());
				} catch (Exception e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			}
		});
		btHTLN.setBounds(135, 203, 124, 23);
		contentPane.add(btHTLN);
	}
}
