package org.moneybook.service;

import org.moneybook.domain.IncomeVO;
import org.moneybook.domain.dto.MultiDelDTO;

public interface IncomeService {

	public void registerIncome(IncomeVO incomeVO)throws Exception;
	
	public void multiRemoveIncome(MultiDelDTO dto)throws Exception;
	
	
}
