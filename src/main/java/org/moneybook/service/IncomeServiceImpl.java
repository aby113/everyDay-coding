package org.moneybook.service;

import javax.inject.Inject;

import org.moneybook.domain.IncomeVO;
import org.moneybook.domain.StatisticsVO;
import org.moneybook.persistence.IncomeDAO;
import org.moneybook.persistence.TranHistoryDAO;
import org.springframework.stereotype.Service;

@Service
public class IncomeServiceImpl implements IncomeService {

	@Inject
	private IncomeDAO incDAO;
	
	@Inject
	private TranHistoryDAO tranDAO;
	
	@Override
	public void registerIncome(IncomeVO incomeVO) throws Exception {

		// incomeVO에게서 회원번호, 년, 월, 금액 추출
		StatisticsVO statVO = new StatisticsVO();
		statVO.setMno(incomeVO.getMno());
		statVO.setYear(incomeVO.getYear());
		statVO.setMonth(incomeVO.getMonth());
		statVO.setInc_amount(incomeVO.getRevenue());
		
		// 통계테이블에서 해당 회원 / 년 / 월 이 잇는지 확인
		boolean result = tranDAO.isStatistics(statVO);
		// 존재하면 기존 통계테이블 값 update
		if(result){
			incDAO.insertIncome(incomeVO);
			incDAO.updateIcStat(statVO);
			return;
		}
		// 존재하지않으면 값입력
		incDAO.insertIncome(incomeVO);
		incDAO.insertIcStat(statVO);
	}

	
	
	
	
}
