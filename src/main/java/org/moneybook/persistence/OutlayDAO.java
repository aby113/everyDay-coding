package org.moneybook.persistence;

import java.util.List;

import org.moneybook.domain.OutlayVO;
import org.moneybook.domain.dto.MultiDelDTO;

public interface OutlayDAO {

		// 비용[현금] 작성
		public void insertOutlay(OutlayVO outVO)throws Exception;
		
		// 회원 다중 삭제
		public void multiDeleteOutlay(List<MultiDelDTO> removeList)throws Exception;
		
	
}
