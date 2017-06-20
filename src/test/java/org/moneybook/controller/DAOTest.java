package org.moneybook.controller;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.junit.Ignore;
import org.junit.Test;
import org.moneybook.domain.IncomeVO;
import org.moneybook.domain.StatisticsVO;
import org.moneybook.persistence.IncomeDAO;
import org.moneybook.service.IncomeService;


public class DAOTest extends ConfigObject{

	@Inject
	private IncomeDAO dao;
	
	@Inject
	private SqlSession session;
	
	@Inject
	private IncomeService service;
	
	@Test
	@Ignore
	public void test1()throws Exception{
		System.out.println(session);
	}
	
	/*@Test
	@Ignore
	public void test() throws Exception{
		
		StatisticsVO vo = new StatisticsVO();
		vo.setMno(1);
		vo.setMonth(12);
		vo.setYear(2017);
		
		System.out.println("result : "+dao.isStatistics(vo));
	}*/
	
	@Test
	@Ignore
	public void test2()throws Exception{
		
		IncomeVO vo = new IncomeVO();
		vo.setRegdate("20170608");
		System.out.println(vo.getYear());
		System.out.println(vo.getMonth());
	}
	
	@Test
	public void test3()throws Exception{
		
		IncomeVO incomeVO = new IncomeVO();
		incomeVO.setMno(1);
		incomeVO.setRegdate("20170814");
		incomeVO.setCate_cd(10010);
		incomeVO.setItem("떡볶이");
		incomeVO.setRevenue(3000);
		service.registerIncome(incomeVO);
	}

}
