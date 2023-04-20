package com.kh.cinetalk.report.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cinetalk.report.model.vo.Report;

@Repository("rpDAO")
public class ReportDAO {

	public int insertReport(SqlSessionTemplate sqlSession, Report report) {
		return sqlSession.insert("reportMapper.insertReport", report);
	}

	public int deleteReport(SqlSessionTemplate sqlSession, Report report) {
		return sqlSession.delete("reportMapper.deleteReport", report);
	}
	
}
