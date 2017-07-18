package org.moneybook.service;

import org.moneybook.domain.OutlayVO;
import org.moneybook.domain.dto.MultiDelDTO;

public interface OutlayService {
	// 가계부 등록
	public void register(OutlayVO outVO)throws Exception;
	// 회원 다중 삭제
	public void multiRemoveOutlay(MultiDelDTO dto)throws Exception;
	
	
}
