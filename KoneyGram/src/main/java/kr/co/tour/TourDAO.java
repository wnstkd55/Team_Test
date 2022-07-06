package kr.co.tour;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class TourDAO {
	private Connection conn; //connection db에 접근하게 해주는 객체
	private PreparedStatement pstmt;
	private ResultSet rs;
	//Oracle에 접속 해주는 부분
	public TourDAO() {//생성자 실행될때마다 자동으로 db연결이 이루어질수 있도록함
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
	
	//여행지이름 조회
	public ArrayList<Tour> getTourName() {
		String SQL = "select t_name from tours";
		ArrayList<Tour> tnList = new ArrayList<Tour>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Tour tour = new Tour();
				tour.setT_name(rs.getString(1));
				tnList.add(tour);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("관광지명 리스트 오류");
		}
		return tnList;
	}
	
	//여행선택 리스트 만들기
	public ArrayList<Tour> selectTour() {
		String SQL = "select t_photo, t_name, t_ny, t_nx, t_city from tours";
		ArrayList<Tour> tnList = new ArrayList<Tour>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Tour tour = new Tour();
				tour.setT_photo(rs.getString(1));
				tour.setT_name(rs.getString(2));
				tour.setT_ny(rs.getDouble(3));
				tour.setT_nx(rs.getDouble(4));
				tour.setT_city(rs.getString(5));
				
				tnList.add(tour);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("관광지선택 리스트 오류");
		}
		return tnList;
	}	

	public ArrayList<Tour> getTList(){
		String SQL = "SELECT * FROM tours";
		ArrayList<Tour> tlist = new ArrayList<Tour>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs=pstmt.executeQuery(SQL);
			
			while(rs.next()) {
				Tour tour = new Tour();
				tour.setT_id(rs.getInt(1));
				tour.setT_name(rs.getString(2));
				tour.setT_loadaddress(rs.getString(3));
				tour.setT_gnumaddress(rs.getString(4));
				tour.setT_ny(rs.getDouble(5));
				tour.setT_nx(rs.getDouble(6));
				tour.setT_intro(rs.getString(7));
				tour.setT_tel(rs.getString(8));
				tour.setT_photo(rs.getString(9));
				tour.setT_city(rs.getString(10));
				
				tlist.add(tour);
			}
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("여행리스트 오류");
		}
		return tlist;
	}
	
	public ArrayList<Tour> SelectCity_T(String t_city){
		String SQL = "SELECT * FROM tours where t_city = ?";
		ArrayList<Tour> tlist = new ArrayList<Tour>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, t_city);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				Tour tour = new Tour();
				tour.setT_id(rs.getInt(1));
				tour.setT_name(rs.getString(2));
				tour.setT_loadaddress(rs.getString(3));
				tour.setT_gnumaddress(rs.getString(4));
				tour.setT_ny(rs.getDouble(5));
				tour.setT_nx(rs.getDouble(6));
				tour.setT_intro(rs.getString(7));
				tour.setT_tel(rs.getString(8));
				tour.setT_photo(rs.getString(9));
				tour.setT_city(rs.getString(10));
				
				tlist.add(tour);
			}
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("도시 선택 관광지 리스트 오류");
		}
		return tlist;
	}
	
	
	
	public Tour getTourInfo(String t_name) {
		String SQL = "SELECT * FROM tours WHERE t_name = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, t_name);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				Tour tour = new Tour();
				tour.setT_id(rs.getInt(1));
				tour.setT_name(rs.getString(2));
				tour.setT_loadaddress(rs.getString(3));
				tour.setT_gnumaddress(rs.getString(4));
				tour.setT_ny(rs.getDouble(5));
				tour.setT_nx(rs.getDouble(6));
				tour.setT_intro(rs.getString(7));
				tour.setT_tel(rs.getString(8));
				tour.setT_photo(rs.getString(9));
				tour.setT_city(rs.getString(10));
				
				return tour;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
