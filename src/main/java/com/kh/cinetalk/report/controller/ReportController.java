package com.kh.cinetalk.report.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.cinetalk.hangout.model.exception.HangoutException;
import com.kh.cinetalk.member.model.vo.Member;
import com.kh.cinetalk.report.model.exception.ReportException;
import com.kh.cinetalk.report.model.service.ReportService;
import com.kh.cinetalk.report.model.vo.Report;
import com.kh.cinetalk.review.model.exception.ReviewException;

@Controller
public class ReportController {
	
	@Autowired
	private ReportService rpService;
	
	// 김이현 행아웃 신고 
	@RequestMapping(value="insertHangoutReport.rp", method=RequestMethod.POST)
	public String insertHangoutReport(@ModelAttribute Report report, @RequestParam("writer") String writer, @RequestParam("boardId") String boardId,Model model) {
		
//		System.out.println(boardId);
		int result = rpService.insertReport(report);
		if(result>0) {
			model.addAttribute("boardId", boardId);
			model.addAttribute("writer", writer);
			return "redirect:hangoutDetail.ha";
		} else {
			throw new ReportException("글수정 실패");
		}
		
	}
	
	// 김이현 행아웃 신고 취소
	@RequestMapping(value="deleteHangoutReport.rp", method=RequestMethod.POST)
	public String deleteHangoutReport(@ModelAttribute Report report, @RequestParam("writer") String writer, @RequestParam("boardId") String boardId,Model model){
		
		int result = rpService.deleteReport(report);
		if(result>0) {
			model.addAttribute("boardId", boardId);
			model.addAttribute("writer", writer);
			return "redirect:hangoutDetail.ha";
		} else {
			throw new ReportException("글수정 실패");
		}
		
	}
	
	// 영화 리뷰 신고
	@RequestMapping("insertReviewReport.rp")
	public String insertReviewReport(@ModelAttribute Report report, Model model,@RequestParam("writer") String writer, @RequestParam("movieTitle") String movieTitle) {
//		System.out.println(report);
		int result = rpService.insertReport(report);
		
		if(result>0) {
			// 신고했으면 1 신고 안했으면 0
			model.addAttribute("writer", writer);
			model.addAttribute("movieTitle", movieTitle);
			model.addAttribute("boardId", report.getReportContentId());
			return "redirect:movieReviewDetail.re";
		}else {
			throw new ReviewException("영화 리뷰 신고 실패");
		}
		
	}
	
	// 영화 리뷰 댓글 신고
	@RequestMapping("insertRcommentReport.rp")
	public String insertRcommentReport(@ModelAttribute Report report, Model model,HttpSession session,@RequestParam("writer") String writer, @RequestParam("movieTitle") String movieTitle,
			@RequestParam("boardId") int boardId) {
//		report.setReportContentId(reportContentId);
		Member m = (Member)session.getAttribute("loginUser");
		String reportWriter = "";
		if(m != null) {
			reportWriter = m.getId();
		}
		report.setReportWriter(reportWriter);
		
//		System.out.println(report);
		
		int result = rpService.insertReport(report);
		
		if(result>0) {
			
			model.addAttribute("writer", writer);
			model.addAttribute("movieTitle", movieTitle);
			model.addAttribute("boardId", boardId);
		}else {
			throw new ReviewException("영화 리뷰 댓글 신고 실패");
		}
		
		return "redirect:movieReviewDetail.re";
//		return null;
//		return "movieReviewDetail";
	}
	
	// 영회 리뷰 신고 취소
		@RequestMapping("deleteReviewReport.rp")
		public String deleteReviewReport(@RequestParam("writer") String writer, @RequestParam("movieTitle") String movieTitle,
											@RequestParam("boardId") int boardId, @ModelAttribute Report report,HttpSession session, Model model) {
			
			Member m = (Member)session.getAttribute("loginUser");
			String reportWriter = "";
			if(m != null) {
				reportWriter = m.getId();
			}
			
			report.setReportContentCategory("r");
			report.setReportWriter(reportWriter);
			report.setReportContentId(boardId);
			
//			System.out.println(report);
			
			int result = rpService.deleteReport(report);
			System.out.println(result);
			if(result > 0) {
				model.addAttribute("writer", writer);
				model.addAttribute("movieTitle", movieTitle);
				model.addAttribute("boardId", boardId);
				return "redirect:movieReviewDetail.re";
			}else {
				throw new ReviewException("영화 리뷰 신고 취소 실패");
			}
			
		}
		
		// 영화 리뷰 댓글 신고 취소
		@RequestMapping("deleteRcommentReport.rp")
		public String deleteRcommentReport(@ModelAttribute Report report,HttpSession session, Model model,@RequestParam("writer") String writer, @RequestParam("movieTitle") String movieTitle,
				@RequestParam("boardId") int boardId) {
			
			Member m = (Member)session.getAttribute("loginUser");
			String reportWriter = "";
			if(m != null) {
				reportWriter = m.getId();
			}
			report.setReportWriter(reportWriter);
			
			int result = rpService.deleteReport(report);
//			System.out.println(result);
			if(result > 0) {
				model.addAttribute("writer", writer);
				model.addAttribute("movieTitle", movieTitle);
				model.addAttribute("boardId", boardId);
				return "redirect:movieReviewDetail.re";
			}else {
				throw new ReviewException("영화 리뷰 신고 취소 실패");
			}
			
			
		}
	

}
