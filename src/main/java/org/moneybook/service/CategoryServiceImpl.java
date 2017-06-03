package org.moneybook.service;

import java.util.List;

import javax.inject.Inject;

import org.moneybook.domain.CategoryVO;
import org.moneybook.persistence.CategoryDAO;
import org.springframework.stereotype.Service;

@Service
public class CategoryServiceImpl implements CategoryService {

	@Inject
	private CategoryDAO dao;
	
	@Override
	public List<CategoryVO> getCategory() throws Exception {
		// TODO Auto-generated method stub
		return dao.getCategory();
	}

}
