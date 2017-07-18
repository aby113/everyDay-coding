package org.moneybook.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.moneybook.domain.OutlayVO;
import org.moneybook.domain.StatisticsVO;
import org.moneybook.domain.dto.MultiDelDTO;
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
	public void multiDeleteOutlay(List<MultiDelDTO> removeList) throws Exception {
		// TODO Auto-generated method stub
		session.delete(namespace+".multiDeleteOutlay", removeList);
	}


	

}
