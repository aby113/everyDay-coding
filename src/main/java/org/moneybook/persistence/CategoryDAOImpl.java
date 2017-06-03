package org.moneybook.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.moneybook.domain.CategoryVO;
import org.springframework.stereotype.Repository;

@Repository
public class CategoryDAOImpl implements CategoryDAO {

	@Inject
	private SqlSession session;
	
	private String namespace = "org.moneybook.mapper.MoneybookMapper";
	
	@Override
	public List<CategoryVO> getCategory() throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".getCategory");
		
	}

}
