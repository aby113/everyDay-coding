package org.moneybook.utils;

import org.moneybook.domain.IncomeVO;
import org.moneybook.domain.OutlayVO;
import org.moneybook.domain.StatisticsVO;

public class BindingObject {

	public static StatisticsVO bindStatVO(Object dataObj) throws Exception{
		StatisticsVO statVO = new StatisticsVO();
		statVO.copyData(dataObj);
		return statVO;
	}
	
	public static IncomeVO bindIncome(Object dataObj)throws Exception{
		IncomeVO incomeVO = new IncomeVO();
		incomeVO.copyData(dataObj);
		return incomeVO;
	}
	
	public static OutlayVO bindOutlay(Object dataObj)throws Exception{
		OutlayVO outlayVO = new OutlayVO();
		outlayVO.copyData(dataObj);
		return outlayVO;
	}
}
