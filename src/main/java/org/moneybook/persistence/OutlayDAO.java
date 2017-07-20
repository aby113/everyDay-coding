package org.moneybook.persistence;

import java.util.List;

import org.moneybook.domain.OutlayVO;
import org.moneybook.domain.dto.MultiDelDTO;

public interface OutlayDAO {

		// 비용[현금] 작성
		public void insertOutlay(OutlayVO outVO)throws Exception;
		// 비용목록 다중 삭제
		public void multiDeleteOutlay(List<MultiDelDTO> removeList)throws Exception;
		//비용 수정
		public void updateOutlay(OutlayVO outVO)throws Exception;
		//비용 조회
		public OutlayVO selectOutlay(Integer outVO)throws Exception;
}
