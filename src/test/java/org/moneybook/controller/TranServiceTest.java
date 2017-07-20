package org.moneybook.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.junit.Ignore;
import org.junit.Test;
import org.moneybook.domain.Criteria;
import org.moneybook.domain.dto.TranHistoryDTO;
import org.moneybook.service.TranHistoryService;

public class TranServiceTest extends ConfigObject {

	@Inject
	private TranHistoryService tranService;
	
	@Test
	@Ignore
	public void getTranHistory() throws Exception {
		Criteria cri = new Criteria();
		cri.setPage(1);
		cri.setPerPageNum(31);
		//List<TranHistoryDTO> list = tranService.getTranHistory(cri);
		
		/*for(TranHistoryDTO dto : list){
			System.out.println(dto.toString());
		}*/
	}
	
	@Test
	@Ignore
	public void getYearTranHistory()throws Exception{
		Map year = new HashMap();
		Criteria cri = new Criteria();
		cri.setPage(1);
		cri.setPerPageNum(3);
		year.put("cri", cri);
		year.put("year", 2017);
		List<TranHistoryDTO> list = tranService.getYearTranHistory(year);
		for(TranHistoryDTO dto : list){
			System.out.println(dto.toString());
		}
		
	}
	
	@Test
	public void periodTest()throws Exception{
		
		Criteria cri = new Criteria();
		Map map = new HashMap();
		map.put("cri", cri);
		map.put("startDate", "20170501");
		map.put("endDate", "20171231");
		
		List<TranHistoryDTO> list = tranService.getPeriodTranHistory(map);
		for(TranHistoryDTO dto : list){
			System.out.println(dto.toString());
		}
	}
	
	

}
