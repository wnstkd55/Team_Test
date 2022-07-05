package kr.co.depart_point;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class DepartDAO {
	
	private Connection conn; //connection db�� �����ϰ� ���ִ� ��ü
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public DepartDAO() {
		try {
			String driverName = "oracle.jdbc.driver.OracleDriver";
			String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
			String dbID = "hr3";
			String dbPassword = "1234";
			
			Class.forName(driverName);
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			
			System.out.println("DB�� ���� �Ǿ����ϴ�.\n");
			
		}catch(ClassNotFoundException e) {
			System.out.println("DB ����̹� �ε� ���� :" +e.toString());
		}catch(SQLException sqle) {
			System.out.println("DB ���ӽ��� :"+sqle.toString());
		}catch(Exception e) {
			System.out.println("Unkonwn error");
			e.printStackTrace();
		}
	}
		
		public ArrayList<Depart> getDList(){
			String SQL = "SELECT * FROM dp_point";
			ArrayList<Depart> dlist = new ArrayList<Depart>();
			
			try {
				pstmt = conn.prepareStatement(SQL);
				rs=pstmt.executeQuery(SQL);
				
				while(rs.next()) {
					Depart depart = new Depart();
					depart.setDp_id(rs.getString(1));
					depart.setDp_loadaddress(rs.getString(2));
					depart.setDp_gnumaddress(rs.getString(3));
					depart.setDp_ny(rs.getDouble(4));
					depart.setDp_nx(rs.getDouble(5));
					
					dlist.add(depart);
				}
			}catch(Exception e) {
				e.printStackTrace();
				System.out.println("������ ����Ʈ ����");
			}
			return dlist;
		
	}	
}
