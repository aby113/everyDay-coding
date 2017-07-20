package org.moneybook.persistence;

import java.util.List;

import org.moneybook.domain.IncomeVO;
import org.moneybook.domain.dto.MultiDelDTO;

public interface IncomeDAO {

	// 수익 작성
	public void insertIncome(IncomeVO incomeVO)throws Exception;
	// 해당 회원 삭제
	public void multiDeleteIncome(List<MultiDelDTO> removeList)throws Exception;
	// 수익 수정
	public void updateIncome(IncomeVO incomeVO)throws Exception;
	// 수익 레코드 조회
	public IncomeVO selectIncome(Integer inc_no)throws Exception;
}
