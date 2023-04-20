package com.kh.cinetalk.mypage.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.cinetalk.common.MovieInfo;
import com.kh.cinetalk.common.PageInfo;
import com.kh.cinetalk.common.Pagination;
import com.kh.cinetalk.hangout.model.vo.Hangout;
import com.kh.cinetalk.member.model.vo.Member;
import com.kh.cinetalk.mypage.model.exception.MyPageException;
import com.kh.cinetalk.mypage.model.service.MyPageService;
import com.kh.cinetalk.mypage.model.vo.Comments;
import com.kh.cinetalk.review.model.vo.Movie;
import com.kh.cinetalk.review.model.vo.Review;



@Controller
public class MyPageController {
	private static String CURR_IMAGE_REPO_PATH = "C:\\Users\\jinhw\\Desktop\\workspace\\7_Framework_Spring_workspace\\2_Semi\\target\\m2e-wtp\\web-resources\\";
	@Autowired
	private MyPageService myService;
	
	@Autowired
	private BCryptPasswordEncoder bcrypt;
	
	@RequestMapping("updateMyInfo.me")
	public String update() {
		return "update";
	}
	
	@RequestMapping("myInfo.my")
	public String myInfo() {
		return "myInfo";
	}
	
	
	// 내가 쓴 리뷰
	@RequestMapping("selectMyReview.my")
	public String selectMyReview(@RequestParam(value="page", required=false) Integer page, HttpSession session, Model model) {
		Member loginUser = (Member)session.getAttribute("loginUser");
		String id = loginUser.getId();
		ArrayList<Review> list = myService.reviewList(id);
		ArrayList<String> movieTitleList = new ArrayList<String>();
		int listCount = myService.getReviewListCount(id);
		
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 3);
		
		ArrayList<Review> hList = myService.selectReviewList(pi, id);

		for(int i=0; i < list.size(); i++) {
			int boardId = list.get(i).getBoardId();
			int result = myService.allLikeCounts(boardId);
			list.get(i).setLikeCount(result);
		}
		
		for(int i=0; i < list.size(); i++) {
			int boardId = list.get(i).getBoardId();
			int result = myService.allCommentsCounts(boardId);
			list.get(i).setCommentCount(result);
		}
		
