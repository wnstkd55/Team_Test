package kr.co.city;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class CityDAO {
	private Connection conn; //connection db�� �����ϰ� ���ִ� ��ü
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public CityDAO() {
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
	
	public ArrayList<City> getClist(){
		
		String SQL = "SELECT * FROM city";
		ArrayList<City> clist = new ArrayList<City>();
		try {
			pstmt = conn.prepareStatement(SQL);
			rs=pstmt.executeQuery(SQL);
		
		
		
		while(rs.next()) {
			City city = new City();
			city.setC_name(rs.getString(1));
			city.setC_ny(rs.getDouble(2));
			city.setC_nx(rs.getDouble(3));
			city.setC_pic(rs.getString(4));
			
			clist.add(city);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("���� ����Ʈ ����");
		}
		
		return clist;
	}
}
