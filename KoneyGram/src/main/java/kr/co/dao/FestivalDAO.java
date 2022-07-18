package kr.co.dao;

import java.util.List;

import kr.co.vo.FestivalVO;
import kr.co.vo.SearchCriteria;

public interface FestivalDAO {
	
	// 축제 목록 조회
	public List<FestivalVO> listFestival(SearchCriteria scri) throws Exception;
		
	// 축제 총 갯수
	public int listFCount(SearchCriteria scri) throws Exception;
	
	//축제 By admin
	public List<FestivalVO> listByAdmin (SearchCriteria scri) throws Exception;	
	
	//축제 By admin 개수
	public int listByCount(SearchCriteria scri) throws Exception;
	
	// 축제 조회
	public FestivalVO read(int f_code) throws Exception;
}
