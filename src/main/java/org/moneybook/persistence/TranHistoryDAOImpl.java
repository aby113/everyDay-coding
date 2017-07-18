package org.moneybook.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.moneybook.domain.Criteria;
import org.moneybook.domain.SearchCriteria;
import org.moneybook.domain.StatisticsVO;
import org.moneybook.domain.dto.TranHistoryDTO;
import org.springframework.stereotype.Repository;

@Repository
public class TranHistoryDAOImpl implements TranHistoryDAO {

	@Inject
	private SqlSession session;
	
	public String namespace = "org.moneybook.mapper.TranHistoryMapper";
	
	// 존재하면 true리턴 존재하지않으면 false
	@Override
	public boolean isStatistics(StatisticsVO statVO) throws Exception {
		// TODO Auto-generated method stub
		return (session.selectOne(namespace+".isStatistics", statVO)!=null)? true : false;
	}

	//수익 + 비용 리스트 페이징 쿼리
	@Override
	public List<TranHistoryDTO> getTranHistory(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".getTranHistory", param);
	}
	// 년도별 거래내역
	@Override
	public List<TranHistoryDTO> getYearTranHistory(Map<String, Object> year) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".getYearTranHistory", year);
	}
	// 월별 거래내역
	@Override
	public List<TranHistoryDTO> getMonthTranHistory(Map<String, Object> yearAndMonth) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".getMonthTranHistory", yearAndMonth);
	}
	// 분기별 거래내역
	@Override
	public List<TranHistoryDTO> getQuarterTranHistory(Map<String, Object> yearAndQuarter) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".getQuarterTranHistory", yearAndQuarter);
	}
	// 특정기간 거래내역(startDate, endDate)
	@Override
	public List<TranHistoryDTO> getPeriodTranHistory(Map<String, Object> regdateInfo) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".getPeriodTranHistory", regdateInfo);
	}

	@Override
	public int getTotalCount(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return (int)session.selectOne(namespace+".getTotalCount", param);
	}

}
