package org.moneybook.persistence;

import org.moneybook.domain.OutlayVO;
import org.moneybook.domain.StatisticsVO;

public interface OutlayDAO {

		// 비용[현금] 작성
		public void insertOutlay(OutlayVO outVO)throws Exception;
		// 통계정보[카드] 작성
		public void insertCardStat(StatisticsVO statVO)throws Exception;
		// 통계정보[현금] 작성
		public void insertOutStat(StatisticsVO statVO)throws Exception;
		// 해당 회원/년/월 통계정보가 존재시 [현금OR카드]수정
		public void updateOutStat(StatisticsVO statVO)throws Exception;
		
		
	
}
