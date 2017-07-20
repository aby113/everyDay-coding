package org.moneybook.domain;

import java.util.Arrays;
import java.util.List;

import org.moneybook.domain.dto.ModifyDTO;

public class IncomeVO {

	private Integer inc_no;
	private Integer mno;
	private Integer cate_cd;
	private Integer revenue;
	private String item;
	private String regdate;
	private char pay_code;
	private Integer money;
	
	
	public IncomeVO() {
		// 현금으로 초기화
		this.pay_code = '0';
	}
	
	
	public Integer getInc_no() {
		return inc_no;
	}
	public void setInc_no(Integer inc_no) {
		this.inc_no = inc_no;
	}
	public Integer getMno() {
		return mno;
	}
	public void setMno(Integer mno) {
		this.mno = mno;
	}
	public Integer getCate_cd() {
		return cate_cd;
	}
	public void setCate_cd(Integer cate_cd) {
		this.cate_cd = cate_cd;
	}
	public Integer getRevenue() {
		return revenue;
	}
	public void setRevenue(Integer revenue) {
		this.revenue = revenue;
		this.money = revenue;
	}
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
			this.regdate = regdate.replace("-", "");
	}
	
	
	
	// 20170608 이라는 문자열이 들어오면 년도만 추출
	public String getYear()throws Exception{
		
		return this.regdate.substring(0, 4);
	}
	// 20170608 이라는 문자열이 들어오면 월 만 추출
	public String getMonth()throws Exception{
		
		return this.regdate.substring(4, 6);
	}
	public char getPay_code() {
		return pay_code;
	}
	public void setPay_code(char pay_code) {
		this.pay_code = pay_code;
	}


	public Integer getMoney() {
		return money;
	}


	public void setMoney(Integer money) {
		this.revenue = money;
	}
	
	public void copyData(Object dataObj){
		
		if(dataObj instanceof ModifyDTO){
			ModifyDTO dto = (ModifyDTO)dataObj;
			this.inc_no = dto.getInc_no();
			this.mno = dto.getMno();
			this.regdate = dto.getRegdate();
			this.item = dto.getItem();
			this.revenue = dto.getRevenue();
			this.cate_cd = dto.getCate_cd();
		}
	}
	
	


	@Override
	public String toString() {
		return "IncomeVO [inc_no=" + inc_no + ", mno=" + mno + ", cate_cd=" + cate_cd + ", revenue=" + revenue
				+ ", item=" + item + ", regdate=" + regdate + ", pay_code=" + pay_code + ", money=" + money + "]";
	}


	

	

	
	
	
	
	
	
	
}
