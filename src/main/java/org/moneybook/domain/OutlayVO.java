package org.moneybook.domain;

import java.util.Arrays;
import java.util.List;

public class OutlayVO {

	private Integer out_no;
	private Integer mno;
	private Integer cate_cd;
	private Integer cost;
	private String item;
	private String regdate;
	private char pay_code;
	private Integer money;
	
	public OutlayVO() {
		// 결제코드 현금으로 초기화
		this.pay_code = '0';
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
		return this.regdate;
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
			this.cost = money;
		}


		@Override
		public String toString() {
			return "OutlayVO [out_no=" + out_no + ", mno=" + mno + ", cate_cd=" + cate_cd + ", cost=" + cost + ", item="
					+ item + ", regdate=" + regdate + ", pay_code=" + pay_code + ", money=" + money + "]";
		}


	


		




		
	
	
}
