package org.moneybook.service;

import javax.inject.Inject;

import org.moneybook.domain.OutlayVO;
import org.moneybook.domain.StatisticsVO;
import org.moneybook.persistence.OutlayDAO;
import org.moneybook.persistence.TranHistoryDAO;
import org.springframework.stereotype.Service;

@Service
public class OutlayServiceImpl implements OutlayService {

	@Inject
	private OutlayDAO outDAO;

	@Inject
	private TranHistoryDAO tranDAO;

	@Override
	public void register(OutlayVO outVO) throws Exception {
		// TODO Auto-generated method stub
		StatisticsVO statVO = new StatisticsVO();
		statVO.setMno(outVO.getMno());
		statVO.setYear(outVO.getYear());
		statVO.setMonth(outVO.getMonth());
		statVO.setOut_amount(outVO.getCost());

		// 만약 결제수단이 카드면 카드금액 컬럼에 비용값을 넣어준다
		if(outVO.getPay_code() != 0)statVO.setCard_amount(outVO.getCost());
		// 통계테이블에서 해당 회원 / 년 / 월 이 잇는지 확인
		boolean isStatistics = tranDAO.isStatistics(statVO);
		outDAO.insertOutlay(outVO);
		// 존재하면 기존 통계테이블 값 update
		// 존재하지않을시 결제방법에따라 insert문이 달라짐
		if(isStatistics){
			outDAO.updateOutStat(statVO);
			return;
		}else if(outVO.getPay_code() == '1'){
			// 결제수단이 카드면 비용테이블에 카드값입력
			outDAO.insertCardStat(statVO);
			return;
		}
		
		outDAO.insertOutStat(statVO);
	}

}
