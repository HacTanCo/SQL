package view;

import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.table.DefaultTableModel;

import bean.hangbean;
import bo.hangbo;
import dao.hangdao;

import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JButton;
import javax.swing.JComboBox;
import java.awt.Font;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.swing.JTextField;
import java.awt.Color;
import javax.swing.JTabbedPane;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.ItemListener;
import java.awt.event.ActionEvent;
import java.awt.event.ItemEvent;
import java.awt.event.ActionListener;

public class frmbanhang extends JFrame {

	JComboBox cmbhang = new JComboBox();
	private JPanel contentPane;
	private JTextField txtmh;
	private JTextField txtth;
	private JTextField txtnnh;
	private JTextField txtsl;
	private JTextField txtgb;
	private JTable table;
	public hangbo hb = new hangbo();
	public hangdao hd = new hangdao();
	public ArrayList<hangbean> ds = new ArrayList<hangbean>();
	public ArrayList<String> ds1 = new ArrayList<String>();	
	public ArrayList<String> ds2 = new ArrayList<String>();	
	public SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	private JTextField txtthanhtien;
	private JTable table_1;
	/**
	 * Launch the application.
	 */
	public void napbanghang(ArrayList<hangbean> ds) throws Exception{
		DefaultTableModel dtm = new DefaultTableModel();
		dtm.addColumn("Mã Hàng");
		dtm.addColumn("Tên Hàng");
		dtm.addColumn("Ngày Nhập Hàng");
		dtm.addColumn("Số Lượng");
		dtm.addColumn("Giá Bán");
		 for(hangbean i : ds) {
		        String[] che =i.toString().split("[,]");
		        dtm.addRow(che);;
		    }
		table.setModel(dtm);
	}
	
	public void napbangban(ArrayList<String> ds1) throws Exception{
		DefaultTableModel dtm = new DefaultTableModel();
		dtm.addColumn("Tên Hàng");
		dtm.addColumn("Số Lượng");
		dtm.addColumn("Giá Bán");
		dtm.addColumn("Thành Tiền");
		dtm.addColumn("Ngày Mua Hàng");
		for(String i : ds1) {
			String[] che = i.split("[,]");
			dtm.addRow(che);
		}
		table_1.setModel(dtm);
	}
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					frmbanhang frame = new frmbanhang();
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