		// movieId를 이용해 movieTitle 가져오기
		for(Review r : list) {
			Movie movie = MovieInfo.getMovieInfo(r.getMovieId());
			String movieTitle = movie.getMovieTitle();
			movieTitleList.add(movieTitle);
		}
		if(list != null) {
			model.addAttribute("list", list);
			model.addAttribute("movieTitleList", movieTitleList);
			model.addAttribute("hList", hList);
			model.addAttribute("pi", pi);
			return "myReviewView";
		} else {
			throw new MyPageException("리뷰 조회 실패");
		}
	
	}
	
	//내가 좋아하는 리뷰
	@RequestMapping("likeReview.my")
	public String likeReview( @RequestParam(value="page", required=false) Integer page, HttpSession session, Model model) {
		Member loginUser = (Member)session.getAttribute("loginUser");
		String id = loginUser.getId();
		ArrayList<Review> list = myService.reviewLikeList(id);
		ArrayList<String> movieTitleList = new ArrayList<String>();
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		for(int i=0; i < list.size(); i++) {
			int boardId = list.get(i).getBoardId();
			int result = myService.allLikeCounts(boardId);
			list.get(i).setLikeCount(result);
		}
		
		for(int i=0; i < list.size(); i++) {
			int boardId = list.get(i).getBoardId();
			int result = myService.allCommentsCounts(boardId);
			list.get(i).setCommentCount(result);
		}
		int listCount = myService.getReviewListCount(id);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 5);
		System.out.println(pi);
		ArrayList<Review> hList = myService.selectReviewList(pi, id);
		
		// movieId를 이용해 movieTitle 가져오기
		for(Review r : list) {
			Movie movie = MovieInfo.getMovieInfo(r.getMovieId());
			String movieTitle = movie.getMovieTitle();
			movieTitleList.add(movieTitle);
		}
		
	
		if(list != null) {
			model.addAttribute("list", list);
			model.addAttribute("movieTitleList", movieTitleList);
			model.addAttribute("hList", hList);
			model.addAttribute("pi", pi);
			return "myLikeBoardView";
		} else {
			throw new MyPageException("리뷰 조회 실패");
		}
	}
	
	//내가 쓴 댓글
	@RequestMapping("myComments.my")
	public String myCommunityComment(@RequestParam(value="page", required=false) Integer page, HttpSession session, Model model) {
		Member loginUser = (Member)session.getAttribute("loginUser");
		String id = loginUser.getId();
		ArrayList<Comments> list = myService.commentList(id);
		ArrayList<String> movieTitleList = new ArrayList<String>();
		
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = myService.getCommentListCount(id);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 5);
		ArrayList<Comments> hList = myService.selectCommentList(pi, id);
		// movieId를 이용해 movieTitle 가져오기
		for(Comments c : list) {
			Movie movie = MovieInfo.getMovieInfo(c.getBoardId());
			String movieTitle = movie.getMovieTitle();
			movieTitleList.add(movieTitle);
		}
		 System.out.println(list);
	
		if(list != null) {
			model.addAttribute("list", list);
			model.addAttribute("hList", hList);
			model.addAttribute("pi", pi);
			return "myCommentBoardView";
		} else {
			throw new MyPageException("리뷰 조회 실패");
		}
	}
	
	//내가 만든 커뮤니티
	@RequestMapping("myMakeCommunity.my")
	public String myMakeCommunity(@RequestParam(value="page", required=false) Integer page, HttpSession session, Model model) {
		Member loginUser = (Member)session.getAttribute("loginUser");
		String id = loginUser.getId();
		ArrayList<Hangout> list = myService.hangoutList(id);
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = myService.getListCount(id);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 5);
		ArrayList<Hangout> hList = myService.selectHangoutList(pi, id);
		ArrayList<Movie> mList = new ArrayList<Movie>();
		
		for(Hangout h : hList) {
			if(h.getMovieId()!=null) {
				Movie movie = MovieInfo.getMovieInfo(h.getMovieId());
				mList.add(movie);
			} else {
				mList.add(null);
			}
		}
		if(list != null) {
			model.addAttribute("list", list);
			model.addAttribute("hList", hList);
			model.addAttribute("mList", mList);
			model.addAttribute("pi", pi);
			return "myCommunityBoard";
			
		} else {
			throw new MyPageException("리뷰 조회 실패");
		}

	}
		
	// 내가 관심있는 커뮤니티
	@RequestMapping("likeCommunity.my")
	public String likeCommunity( @RequestParam(value="page", required=false) Integer page, HttpSession session, Model model) {
		Member loginUser = (Member)session.getAttribute("loginUser");
		String id = loginUser.getId();
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = myService.getListCount(id);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 5);
		ArrayList<Hangout> hList = myService.selectHangoutList(pi, id);
		
		ArrayList<Hangout> list = myService.interestHangoutList(id);
		
		ArrayList<Movie> mList = new ArrayList<Movie>();
		
		for(Hangout h : hList) {
			if(h.getMovieId()!=null) {
				Movie movie = MovieInfo.getMovieInfo(h.getMovieId());
				mList.add(movie);
			} else {
				mList.add(null);
			}
		}
		
		if(list != null) {
			model.addAttribute("list", list);
			model.addAttribute("pi", pi);
			model.addAttribute("hList", hList);
			model.addAttribute("mList", mList);
			return "myInterestedCommunityView";
			
		} else {
			throw new MyPageException("리뷰 조회 실패");
		}
	}
	
	//내가 참여한 모임
	@RequestMapping("joinCommunity.my")
	public String joinCommunity(@RequestParam(value="page", required=false) Integer page, HttpSession session, Model model) {
		Member loginUser = (Member)session.getAttribute("loginUser");
		String id = loginUser.getId();
		
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = myService.getListCount(id);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 5);
		ArrayList<Hangout> hList = myService.selectHangoutList(pi, id);
		ArrayList<Hangout> list = myService.joinHangoutList(id);
		
		ArrayList<Movie> mList = new ArrayList<Movie>();
		
		for(Hangout h : hList) {
			if(h.getMovieId()!=null) {
				Movie movie = MovieInfo.getMovieInfo(h.getMovieId());
				mList.add(movie);
			} else {
				mList.add(null);
			}
		}
		
		if(list != null) {
			model.addAttribute("list", list);
			model.addAttribute("pi", pi);
			model.addAttribute("hList", hList);
			model.addAttribute("mList", mList);
			return "myParticipatedCommunityView";
			
		} else {
			throw new MyPageException("리뷰 조회 실패");
		}
	}
		    
	
}
