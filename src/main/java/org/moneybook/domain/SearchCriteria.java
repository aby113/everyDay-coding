package org.moneybook.domain;

public class SearchCriteria extends Criteria {

	private Integer year;
	private Integer month;
	private Integer quarter;
	private Integer startDate;
	private Integer endDate;
	private String regdate;
	private String searchType;	//제목으로 검색하는지 작성자로 검색하는지의 여부
	private String keyword;
	
	
	
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
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
	
	public Integer getYear() {
		return year;
	}
	public void setYear(Integer year) {
		this.year = year;
	}
	public Integer getMonth() {
		return month;
	}
	public void setMonth(Integer month) {
		this.month = month;
	}
	
	public Integer getStartDate() {
		return startDate;
	}
	public void setStartDate(Integer startDate) {
		this.startDate = startDate;
	}
	public Integer getEndDate() {
		return endDate;
	}
	public void setEndDate(Integer endDate) {
		this.endDate = endDate;
	}
	public Integer getQuarter() {
		return quarter;
	}
	public void setQuarter(Integer quarter) {
		this.quarter = quarter;
	}
	@Override
	public String toString() {
		return "SearchCriteria [year=" + year + ", month=" + month + ", quarter=" + quarter + ", startDate=" + startDate
				+ ", endDate=" + endDate + ", regdate=" + regdate + ", searchType=" + searchType + ", keyword="
				+ keyword + "]";
	}
	
	
	
	
	
	
}
