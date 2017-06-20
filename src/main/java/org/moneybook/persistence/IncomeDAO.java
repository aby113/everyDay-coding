package org.moneybook.persistence;

import org.moneybook.domain.IncomeVO;
import org.moneybook.domain.StatisticsVO;

public interface IncomeDAO {

	// 수익 작성
	public void insertIncome(IncomeVO incomeVO)throws Exception;
	// 해당 회원/년/월 통계정보가없으면 입력
	public void insertIcStat(StatisticsVO statVO)throws Exception;
	// 해당 회원/년/월 통계정보가 존재시 수정
	public void updateIcStat(StatisticsVO statVO)throws Exception;
	
	
	
	
}
