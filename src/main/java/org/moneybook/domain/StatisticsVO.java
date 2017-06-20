package org.moneybook.domain;

public class StatisticsVO {

	private Integer mno;
	private String year;
	private String month;
	private Integer inc_amount;
	private Integer out_amount;
	private Integer card_amount;
	public Integer getMno() {
		return mno;
	}
	public void setMno(Integer mno) {
		this.mno = mno;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public Integer getInc_amount() {
		return inc_amount;
	}
	public void setInc_amount(Integer inc_amount) {
		this.inc_amount = inc_amount;
	}
	public Integer getOut_amount() {
		return out_amount;
	}
	public void setOut_amount(Integer out_amount) {
		this.out_amount = out_amount;
	}
	public Integer getCard_amount() {
		return card_amount;
	}
	public void setCard_amount(Integer card_amount) {
		this.card_amount = card_amount;
	}
	@Override
	public String toString() {
		return "StatisticsVO [mno=" + mno + ", year=" + year + ", month=" + month + ", inc_amount=" + inc_amount
				+ ", out_amount=" + out_amount + ", card_amount=" + card_amount + "]";
	}
	
	

	
	
	
	
}
