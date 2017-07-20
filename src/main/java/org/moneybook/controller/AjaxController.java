package org.moneybook.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.moneybook.domain.CategoryVO;
import org.moneybook.domain.IncomeVO;
import org.moneybook.domain.OutlayVO;
import org.moneybook.domain.PageMaker;
import org.moneybook.domain.SearchCriteria;
import org.moneybook.domain.dto.MbDTO;
import org.moneybook.domain.dto.ModifyDTO;
import org.moneybook.domain.dto.MultiDelDTO;
import org.moneybook.service.CategoryService;
import org.moneybook.service.IncomeService;
import org.moneybook.service.OutlayService;
import org.moneybook.service.TranHistoryService;
import org.moneybook.utils.BindingObject;
import org.moneybook.utils.ValidityCheck;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value="/ajax/*")
public class AjaxController {

	@Inject
	private TranHistoryService tranHistoryService;
	
	@Inject
	private CategoryService cateService;
	
	@Inject
	private IncomeService incomeService;
	
	@Inject
	private OutlayService outlayService;
	
	
	// 거래내역 = mno + cri
	@RequestMapping(value="/moneybookList/{page}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> list(@PathVariable("page")Integer page)throws Exception{
	
		ResponseEntity<Map<String, Object>> entity = null;
		try{
			SearchCriteria cri = new SearchCriteria();
			cri.setPage(page);
			Map<String, Object> param = new HashMap<>();
			param.put("mno", 1);
			param.put("cri", cri);
			
			Map<String, Object> resultMap = new HashMap<>();
			resultMap.put("list", tranHistoryService.getTranHistory(param));
			resultMap.put("pageMaker", getPageMaker(param));
			entity = new ResponseEntity<>(resultMap, HttpStatus.OK);
		
		}catch(Exception e){
			entity = new ResponseEntity(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value="/yearTranHistory/{year}/{page}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> yearTranHistoryGET(@PathVariable("year")Integer year
										,@PathVariable("page")Integer page)throws Exception{
	
		ResponseEntity<Map<String, Object>> entity = null;
		try{
			
			SearchCriteria cri = new SearchCriteria();
			cri.setPage(page);
			cri.setYear(year);
			cri.setSearchType("year");
			
			Map<String, Object> param = new HashMap<>();
			param.put("mno", 1);
			param.put("cri", cri);
			
			Map<String, Object> resultMap = new HashMap<>();
			
			resultMap.put("pageMaker", getPageMaker(param));
			resultMap.put("list", tranHistoryService.getYearTranHistory(param));
			
			entity = new ResponseEntity<>(resultMap, HttpStatus.OK);
		
		}catch(Exception e){
			entity = new ResponseEntity(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value="/monthTranHistory/{year}/{month}/{page}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> monthTranHistoryGET(@PathVariable("year")Integer year
										,@PathVariable("month")Integer month, @PathVariable("page")Integer page)throws Exception{
	
		ResponseEntity<Map<String, Object>> entity = null;
		try{
			// 검색조건 set
			SearchCriteria cri = new SearchCriteria();
			cri.setPage(page);
			cri.setYear(year);
			cri.setMonth(month);
			cri.setSearchType("month");
			// 해당 회원번호와 검색조건을 map에 저장
			Map<String, Object> yearAndMonth = new HashMap<>();
			yearAndMonth.put("mno", 1);
			yearAndMonth.put("cri", cri);
			// 리스트에 뿌려줄 map객체를 생성
			Map<String, Object> resultMap = new HashMap<>();
			
			resultMap.put("pageMaker", getPageMaker(yearAndMonth));
			resultMap.put("list", tranHistoryService.getMonthTranHistory(yearAndMonth));
			entity = new ResponseEntity<>(resultMap, HttpStatus.OK);
		
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value="/quarterTranHistory/{year}/{quarter}/{page}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> quarterTranHistoryGET(@PathVariable("year")Integer year
										,@PathVariable("quarter")Integer quarter, @PathVariable("page")Integer page)throws Exception{
	
		ResponseEntity<Map<String, Object>> entity = null;
		try{
			
			SearchCriteria cri = new SearchCriteria();
			cri.setPage(page);
			cri.setYear(year);
			cri.setQuarter(quarter);
			cri.setSearchType("quarter");
			
			Map<String, Object> yearAndQuarter = new HashMap<>();
			yearAndQuarter.put("mno", 1);
			yearAndQuarter.put("cri", cri);
			
			// 리스트에 뿌려줄 map객체를 생성
			Map<String, Object> resultMap = new HashMap<>();
			resultMap.put("pageMaker", getPageMaker(yearAndQuarter));
			resultMap.put("list", tranHistoryService.getQuarterTranHistory(yearAndQuarter));
		
			entity = new ResponseEntity<>(resultMap, HttpStatus.OK);
		
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value="/periodTranHistory/{startDate}/{endDate}/{page}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> periodTranHistoryGET(@PathVariable("startDate")Integer startDate
										,@PathVariable("endDate")Integer endDate, @PathVariable("page")Integer page)throws Exception{
	
		ResponseEntity<Map<String, Object>> entity = null;
		try{
			
			SearchCriteria cri = new SearchCriteria();
			cri.setPage(page);
			cri.setStartDate(startDate);
			cri.setEndDate(endDate);
			
			Map<String, Object> regdateInfo = new HashMap<>();
			regdateInfo.put("mno", 1);
			regdateInfo.put("cri", cri);
			
			Map<String, Object> resultMap = new HashMap<>();
			resultMap.put("pageMaker", getPageMaker(regdateInfo));
			resultMap.put("list", tranHistoryService.getPeriodTranHistory(regdateInfo));
			entity = new ResponseEntity<>(resultMap, HttpStatus.OK);
		
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	// 카테고리 목록 응답
	@RequestMapping(value="/getCategoryList", method = RequestMethod.GET)
	public ResponseEntity<List<CategoryVO>> getCategoryList(CategoryVO cateVO)throws Exception{
		ResponseEntity<List<CategoryVO>> entity = null;
		try{
			entity = new ResponseEntity<>(cateService.getCategory(), HttpStatus.OK);
		}catch(Exception e){
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		return entity;
	}
	
	// 삭제 요청
	@RequestMapping(value="/moneybook/remove", method = RequestMethod.POST)
	public ResponseEntity<String> removeMoneyBook(@RequestBody MultiDelDTO dto)throws Exception{
		ResponseEntity<String> entity = null;
		
		try{
			incomeService.multiRemoveIncome(dto);
			outlayService.multiRemoveOutlay(dto);
			entity = new ResponseEntity<>("SUCCESS",HttpStatus.OK);
			
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	// 수정요청
	@RequestMapping(value="/modify", method= RequestMethod.POST)
	public ResponseEntity<String> testAjax(@RequestBody ModifyDTO dto)throws Exception{
		ResponseEntity<String> entity = null;
		dto.setMno(1);
		System.out.println("값확인: " + dto.getRevenue());
		try{
			// revenue값 유무에따라 수익 or 비용 요청인지 구별
			if(ValidityCheck.isIncome(dto.getRevenue())){
				IncomeVO incomeVO = BindingObject.bindIncome(dto);
				incomeService.modifyIncome(incomeVO);
			}else{
				OutlayVO outlayVO = BindingObject.bindOutlay(dto);
				outlayService.modifyOutlay(outlayVO);
			}
			entity = new ResponseEntity("SUCCESS", HttpStatus.OK);
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
		
	
	
	
	public PageMaker getPageMaker(Map<String, Object> paramMap)throws Exception{
		// paramMap = mno + cri
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri((SearchCriteria)paramMap.get("cri"));
		pageMaker.setTotalCount(tranHistoryService.getTotalCount(paramMap));
		
		return pageMaker;
	}
	
	
	
	
	
	
	
}