	public frmbanhang() {
		setTitle("Bán Hàng Của Hắc Tấn Có");
		addWindowListener(new WindowAdapter() {
			@Override
			public void windowOpened(WindowEvent e) {
				try {
					hb.ketnoi();
					FileReader fr = new FileReader("hang.txt");
					BufferedReader br = new BufferedReader(fr);
					while (true) {
						String st = br.readLine();
						if (st == null || st == "")
							break;
						cmbhang.addItem(st.split("[,]")[1]);
					}
					br.close();
				} catch (Exception e1) {
					e1.printStackTrace();
				}
				
			}
		});
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 1314, 772);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));

		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JLabel lblNewLabel = new JLabel("Ch\u1ECDn H\u00E0ng");
		lblNewLabel.setFont(new Font("Tahoma", Font.BOLD, 14));
		lblNewLabel.setBounds(221, 47, 95, 35);
		contentPane.add(lblNewLabel);
		
		JLabel lblNewLabel_1 = new JLabel("M\u00E3 H\u00E0ng");
		lblNewLabel_1.setFont(new Font("Tahoma", Font.BOLD, 14));
		lblNewLabel_1.setBounds(232, 108, 71, 32);
		contentPane.add(lblNewLabel_1);
		
		JLabel lblNewLabel_2 = new JLabel("T\u00EAn H\u00E0ng");
		lblNewLabel_2.setFont(new Font("Tahoma", Font.BOLD, 14));
		lblNewLabel_2.setBounds(231, 168, 71, 23);
		contentPane.add(lblNewLabel_2);
		
		JLabel lblNewLabel_3 = new JLabel("Ng\u00E0y Nh\u1EADp");
		lblNewLabel_3.setFont(new Font("Tahoma", Font.BOLD, 14));
		lblNewLabel_3.setBounds(220, 224, 95, 23);
		contentPane.add(lblNewLabel_3);
		
		JLabel lblNewLabel_4 = new JLabel("S\u1ED1 L\u01B0\u1EE3ng");
		lblNewLabel_4.setFont(new Font("Tahoma", Font.BOLD, 14));
		lblNewLabel_4.setBounds(232, 277, 71, 23);
		contentPane.add(lblNewLabel_4);
		
		JLabel lblNewLabel_5 = new JLabel("Gi\u00E1 B\u00E1n");
		lblNewLabel_5.setFont(new Font("Tahoma", Font.BOLD, 14));
		lblNewLabel_5.setBounds(232, 345, 71, 23);
		contentPane.add(lblNewLabel_5);
		
		JButton btnNewButton = new JButton("B\u00E1n");
		btnNewButton.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e)  {
				try {
					Double a = Double.parseDouble(txtgb.getText());
					Double b = Double.parseDouble(txtsl.getText());
					Double kq = a * b;
					txtthanhtien.setText(kq.toString());

					// th sl gb tt nm
					String th = cmbhang.getSelectedItem().toString();
					String sl = txtsl.getText().toString();
					String gb = txtgb.getText().toString();
					SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");
					java.util.Date n = new java.util.Date();
					String nm = sdf.format(n);
					String l = th+","+sl+","+gb+","+(Integer.parseInt(sl) * Double.parseDouble(gb)) +","+nm;
					ds1.add(l);
					napbangban(ds1);
				} catch (Exception e2) {
					// TODO: handle exception
					e2.printStackTrace();
				}
				
			}
		});
		btnNewButton.setForeground(Color.RED);
		btnNewButton.setFont(new Font("Tahoma", Font.BOLD, 15));
		btnNewButton.setBounds(426, 474, 111, 35);
		contentPane.add(btnNewButton);
		cmbhang.addItemListener(new ItemListener() {
			public void itemStateChanged(ItemEvent e) {
				try {
					ds = hb.gethang();
					String th = cmbhang.getSelectedItem().toString();
					for(hangbean i : ds) {
						String[] che = i.toString().split("[,]");
						if(che[1].equals(th)) {
							txtmh.setText(che[0]);
							txtth.setText(che[1]);
							txtnnh.setText(che[2]);
							txtgb.setText(che[4]);
						}
					}
				} catch (Exception e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				
			}
		});
		
		cmbhang.setBounds(382, 48, 171, 33);
		contentPane.add(cmbhang);
		
		txtmh = new JTextField();
		txtmh.setBounds(387, 112, 171, 32);
		contentPane.add(txtmh);
		txtmh.setColumns(10);
		
		txtth = new JTextField();
		txtth.setBounds(388, 166, 171, 32);
		contentPane.add(txtth);
		txtth.setColumns(10);
		
		txtnnh = new JTextField();
		txtnnh.setBounds(388, 224, 171, 32);
		contentPane.add(txtnnh);
		txtnnh.setColumns(10);
		
		txtsl = new JTextField();
		txtsl.setBounds(391, 273, 171, 35);
		contentPane.add(txtsl);
		txtsl.setColumns(10);
		
		txtgb = new JTextField();
		txtgb.setBounds(388, 333, 171, 35);
		contentPane.add(txtgb);
		txtgb.setColumns(10);
		
		JTabbedPane tabbedPane = new JTabbedPane(JTabbedPane.TOP);
		tabbedPane.setBounds(593, 42, 678, 463);
		contentPane.add(tabbedPane);
		
		JScrollPane scrollPane = new JScrollPane();
		tabbedPane.addTab("Danh Sách Hiện Có", null, scrollPane, null);
		
		table = new JTable();
		scrollPane.setViewportView(table);
		
		JScrollPane scrollPane_1 = new JScrollPane();
		tabbedPane.addTab("Danh Sách Đã Bán", null, scrollPane_1, null);
		
		table_1 = new JTable();
		scrollPane_1.setViewportView(table_1);
		
		JButton btnNewButton_1 = new JButton("Lấy Danh Sách Hàng");
		btnNewButton_1.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				try {
					ds = hb.gethang();
					napbanghang(ds);
				} catch (Exception e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			}
		});
		btnNewButton_1.setFont(new Font("Tahoma", Font.BOLD, 14));
		btnNewButton_1.setBounds(122, 542, 197, 35);
		contentPane.add(btnNewButton_1);
		
		JLabel lblNewLabel_6 = new JLabel("Thành Tiền");
		lblNewLabel_6.setFont(new Font("Tahoma", Font.BOLD, 14));
		lblNewLabel_6.setBounds(221, 396, 95, 31);
		contentPane.add(lblNewLabel_6);
		
		txtthanhtien = new JTextField();
		txtthanhtien.setBounds(392, 397, 171, 32);
		contentPane.add(txtthanhtien);
		txtthanhtien.setColumns(10);
		
		JButton btnNewButton_2 = new JButton("Search");
		btnNewButton_2.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				String x = txtth.getText().trim().toLowerCase();
				int dem = 0;
				for(hangbean i : ds) {
					if(i.getTh().trim().toLowerCase().contains(x.trim().toLowerCase())) {
						dem++;
						JOptionPane.showMessageDialog(null, "Đã tìm thấy:\n" +i.getMh()+","+i.getTh()+","+i.getNnh()+","+i.getSl()+","+i.getGb());
					}
				}
				
				if(dem==0) JOptionPane.showMessageDialog(null, "Không tìm thấy tên hàng: " + x);
			}
		});


		btnNewButton_2.setFont(new Font("Tahoma", Font.BOLD, 14));
		btnNewButton_2.setBounds(345, 542, 141, 35);
		contentPane.add(btnNewButton_2);
		
		JButton btnNewButton_3 = new JButton("Delete");
		btnNewButton_3.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				try {
					String x = txtmh.getText().trim().toLowerCase();
					int dem = 0;
					for(hangbean i : ds) {
						if(hb.xoa(x) > 0) {
							dem++;
							JOptionPane.showMessageDialog(null, "Đã DELETE thành công !!!");
							napbanghang(ds);
							ds.remove(i);
							txtmh.setText("");
							txtth.setText("");
							txtnnh.setText("");
							txtsl.setText("");
							txtgb.setText("");
							break;
						}
					}
					if(dem==0)	JOptionPane.showMessageDialog(null, "Không tìm thấy mã hàng cần xóa !!!");
					
				} catch (Exception e2) {
					// TODO: handle exception
					e2.printStackTrace();
				}
			}
		});
		btnNewButton_3.setFont(new Font("Tahoma", Font.BOLD, 14));
		btnNewButton_3.setBounds(517, 542, 141, 34);
		contentPane.add(btnNewButton_3);
		

		JButton btnNewButton_4 = new JButton("ADD");
		btnNewButton_4.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				try {
					String mh = txtmh.getText().toString();
					if(hd.checkma(mh) == true) {
						JOptionPane.showMessageDialog(null, "Mã hàng đã tồn tại!");
						return;
					}
					String th = txtth.getText().toString();
					String nnh = txtnnh.getText().toString();
					String sl = txtsl.getText().toString();
					String gb = txtgb.getText().toString();
					hangbean x = new hangbean(mh, th, new java.sql.Date(sdf.parse(nnh).getTime()), Integer.parseInt(sl), Double.parseDouble(gb));
					hb.them(mh, th, new java.sql.Date(sdf.parse(nnh).getTime()), Integer.parseInt(sl), Double.parseDouble(gb));
					napbanghang(ds);
		            JOptionPane.showMessageDialog(null, "Đã ADD thành công!");
				} catch (Exception e2) {
					// TODO: handle exception
					e2.printStackTrace();
				}
				
			}
		});
		btnNewButton_4.setFont(new Font("Tahoma", Font.BOLD, 14));
		btnNewButton_4.setBounds(520, 602, 138, 32);
		contentPane.add(btnNewButton_4);
		
		JButton btnNewButton_5 = new JButton("Update");
		btnNewButton_5.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				try {
					String x = txtmh.getText();
					if(hd.checkma(x) == false) JOptionPane.showMessageDialog(null, "Không tìm thấy mã hàng để sửa!");
					String th = txtth.getText().toString();
					String nnh = txtnnh.getText().toString();
					int sl = Integer.parseInt(txtsl.getText());
					double gb = Double.parseDouble(txtgb.getText());
					if(hb.sua(x, th, new java.sql.Date(sdf.parse(nnh).getTime()), sl, gb) > 0) {
						napbanghang(ds);
						JOptionPane.showMessageDialog(null, "Đã UPDATE thành công!");
					}
				} catch (Exception e2) {
					// TODO: handle exception
					e2.printStackTrace();
				}
			}
		});
		btnNewButton_5.setFont(new Font("Tahoma", Font.BOLD, 14));
		btnNewButton_5.setBounds(345, 603, 141, 30);
		contentPane.add(btnNewButton_5);
		
		JButton btnNewButton_6 = new JButton("Save File Hàng");
		btnNewButton_6.setForeground(Color.RED);
		btnNewButton_6.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				try {
					hb.savefile();
					JOptionPane.showMessageDialog(null, "Đã Save file hàng thành công!");
				} catch (Exception e2) {
					// TODO: handle exception
					e2.printStackTrace();
				}
			}
		});
		btnNewButton_6.setFont(new Font("Tahoma", Font.BOLD, 14));
		btnNewButton_6.setBounds(517, 656, 141, 32);
		contentPane.add(btnNewButton_6);
		
		JButton btnNewButton_7 = new JButton("Lấy Danh Sách Đã Bán");
		btnNewButton_7.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				try {
					FileReader fr = new FileReader("ban.txt");
					BufferedReader br = new BufferedReader(fr);
					while(true) {
						String l = br.readLine();
						if(l == "" || l == null) break;
						String[] che = l.split("[,]");
						ds2.add(che[0]+","+che[1]+","+che[2]+","+che[3]+","+che[4]);
						napbangban(ds2);
					}
					if(ds2.isEmpty()) JOptionPane.showMessageDialog(null, "Danh sách này đang rỗng!");
				} catch (Exception e2) {
					// TODO: handle exception
					e2.printStackTrace();
				}
			}
		});
		btnNewButton_7.setFont(new Font("Tahoma", Font.BOLD, 14));
		btnNewButton_7.setBounds(122, 603, 194, 35);
		contentPane.add(btnNewButton_7);
		
		JButton btnNewButton_8 = new JButton("Save File Bán");
		btnNewButton_8.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				try {
					FileWriter fw = new FileWriter("ban.txt",true);
					PrintWriter pw = new PrintWriter(fw);
					for(String i : ds1) {
						pw.print(i+"\n");
					}
					pw.close();
					JOptionPane.showMessageDialog(null, "Đã Save file bán thành công!");
				} catch (Exception e2) {
					// TODO: handle exception
					e2.printStackTrace();
				}
			}
		});
		btnNewButton_8.setForeground(Color.RED);
		btnNewButton_8.setFont(new Font("Tahoma", Font.BOLD, 14));
		btnNewButton_8.setBounds(122, 657, 194, 30);
		contentPane.add(btnNewButton_8);
		
		JButton btnNewButton_9 = new JButton("Tiền Lời");
		btnNewButton_9.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				try {
					double sum = 0;
					FileReader fr = new FileReader("ban.txt");
					BufferedReader br = new BufferedReader(fr);
					while(true) {
						String l = br.readLine();
						if(l==null || l=="") break;
						String[] che = l.split("[,]");
						sum += Double.parseDouble(che[3]);
					}
					br.close();
					if(sum==0) JOptionPane.showMessageDialog(null, "Chưa bán được mặt hàng nào !");
					else JOptionPane.showMessageDialog(null, "Doanh thu là 90% = "+sum*0.9 +" vnđ"+"\nTiền vốn là 10% = "+sum*0.1+" vnđ");
				} catch (Exception e2) {
					// TODO: handle exception
					e2.printStackTrace();
				}
			}
		});
		
		btnNewButton_9.setFont(new Font("Tahoma", Font.BOLD, 14));
		btnNewButton_9.setBounds(345, 656, 141, 32);
		contentPane.add(btnNewButton_9);
	}
}
