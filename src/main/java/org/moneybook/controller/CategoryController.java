package org.moneybook.controller;

import javax.inject.Inject;

import org.moneybook.domain.CategoryVO;
import org.moneybook.service.CategoryService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value="/category/*")
public class CategoryController {

	@Inject
	private CategoryService service;

	@RequestMapping(value="/list", method = RequestMethod.GET)
	public String test(Model model)throws Exception{
		
		model.addAttribute("list",service.getCategory());
		return "sample/list";
	}
	
	@RequestMapping(value="/test")
	public String test()throws Exception{
		
		return "/sample/insertTest";
	}
	
	@RequestMapping(value="/insertTest", method = RequestMethod.POST)
	public String insertTestPOST(CategoryVO vo)throws Exception{
		
		return "";
	}
	
	
}
