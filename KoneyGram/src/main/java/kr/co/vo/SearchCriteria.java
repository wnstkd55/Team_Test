package kr.co.vo;

public class SearchCriteria extends Criteria{

	private String searchType = "";
	private String keyword = "";
	private String f_admin;
	 
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getF_admin() {
		return f_admin;
	}
	public void setF_admin(String f_admin) {
		this.f_admin = f_admin;
	}
	@Override
	public String toString() {
		return "SearchCriteria [searchType=" + searchType + ", keyword=" + keyword + "]";
	}
	
}