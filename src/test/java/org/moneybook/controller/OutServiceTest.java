package org.moneybook.controller;

import javax.inject.Inject;

import org.junit.Ignore;
import org.junit.Test;
import org.moneybook.domain.OutlayVO;
import org.moneybook.service.OutlayService;

public class OutServiceTest extends ConfigObject{

	@Inject
	private OutlayService service;
	
	@Test
	public void register()throws Exception{
		OutlayVO outVO = new OutlayVO();
		outVO.setMno(1);
		outVO.setRegdate("20171014");
		outVO.setCate_cd(20010);
		outVO.setCost(10000);
		outVO.setItem("교재");
		outVO.setPay_code('1');
		service.register(outVO);
	}
	
	@Test
	@Ignore
	public void test()throws Exception{
		//System.out.println("20171014".substring(4, 6));
		System.out.println("20170214".substring(4, 6));
	}
}
