package com.kh.cinetalk.report.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.cinetalk.report.model.dao.ReportDAO;
import com.kh.cinetalk.report.model.vo.Report;

@Service("rpService")
public class ReportService {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private ReportDAO rpDAO;

	public int insertReport(Report report) {
		
		return rpDAO.insertReport(sqlSession, report);
	}

	public int deleteReport(Report report) {
		
		return rpDAO.deleteReport(sqlSession, report);
	}
}
