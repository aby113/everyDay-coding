package org.moneybook.persistence;

import java.util.List;

import org.moneybook.domain.CategoryVO;

public interface CategoryDAO {

	public List<CategoryVO> getCategory()throws Exception;
	
	
}
