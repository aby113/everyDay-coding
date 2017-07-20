package org.moneybook.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.moneybook.domain.IncomeVO;
import org.moneybook.domain.StatisticsVO;
import org.moneybook.domain.dto.MultiDelDTO;
import org.springframework.stereotype.Repository;

@Repository
public class StatisticsDAOImpl implements StatisticsDAO{

	@Inject
	private SqlSession session;
	
	public String namespace = "org.moneybook.mapper.StatisticsMapper";
	
	@Override
	public void insertIcStat(StatisticsVO statVO) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace+".insertIcStat", statVO);
	}

	@Override
	public void updateIcStat(StatisticsVO statVO) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace+".updateIcStat", statVO);
	}

	@Override
	public void insertCardStat(StatisticsVO statVO) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace+".insertCardStat", statVO);
	}

	@Override
	public void insertOutStat(StatisticsVO statVO) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace+".insertOutStat", statVO);
	}

	@Override
	public void updateOutStat(StatisticsVO statVO) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace+".updateOutStat", statVO);
	}

	@Override
	public void subtractIncStat(MultiDelDTO dto) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace+".subtractIncStat", dto);
	}

	@Override
	public void subtractOutStat(MultiDelDTO dto) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace+".subtractOutStat", dto);
	}

	@Override
	public void subtractIncStat(IncomeVO incomeVO) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace+".subtractOutStat", incomeVO);
	}

	@Override
	public boolean isStatistics(IncomeVO incomeVO) throws Exception {
		// TODO Auto-generated method stub
		return (session.selectOne(namespace+".isStatistics", incomeVO)!=null?true:false);
	}

	@Override
	public void subtractOutStat(StatisticsVO statVO) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace+".subtractOutStat2", statVO);
	}

	@Override
	public boolean isStatistics(StatisticsVO statVO) throws Exception {
		// TODO Auto-generated method stub
		return (session.selectOne(namespace+".isStatistics2", statVO)!=null?true:false);
	}

	
	
	
}
