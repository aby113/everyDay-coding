package org.moneybook.domain.dto;

public class ModifyDTO {

	private Integer out_no;
	private Integer inc_no;
	private Integer mno;
	private Integer cate_cd;
	private Integer cost;
	private Integer revenue;
	private String item;
	private String regdate;
	private String pay_code;
	private Integer money;
	public Integer getOut_no() {
		return out_no;
	}
	public void setOut_no(Integer out_no) {
		this.out_no = out_no;
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
	public Integer getCost() {
		return cost;
	}
	public void setCost(Integer cost) {
		this.cost = cost;
	}
	public Integer getRevenue() {
		return revenue;
	}
	public void setRevenue(Integer revenue) {
		this.revenue = revenue;
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
	public String getPay_code() {
		return pay_code;
	}
	public void setPay_code(String pay_code) {
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
		return "ModifyDTO [out_no=" + out_no + ", inc_no=" + inc_no + ", mno=" + mno + ", cate_cd=" + cate_cd
				+ ", cost=" + cost + ", revenue=" + revenue + ", item=" + item + ", regdate=" + regdate + ", pay_code="
				+ pay_code + ", money=" + money + "]";
	}
	
	
}
