package org.moneybook.utils;

public class ValidityCheck {

	public static boolean isCard(char pay_code) {

		if ('1' == pay_code) {
			return true;
		}
		return false;
	}

	public static boolean isCard(String pay_code) {

		if ("1".equals(pay_code)) {
			return true;
		}
		return false;
	}
	
	public static boolean isIncome(Integer revenue){
		
		if(revenue == null){
			return false;
		}
		return true;
	}
}
