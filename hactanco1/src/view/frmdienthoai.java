package view;

import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.table.DefaultTableModel;

import bean.codinhbean;
import bean.didongbean;
import bean.dienthoaibean;
import bo.dienthoaibo;
import dao.ketnoidao;

import javax.swing.JTabbedPane;
import javax.swing.JScrollPane;
import java.awt.Font;
import javax.swing.JTable;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.sql.Date;
import java.util.ArrayList;
import java.awt.event.ActionEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

public class frmdienthoai extends JFrame {

	private JPanel contentPane;
	private JTable table;
	private JTable table_1;
	public dienthoaibo dtb = new dienthoaibo();

	/**
	 * Launch the application.
	 */
	public void napbangdidong(ArrayList<dienthoaibean> ds) {
		//String mdt, String tdt, String hsx, float gia, Date nhhbh, int dlbn
		DefaultTableModel dtm = new DefaultTableModel();
		dtm.addColumn("Mã điện thoại");
		dtm.addColumn("Tên điện thoại");
		dtm.addColumn("Hãng sản xuất");
		dtm.addColumn("Giá");
		dtm.addColumn("Ngày hết hạn bảo hành");
		dtm.addColumn("Dung lượng bộ nhớ");
		for(dienthoaibean i : ds) {
			if(i instanceof didongbean) {
				dtm.addRow(i.toString().split("[;]"));
			}
		}
		table.setModel(dtm);
	}
	public void napbangcodinh(ArrayList<dienthoaibean> ds) {
		//String mdt, String tdt, String hsx, float gia, String ms
		DefaultTableModel dtm = new DefaultTableModel();
		dtm.addColumn("Mã điện thoại");
		dtm.addColumn("Tên điện thoại");
		dtm.addColumn("Hãng sản xuất");
		dtm.addColumn("Giá");
		dtm.addColumn("Màu sắc");
		for(dienthoaibean i : ds) {
			if(i instanceof codinhbean) {
				dtm.addRow(i.toString().split("[;]"));
			}
		}
		table_1.setModel(dtm);
	}
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					frmdienthoai frame = new frmdienthoai();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the frame.
	 * @throws Exception 
	 */
	public frmdienthoai() throws Exception {
		dtb.ketnoidao();
		dtb.infilevahople();
		
		setFont(new Font("Dialog", Font.BOLD, 14));
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 901, 548);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));

		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JTabbedPane tabbedPane = new JTabbedPane(JTabbedPane.TOP);
		tabbedPane.setBounds(10, 25, 865, 334);
		contentPane.add(tabbedPane);
		
		JScrollPane scrollPane = new JScrollPane();
		tabbedPane.addTab("Di Động", null, scrollPane, null);
		
		table = new JTable();
		scrollPane.setViewportView(table);
		
		JScrollPane scrollPane_1 = new JScrollPane();
		tabbedPane.addTab("Cố Định", null, scrollPane_1, null);
		
		table_1 = new JTable();
		scrollPane_1.setViewportView(table_1);
		
		JButton btnNewButton = new JButton("L\u1EA5y DATA");
		btnNewButton.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				try {
					napbangcodinh(dtb.hople());
					napbangdidong(dtb.hople());
				} catch (Exception e2) {
					// TODO: handle exception
					e2.printStackTrace();
				}
			}
		});
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
			}
		});
		btnNewButton.setBounds(46, 402, 89, 23);
		contentPane.add(btnNewButton);
		
		JButton btnNewButton_1 = new JButton("\u0110\u1EA9y DATA -> CSDL");
		btnNewButton_1.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				try {
					dtb.add();
					JOptionPane.showMessageDialog(null, "Đẩy dữ liệu lên CSDL thành công !!!");
				} catch (Exception e2) {
					// TODO: handle exception
					e2.printStackTrace();
				}
			}
		});
		btnNewButton_1.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
			}
		});
		btnNewButton_1.setBounds(241, 402, 143, 23);
		contentPane.add(btnNewButton_1);
		
		JButton btnNewButton_2 = new JButton("New button");
		btnNewButton_2.setBounds(445, 402, 89, 23);
		contentPane.add(btnNewButton_2);
	}
}
