package org.moneybook.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.moneybook.domain.IncomeVO;
import org.moneybook.domain.OutlayVO;
import org.moneybook.domain.PageMaker;
import org.moneybook.domain.SearchCriteria;
import org.moneybook.service.IncomeService;
import org.moneybook.service.OutlayService;
import org.moneybook.service.TranHistoryService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@RequestMapping(value = "/money/*")
@Controller
public class MoneybookController {

	@Inject
	private TranHistoryService tranHistoryService;

	@Inject
	private IncomeService incService;

	@Inject
	private OutlayService outService;

	// 거래내역 cri, mno 값 필요
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {

		Map param = new HashMap();
		param.put("cri", cri);
		param.put("mno", 1);

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(tranHistoryService.getTotalCount(param));
		System.out.println("체크final: " + pageMaker.toString());

		model.addAttribute("tranHistory", tranHistoryService.getTranHistory(param));
		model.addAttribute("pageMaker", pageMaker);
		return "/moneybook/list";
	}

	// 가계부 페이지
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String registerGET(Model model) throws Exception {
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("mno", 1);
		paramMap.put("cri", new SearchCriteria());
		
		model.addAttribute("pageMaker", 
						PageMaker.getPageMaker(paramMap,
						tranHistoryService.getTotalCount(paramMap)));
		model.addAttribute("tranHistory", tranHistoryService.getTranHistory(paramMap));
		
		return "/moneybook/register";
	}

	// 수익 작성
	/*@RequestMapping(value="/register/income", method = RequestMethod.POST)
	public String registerPOST(IncomeVO incomeVO)throws Exception{
		incomeVO.setMno(1);
		incService.registerIncome(incomeVO);
		return "redirect:/money/register";
	}

	// 비용 작성
	@RequestMapping(value="/register/outlay", method = RequestMethod.POST)
	public String registerPOST(OutlayVO outlayVO)throws Exception{
		outlayVO.setMno(1);
		outService.register(outlayVO);
		return "redirect:/money/register";
	}*/
	
	// 수익 작성
	@ResponseBody
	@RequestMapping(value="/register/income", method = RequestMethod.POST)
	public ResponseEntity registerPOST(@RequestBody IncomeVO incomeVO)throws Exception{
		
		ResponseEntity entity = null;
		try{
			incomeVO.setMno(1);
			this.incService.registerIncome(incomeVO);
			entity = new ResponseEntity<>(HttpStatus.OK);
		}catch(Exception e){
			entity = new ResponseEntity(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	// 비용 작성
		@RequestMapping(value="/register/outlay", method = RequestMethod.POST)
		@ResponseBody
		public ResponseEntity registerPOST(@RequestBody OutlayVO outlayVO)throws Exception{
			ResponseEntity entity = null;
			try{
				outlayVO.setMno(1);
				this.outService.register(outlayVO);
				entity = new ResponseEntity<>(HttpStatus.OK);
			}catch(Exception e){
				e.printStackTrace();
				entity = new ResponseEntity(HttpStatus.BAD_REQUEST);
			}
			
			return entity;
		}
		
	// 팝업
	@RequestMapping(value="/money/pop", method = RequestMethod.GET)	
	public String pop()throws Exception{
		
		return "/moneybook/modifyPop";
	}

}
