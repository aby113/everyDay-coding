package org.moneybook.persistence;

import org.moneybook.domain.IncomeVO;
import org.moneybook.domain.StatisticsVO;
import org.moneybook.domain.dto.MultiDelDTO;

public interface StatisticsDAO {

	// 해당 회원/년/월 통계정보 잇는지 확인
	public boolean isStatistics(IncomeVO incomeVO)throws Exception;
	public boolean isStatistics(StatisticsVO statVO)throws Exception;
	// 해당 회원/년/월 통계정보가없으면 입력
	public void insertIcStat(StatisticsVO statVO) throws Exception;

	// 해당 회원/년/월 통계정보가 존재시 수정
	public void updateIcStat(StatisticsVO statVO) throws Exception;

	// 통계정보[카드] 작성
	public void insertCardStat(StatisticsVO statVO) throws Exception;

	// 통계정보[현금] 작성
	public void insertOutStat(StatisticsVO statVO) throws Exception;

	// 해당 회원/년/월 통계정보가 존재시 [현금OR카드]수정
	public void updateOutStat(StatisticsVO statVO) throws Exception;

	// 수익이 삭제될때 수익통계 마이너스
	public void subtractIncStat(MultiDelDTO dto)throws Exception;
	// 수익이 삭제될때 수익통계 마이너스
	public void subtractIncStat(IncomeVO incomeVO)throws Exception;
	// 비용내역이 삭제됫을때 비용통계 마이너스
	public void subtractOutStat(MultiDelDTO dto)throws Exception;
	// 비용내역이 삭제됫을때 비용통계 마이너스
	public void subtractOutStat(StatisticsVO statVO)throws Exception;
	
	
	
	
	
}
