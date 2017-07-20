package org.moneybook.service;

import java.util.List;

import javax.inject.Inject;

import org.moneybook.domain.OutlayVO;
import org.moneybook.domain.StatisticsVO;
import org.moneybook.domain.dto.MultiDelDTO;
import org.moneybook.persistence.OutlayDAO;
import org.moneybook.persistence.StatisticsDAOImpl;
import org.moneybook.persistence.TranHistoryDAO;
import org.moneybook.utils.BindingObject;
import org.moneybook.utils.ValidityCheck;
import org.springframework.stereotype.Service;

@Service
public class OutlayServiceImpl implements OutlayService {

	@Inject
	private OutlayDAO outDAO;

	@Inject
	private StatisticsDAOImpl statDAO;
	
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
			statDAO.updateOutStat(statVO);
			return;
		}else if(outVO.getPay_code() == '1'){
			// 결제수단이 카드면 비용테이블에 카드값입력
			statDAO.insertCardStat(statVO);
			return;
		}
		
		statDAO.insertOutStat(statVO);
	}

	// 다중 지출목록 삭제
	@Override
	public void multiRemoveOutlay(MultiDelDTO dto) throws Exception {
		// TODO Auto-generated method stub
		List<MultiDelDTO> removeList = dto.getOutList();
		if(removeList.size() == 0)return;
		outDAO.multiDeleteOutlay(dto.getOutList());
		// 삭제 목록만큼 통계 금액 감소
		for(MultiDelDTO removeDTO : removeList){
			statDAO.subtractOutStat(removeDTO);
		}
		
	}

	// 수정 비용
	@Override
	public void modifyOutlay(OutlayVO newVO) throws Exception {
		// 새로운 내용으로 수정한다음 통계도 수정
		OutlayVO oldVO = outDAO.selectOutlay(newVO.getOut_no());
		outDAO.updateOutlay(newVO);
		// bindStatVO = Object객체를 받아서 StatVO객체에 데이터 복사후 리턴
		statDAO.subtractOutStat(BindingObject.bindStatVO(oldVO));
		StatisticsVO statVO = BindingObject.bindStatVO(newVO);
		// 지출내역이 바뀌면 통계도 수정되어야함
		if(statDAO.isStatistics(statVO)){
			statDAO.updateOutStat(statVO);
			return;
		}else if(ValidityCheck.isCard(statVO.getPay_code())){
				statDAO.insertCardStat(statVO);
			return;
		}
		// 현금일경우
		statDAO.insertOutStat(statVO);
	}
	
	
	
}
