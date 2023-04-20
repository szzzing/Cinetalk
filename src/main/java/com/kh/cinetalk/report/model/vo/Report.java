package com.kh.cinetalk.report.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Report {
	private int reportId;
	private String reportCategory;
	private String reportWriter;
	private String reportContent;
	private Date createDate;
	private String status;
	private String reportContentCategory;
	private int reportContentId;
}
