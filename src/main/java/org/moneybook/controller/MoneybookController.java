package org.moneybook.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.moneybook.domain.PageMaker;
import org.moneybook.domain.SearchCriteria;
import org.moneybook.domain.TranHistoryDTO;
import org.moneybook.service.TranHistoryService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@RequestMapping(value="/money/*")
@Controller
public class MoneybookController {

	@Inject
	private TranHistoryService tranHistoryService;
	
	// 거래내역 cri, mno 값 필요
	@RequestMapping(value="/list", method = RequestMethod.GET)
	public String list(@ModelAttribute("cri")SearchCriteria cri, Model model)throws Exception{
		
		Map param = new HashMap();
		param.put("cri", cri);
		param.put("mno", 1);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(tranHistoryService.getTotalCount(param));
		System.out.println("체크final: "+pageMaker.toString());
		
		model.addAttribute("tranHistory", tranHistoryService.getTranHistory(param));
		model.addAttribute("pageMaker", pageMaker);
		return "/moneybook/list";
	}
	
	
	
	
	
	
}
