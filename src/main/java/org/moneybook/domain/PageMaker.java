package org.moneybook.domain;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class PageMaker {
	//페이지 정보
	private int totalCount;
	private int startPage;
	private int endPage;
	private int totalPage;
	private boolean prev;
	private boolean next;
	
	private int displayPageNum = 10;
	
	private Criteria cri;


	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public void setCri(Criteria cri) {
		this.cri = cri;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		
		calcData();
		System.out.println("흠:"+this.endPage);
	}

	private void calcData() {
		
		this.endPage = (int) (Math.ceil(cri.getPage() / (double)displayPageNum ) * displayPageNum);
		System.out.println("체크2: " + cri.getPage());
		System.out.println("체크3: " + endPage);
		System.out.println("체크4: " + totalCount);
		startPage = (endPage - displayPageNum) + 1;
		
		totalPage = (int)(Math.ceil(totalCount / (double)cri.getPerPageNum()));
		System.out.println("totalPage : " + totalPage);
		if(endPage > totalPage){
			endPage = totalPage;
		}
		
		prev = startPage ==1 ? false : true;
		
		next = endPage * cri.getPerPageNum() >= totalCount ? false : true;
		
	}

	public int getTotalCount() {
		return totalCount;
	}

	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public boolean isNext() {
		return next;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public Criteria getCri() {
		return cri;
	}
	
	public String makeQuery(int page){
		
		UriComponents uriComponents =
	            UriComponentsBuilder.newInstance()
	            .queryParam("page", page)
	            .queryParam("perPageNum", cri.getPerPageNum())
	            .build();	            
		
		return uriComponents.toUriString();
	}

	

	@Override
	public String toString() {
		return "PageMaker [totalCount=" + totalCount + ", startPage=" + startPage + ", endPage=" + endPage
				+ ", totalPage=" + totalPage + ", prev=" + prev + ", next=" + next + ", displayPageNum="
				+ displayPageNum + ", cri=" + cri + "]";
	}	
	
	
	
	
}
