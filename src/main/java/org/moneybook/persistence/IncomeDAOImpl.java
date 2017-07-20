package org.moneybook.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.moneybook.domain.IncomeVO;
import org.moneybook.domain.StatisticsVO;
import org.moneybook.domain.dto.MultiDelDTO;
import org.springframework.stereotype.Repository;

@Repository
public class IncomeDAOImpl implements IncomeDAO {

	@Inject
	private SqlSession session;
	
	public String namespace = "org.moneybook.mapper.IncomeMapper";
	
	@Override
	public void insertIncome(IncomeVO incomeVO) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace+".insertIncome", incomeVO);
	}

	@Override
	public void multiDeleteIncome(List<MultiDelDTO> removeList) throws Exception {
		// TODO Auto-generated method stub
		session.delete(namespace+".multiDeleteIncome", removeList);
	}

	@Override
	public void updateIncome(IncomeVO incomeVO) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace+".updateIncome", incomeVO);
	}

	@Override
	public IncomeVO selectIncome(Integer inc_no) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+".selectIncome", inc_no);
	}

	

}
