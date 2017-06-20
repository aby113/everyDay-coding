package org.moneybook.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.moneybook.domain.Criteria;
import org.moneybook.domain.SearchCriteria;
import org.moneybook.domain.TranHistoryDTO;
import org.moneybook.persistence.TranHistoryDAO;
import org.springframework.stereotype.Service;

@Service
public class TranHistoryServiceImpl implements TranHistoryService{

	@Inject
	private TranHistoryDAO tranDAO;
	
	// 수익 + 비용 리스트 페이징 쿼리
	@Override
	public List<TranHistoryDTO> getTranHistory(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return tranDAO.getTranHistory(param);
	}
	// 년도별 거래내역
	@Override
	public List<TranHistoryDTO> getYearTranHistory(Map<String, Object> year) throws Exception {
		// TODO Auto-generated method stub
		return tranDAO.getYearTranHistory(year);
	}
	// 월별 거래내역
	@Override
	public List<TranHistoryDTO> getMonthTranHistory(Map<String, Object> yearAndMonth) throws Exception {
		// TODO Auto-generated method stub
		return tranDAO.getMonthTranHistory(yearAndMonth);
	}
	// 분기별 거래내역
	@Override
	public List<TranHistoryDTO> getQuarterTranHistory(Map<String, Object> yearAndQuarter) throws Exception {
		// TODO Auto-generated method stub
		return tranDAO.getQuarterTranHistory(yearAndQuarter);
	}
	// 특정기간 거래내역(startDate, endDate)
	@Override
	public List<TranHistoryDTO> getPeriodTranHistory(Map<String, Object> regdateInfo) throws Exception {
		// TODO Auto-generated method stub
		return tranDAO.getPeriodTranHistory(regdateInfo);
	}
	@Override
	public int getTotalCount(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return tranDAO.getTotalCount(param);
	}
	
	

}
