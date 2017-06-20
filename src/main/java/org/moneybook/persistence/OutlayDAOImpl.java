package org.moneybook.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.moneybook.domain.OutlayVO;
import org.moneybook.domain.StatisticsVO;
import org.springframework.stereotype.Repository;

@Repository
public class OutlayDAOImpl implements OutlayDAO{

	@Inject
	private SqlSession session;
	
	public String namespace = "org.moneybook.mapper.OutlayMapper";
	
	@Override
	public void insertOutlay(OutlayVO outVO) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace+".insertOutlay", outVO);
	}

	@Override
	public void insertOutStat(StatisticsVO statVO) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace+".insertOutStat", statVO);
	}

	@Override
	public void insertCardStat(StatisticsVO statVO) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace+".insertCardStat", statVO);
	}
	
	@Override
	public void updateOutStat(StatisticsVO statVO) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace+".updateOutStat", statVO);
	}
	

}
