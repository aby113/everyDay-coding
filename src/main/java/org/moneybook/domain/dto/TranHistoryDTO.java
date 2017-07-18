package org.moneybook.domain.dto;

// 거래내역 DTO
public class TranHistoryDTO {

	private Integer num;
	private Integer mno;
	private Integer cate_cd;
	private char pay_code;
	private String payment;
	private Integer money;
	private String item;
	private String regdate;
	private String cate_name;
	
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
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
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
	}
	public Integer getMoney() {
		return money;
	}
	public void setMoney(Integer money) {
		this.money = money;
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
		this.regdate = regdate;
	}
	public String getCate_name() {
		return cate_name;
	}
	public void setCate_name(String cate_name) {
		this.cate_name = cate_name;
	}
	
	public char getPay_code() {
		return pay_code;
	}
	public void setPay_code(char pay_code) {
		this.pay_code = pay_code;
	}
	@Override
	public String toString() {
		return "TranHistoryDTO [num=" + num + ", mno=" + mno + ", cate_cd=" + cate_cd + ", pay_code=" + pay_code
				+ ", payment=" + payment + ", money=" + money + ", item=" + item + ", regdate=" + regdate
				+ ", cate_name=" + cate_name + "]";
	}
	
	
	
	
}
