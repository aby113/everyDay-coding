package org.moneybook.controller;

import org.junit.Ignore;
import org.junit.Test;
import org.moneybook.domain.IncomeVO;

public class JavaTest {

	@Test
	@Ignore
	public void test() {
		
		String str = "2017-01-01";
		String result = str.replace("-", "");
		System.out.println(result);
	}
	
	@Test
	@Ignore
	public void test2(){
		
		IncomeVO vo = new IncomeVO();
		Object dataObj = vo;
		if(dataObj instanceof IncomeVO){
		}else{
			System.out.println("false");
		}
		
	}
	
	

}
