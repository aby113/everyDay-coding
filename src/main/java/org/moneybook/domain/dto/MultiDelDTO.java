package org.moneybook.domain.dto;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class MultiDelDTO {

	private List<MultiDelDTO> incList;
	private List<MultiDelDTO> outList;
	private int number;
	private Integer mno;
	private String regdate;
	private String pay_code;
	private Integer money;
	
	// 20170608 이라는 문자열이 들어오면 년도만 추출
	public String getYear() throws Exception {

		return this.regdate.substring(0, 4);
	}

	// 20170608 이라는 문자열이 들어오면 월 만 추출
	public String getMonth() throws Exception {

		return this.regdate.substring(4, 6);
	}

	public List<MultiDelDTO> getIncList() {
		return incList;
	}

	public void setIncList(List<MultiDelDTO> incList) {
		this.incList = incList;
	}

	public List<MultiDelDTO> getOutList() {
		return outList;
	}

	public void setOutList(List<MultiDelDTO> outList) {
		this.outList = outList;
	}

	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	public Integer getMno() {
		return mno;
	}

	public void setMno(Integer mno) {
		this.mno = mno;
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

	
	
	

	

	

	
	
}
