package com.kh.cinetalk.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.cinetalk.admin.model.exception.AdminException;
import com.kh.cinetalk.admin.model.service.AdminService;
import com.kh.cinetalk.common.MovieInfo;
import com.kh.cinetalk.hangout.model.vo.Hangout;
import com.kh.cinetalk.member.model.vo.Member;
import com.kh.cinetalk.report.model.vo.Report;
import com.kh.cinetalk.review.model.vo.Movie;
import com.kh.cinetalk.review.model.vo.Review;

@Controller
public class AdminController {
	@Autowired
	private AdminService aService;

	// 대시보드 이동
	@RequestMapping("admin.ad")
	public String admin(Model model) {
		int mCount = aService.selectNewMemberCount();
		int rCount = aService.selectNewReviewCount();
		
		model.addAttribute("mCount", mCount);
		model.addAttribute("rCount", rCount);
		return "admin";
	}
	

	// 새로운 멤버
	@RequestMapping(value="selectNewMember.ad", produces="application/json; charset=UTF-8")
	@ResponseBody
	public String selectNewMember() {
		JSONArray array = new JSONArray();
		ArrayList<Member> mList = new ArrayList<Member>();
		mList = aService.selectNewMember();
		int mCount = aService.selectNewMemberCount();
		
		if(mList.size()!=0) {
			for(Member m : mList) {
				int reviewCount = aService.selectReviewCount(m.getId());
				
				JSONObject json = new JSONObject();
				json.put("id", m.getId());
				json.put("name", m.getName());
				json.put("nickName", m.getNickName());
				json.put("enrollDate", m.getEnrollDate()+"");
				json.put("reviewCount", reviewCount);
				array.add(json);
			}
		}
		return array.toString();
	}
	// 새로운 리뷰
	@RequestMapping(value="selectNewReview.ad", produces="application/json; charset=UTF-8")
	@ResponseBody
	public String selectNewReview() {
		JSONArray array = new JSONArray();
		int rCount = aService.selectNewReviewCount();
		ArrayList<Review> rList = new ArrayList<Review>();
		rList = aService.selectNewReview();
		
		if(rList.size()!=0) {
			for(Review r : rList) {
				String title = MovieInfo.getMovieInfo(r.getMovieId()).getMovieTitle();
				JSONObject json = new JSONObject();
				json.put("boardId", r.getBoardId());
				json.put("boardTitle", r.getBoardTitle());
				json.put("boardContent", r.getBoardContent());
				json.put("nickName", r.getNickName());
				json.put("createDate", r.getCreateDate()+"");
				json.put("movieRating", r.getMovieRating());
				json.put("movieTitle", title);
				array.add(json);
			}
		}
		return array.toString();
	}
	
	// 회원관리 이동, 전체회원 조회
	@RequestMapping("manageMember.ad")
	public String manageMember(Model model) {
		ArrayList<Member> mList = aService.selectAllMember();
		ArrayList<Integer> rCountList = new ArrayList<Integer>();
		int count = mList.size();
		for(Member m : mList) {
			int reviewCount = aService.selectReviewCount(m.getId());
			rCountList.add(reviewCount);
		}
		model.addAttribute("mList", mList);
		model.addAttribute("mCount", count);
		model.addAttribute("rCountList", rCountList);
		return "manageMember";
	}

	// 회원 검색
	@RequestMapping("searchMember.ad")
	public String searchMember(Model model, @RequestParam("searchValue") String searchValue, @RequestParam("category") String category) {
		ArrayList<Member> mList = new ArrayList<Member>();
		HashMap<String, String> map = new HashMap<String, String>();
		ArrayList<Integer> rCountList = new ArrayList<Integer>();
		map.put("category", category);
		map.put("searchValue", searchValue);
		
		mList = aService.searchMember(map);
		int count = mList.size();
		for(Member m : mList) {
			int reviewCount = aService.selectReviewCount(m.getId());
			rCountList.add(reviewCount);
		}
		model.addAttribute("mList", mList);
		model.addAttribute("mCount", count);
		model.addAttribute("rCountList", rCountList);
		model.addAttribute("searchValue", searchValue);
		
		return "manageMember";
	}
	
	// 리뷰관리 이동, 전체리뷰 조회
	@RequestMapping("manageReview.ad")
	public String manageReview(Model model) {
		ArrayList<Review> rList = aService.selectAllReview();
		ArrayList<String> mList = new ArrayList<String>();
		int rCount = rList.size();
		for(Review r : rList) {
			String title = MovieInfo.getMovieInfo(r.getMovieId()).getMovieTitle();
			mList.add(title);
		}
		model.addAttribute("rList", rList);
		model.addAttribute("mList", mList);
		model.addAttribute("rCount", rCount);
		
		return "manageReview";
	}
	
	// 리뷰 검색
	@RequestMapping("searchReview.ad")
	public String searchValue(Model model, @RequestParam("searchValue") String searchValue, @RequestParam("category") String category) {
		ArrayList<Review> rList = new ArrayList<Review>();
		ArrayList<String> mList = new ArrayList<String>();
		HashMap<String, String> map = new HashMap<String, String>();
		
		map.put("category", category);
		map.put("searchValue", searchValue);
		
		rList = aService.searchReview(map);
		int rCount = rList.size();
		
		for(Review r : rList) {
			String title = MovieInfo.getMovieInfo(r.getMovieId()).getMovieTitle();
			mList.add(title);
		}
		
		System.out.println(category);
		System.out.println(searchValue);
		System.out.println(rList);
		model.addAttribute("rList", rList);
		model.addAttribute("mList", mList);
		model.addAttribute("rCount", rCount);
		return "manageReview";
	}
	
