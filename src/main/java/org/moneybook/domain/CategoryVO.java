package org.moneybook.domain;

public class CategoryVO {

	private Integer cate_cd;
	private String cate_name;
	public Integer getCate_cd() {
		return cate_cd;
	}
	public void setCate_cd(Integer cate_cd) {
		this.cate_cd = cate_cd;
	}
	public String getCate_name() {
		return cate_name;
	}
	public void setCate_name(String cate_name) {
		this.cate_name = cate_name;
	}
	@Override
	public String toString() {
		return "CategoryVO [cate_cd=" + cate_cd + ", cate_name=" + cate_name + "]";
	}
	
}
