package org.moneybook.service;

import java.util.List;
import java.util.Map;

import org.moneybook.domain.Criteria;
import org.moneybook.domain.SearchCriteria;
import org.moneybook.domain.TranHistoryDTO;

public interface TranHistoryService {

	// 수익 + 비용 리스트 페이징 쿼리
	public List<TranHistoryDTO> getTranHistory(Map<String, Object> param) throws Exception;

	// 년도별 거래내역
	public List<TranHistoryDTO> getYearTranHistory(Map<String, Object> year) throws Exception;

	// 월별 거래내역
	public List<TranHistoryDTO> getMonthTranHistory(Map<String, Object> yearAndMonth) throws Exception;

	// 분기별 거래내역
	public List<TranHistoryDTO> getQuarterTranHistory(Map<String, Object> yearAndQuarter) throws Exception;

	// 특정기간 거래내역(startDate, endDate)
	public List<TranHistoryDTO> getPeriodTranHistory(Map<String, Object> regdateInfo) throws Exception;

	// 특정 게시물 총 갯수
			public int getTotalCount(Map<String, Object> param)throws Exception; 
}
