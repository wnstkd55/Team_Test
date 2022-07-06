package kr.co.arrive_point;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class ArriveDAO {
	
	private Connection conn; //connection db에 접근하게 해주는 객체
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public ArriveDAO() {
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
	
	public ArrayList<Arrive> getAList(){
		String SQL = "SELECT * FROM arr_point";
		ArrayList<Arrive> alist = new ArrayList<Arrive>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs=pstmt.executeQuery(SQL);
			
			while(rs.next()) {
				Arrive arrive = new Arrive();
				arrive.setArr_id(rs.getString(1));
				arrive.setArr_loadaddress(rs.getString(2));
				arrive.setArr_gnumaddress(rs.getString(3));
				arrive.setArr_ny(rs.getDouble(4));
				arrive.setArr_nx(rs.getDouble(5));
				
				alist.add(arrive);
			}
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("도착지 리스트 오류");
		}
		return alist;
	}
	
}
