package org.moneybook.service;

import java.util.List;

import org.moneybook.domain.CategoryVO;

public interface CategoryService {

	public List<CategoryVO> getCategory()throws Exception;
}