	//리뷰 선택 삭제
	@RequestMapping("deleteMovieReview.ad")
	public String deleteMovieReview(@RequestParam(value="deleteArr[]") List<String> deleteArr) {
//		System.out.println(deleteArr);
		int result = 0;
		for(int i = 0; i < deleteArr.size(); i++) {
			result = aService.deleteMovieReview(deleteArr.get(i));
		}
		
		if(result > 0) {
			return "manageReview";
		} else {
			System.out.println("컨트롤러에서 실패");
			return "";
		}
		
	}
	
	// 회원 강퇴
	@RequestMapping("deleteMember.ad")
	public String deleteMember(@RequestParam("id") String id) {
		int result = aService.deleteMember(id);
		if(result>0) {
			return "redirect:manageMember.ad";
		} else {
			throw new AdminException("회원 강퇴에 실패하였습니다.");
		}
	}
	
	//모임게시판 관리 페이지, 전체 모임 조회
	@RequestMapping("manageHangout.ad")
	public String manageHangout(Model model) {
		ArrayList<Review> hList = aService.selectAllHangout(); //게시물 리스트 가져옴
		int hCount = hList.size(); //게시물 개수
		
		model.addAttribute("hList", hList);
		model.addAttribute("hCount", hCount);
		
		return "manageHangout";
	}
	
	//모임 선택 삭제
	@RequestMapping("deleteHangout.ad")
	public String deleteHangout(@RequestParam(value="deleteArr[]") List<String> deleteArr) {
//		System.out.println(deleteArr);
		int result = 0;
		for(int i = 0; i < deleteArr.size(); i++) {
			result = aService.deleteHangout(deleteArr.get(i));
		}
		
		if(result > 0) {
			return "manageHangout";
		} else {
			System.out.println("컨트롤러에서 실패");
			return "";
		}
	}
	
	//모임 검색
	@RequestMapping("searchHangout.ad")
	public String searchHangout(Model model, @RequestParam("searchValue") String searchValue, @RequestParam("category") String category) {
		ArrayList<Hangout> hList = new ArrayList<Hangout>();
//		ArrayList<Integer> mList = new ArrayList<Integer>();
		HashMap<String, String> map = new HashMap<String, String>();
		
		map.put("category", category);
		map.put("searchValue", searchValue);
		
		hList = aService.searchHangout(map);
		int hCount = hList.size();
		
//		for(Hangout h : hList) {
//			Integer movieId = h.getMovieId();
//			mList.add(h.getMovieId());
//		}
		
		System.out.println(category);
		System.out.println(searchValue);
		System.out.println(hList);
		model.addAttribute("hList", hList);
//		model.addAttribute("mList", mList);
		model.addAttribute("hCount", hCount);
		return "manageHangout";
	}
	
	//신고 페이지
	@RequestMapping("manageReport.ad")
	public String manageReport(Model model) {
//		ArrayList<Report> rpList = aService.selectAllReport(); //모든 신고 가져오기
//		int bId = rpList.get(0).getReportContentId();
//		//신고당한 아이디, 글 제목
		
//		
//		
//		int rpCount = rpList.size();
//		
//		model.addAttribute("rpList", rpList);
//		model.addAttribute("rpCount", rpCount);
		
		ArrayList<Report> rrList = aService.selectAllReviewReport();
		ArrayList<Report> hrList = aService.selectAllHangoutReport();
		
		ArrayList<Review> rList = new ArrayList<>();
		ArrayList<String> mtList = new ArrayList<>();
		ArrayList<Hangout> hList = new ArrayList<>();
		
		for(Report r : rrList) {
			Review review = aService.selectReview(r.getReportContentId());
			String movieTitle = MovieInfo.getMovieInfo(review.getMovieId()).getMovieTitle();
			rList.add(review);	// 리뷰
			mtList.add(movieTitle);	// 영화제목
		}
		
		for(Report r : hrList) {
			Hangout hangout = aService.selectHangout(r.getReportContentId());
			
			hList.add(hangout);
		}
//		System.out.println(rrList);
//		System.out.println(hrList);
//		System.out.println(rList);
//		System.out.println(mtList);
//		System.out.println(hList);
		
		int rCount = rrList.size();
		int hCount = hrList.size();
		
		model.addAttribute("hCount", hCount);
		model.addAttribute("rCount", rCount);
		model.addAttribute("rrList", rrList);
		model.addAttribute("hrList", hrList);
		model.addAttribute("rList", rList);
		model.addAttribute("mtList", mtList);
		model.addAttribute("hList", hList);
		
		return "manageReport";
	}
	
	//신고 삭제
	@RequestMapping("deleteReportBoard.ad")
	public String deleteReportBoard(@RequestParam(value="deleteArr[]") List<String> deleteArr) {
//		System.out.println(deleteArr);
		int result = 0;
		for(int i = 0; i < deleteArr.size(); i++) {
			result = aService.deleteReportBoard(deleteArr.get(i));
			System.out.println(result);
		}
		
		if(result > 0) {
			return "manageReport";
		} else {
			System.out.println("컨트롤러에서 실패");
			return "";
		}
		
	}
	
	

}
