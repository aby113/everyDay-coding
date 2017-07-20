package org.moneybook.domain.dto;

public class MbDTO {
	private Integer inc_no;
	private Integer out_no;
	private Integer mno;
	private Integer cate_cd;
	private Integer revenue;
	private Integer cost;
	private String item;
	private String regdate;
	private char pay_code;
	private Integer money;
	public Integer getInc_no() {
		return inc_no;
	}
	public void setInc_no(Integer inc_no) {
		this.inc_no = inc_no;
	}
	public Integer getOut_no() {
		return out_no;
	}
	public void setOut_no(Integer out_no) {
		this.out_no = out_no;
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
	}
	public Integer getCost() {
		return cost;
	}
	public void setCost(Integer cost) {
		this.cost = cost;
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
		this.money = money;
	}
	@Override
	public String toString() {
		return "MbDTO [inc_no=" + inc_no + ", out_no=" + out_no + ", mno=" + mno + ", cate_cd=" + cate_cd + ", revenue="
				+ revenue + ", cost=" + cost + ", item=" + item + ", regdate=" + regdate + ", pay_code=" + pay_code
				+ ", money=" + money + "]";
	}
}
