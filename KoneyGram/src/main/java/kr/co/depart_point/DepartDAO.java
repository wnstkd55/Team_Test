package kr.co.depart_point;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class DepartDAO {
	
	private Connection conn; //connection db에 접근하게 해주는 객체
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
			
			System.out.println("DB에 연결 되었습니다.\n");
			
		}catch(ClassNotFoundException e) {
			System.out.println("DB 드라이버 로딩 실패 :" +e.toString());
		}catch(SQLException sqle) {
			System.out.println("DB 접속실패 :"+sqle.toString());
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
				System.out.println("도착지 리스트 오류");
			}
			return dlist;
		
	}	
}
