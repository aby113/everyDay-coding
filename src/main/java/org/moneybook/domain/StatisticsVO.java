package org.moneybook.domain;

import org.moneybook.utils.ValidityCheck;

public class StatisticsVO {

	private Integer mno;
	private String year;
	private String month;
	private Integer inc_amount;
	private Integer out_amount;
	private Integer card_amount;
	private String pay_code;
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
	
	public void copyData(Object dataObj) throws Exception{
		
		if(dataObj instanceof IncomeVO){
			IncomeVO vo = (IncomeVO) dataObj;
			this.mno = vo.getMno();
			this.year = vo.getYear();
			this.month = vo.getMonth();
			this.inc_amount = vo.getRevenue();
			
		}else if(dataObj instanceof OutlayVO){
			OutlayVO vo = (OutlayVO) dataObj;
			// 카드면 카드총액 = 가격;
			if(ValidityCheck.isCard(vo.getPay_code()))this.card_amount = vo.getCost();
			this.mno = vo.getMno();
			this.year = vo.getYear();
			this.month = vo.getMonth();
			this.out_amount = vo.getCost();
			this.pay_code = ""+vo.getPay_code();
		}
		
	}
	public String getPay_code() {
		return pay_code;
	}
	public void setPay_code(String pay_code) {
		this.pay_code = pay_code;
	}
	@Override
	public String toString() {
		return "StatisticsVO [mno=" + mno + ", year=" + year + ", month=" + month + ", inc_amount=" + inc_amount
				+ ", out_amount=" + out_amount + ", card_amount=" + card_amount + ", pay_code=" + pay_code + "]";
	}
	
	
	
	

	
	
	
	
}
