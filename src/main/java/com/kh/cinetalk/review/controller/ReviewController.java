package com.kh.cinetalk.review.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.kh.cinetalk.member.model.vo.Member;
import com.kh.cinetalk.report.model.vo.Report;
import com.kh.cinetalk.review.model.exception.ReviewException;
import com.kh.cinetalk.review.model.service.ReviewService;
import com.kh.cinetalk.review.model.vo.Like;
import com.kh.cinetalk.review.model.vo.Movie;
import com.kh.cinetalk.review.model.vo.MovieLike;
import com.kh.cinetalk.review.model.vo.Rcomment;
import com.kh.cinetalk.review.model.vo.Review;


@Controller
public class ReviewController {
	@Autowired
	private ReviewService rService;

	// 리뷰게시판으로 넘어가기 - 김세진
	@RequestMapping(value="reviewList.re")
	public String movieListView(Model model) {
		int count = rService.selectAllReviewCount();
		model.addAttribute("reviewCount", count);
		return "movieList";
	}

	// 영화 리스트 보여주기 - 김세진
	@RequestMapping(value="moreMovieList.re", produces="application/json; charset=UTF-8")
	@ResponseBody
	public String movieList(Model model, @RequestParam(value="page", required=false) Integer page) {
		ArrayList<Movie> movieList = new ArrayList<Movie>();
		JSONArray array = new JSONArray();
		
		try {
			String originalUrl = "https://api.themoviedb.org/3/discover/movie?api_key=7bf40bf859def4eaf9886f19bb497169&with_watch_providers=8&watch_region=KR&language=ko&page=";
			URL url = new URL(originalUrl + (page!=null ? page : ""));

			BufferedReader bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
			String buffer = bf.readLine();

			JSONParser jsonParser = new JSONParser();
			JSONObject json = (JSONObject)jsonParser.parse(buffer);
			JSONArray resultArray = (JSONArray)json.get("results");

			// 장르
			URL url2 = new URL("https://api.themoviedb.org/3/genre/movie/list?api_key=7bf40bf859def4eaf9886f19bb497169&language=ko-KR");
			BufferedReader bf2 = new BufferedReader(new InputStreamReader(url2.openStream(), "UTF-8"));
			String buffer2 = bf2.readLine();
			JSONParser jsonParser2 = new JSONParser();
			JSONObject json2 = (JSONObject)jsonParser2.parse(buffer2);
			
			JSONArray genreArray = (JSONArray)json2.get("genres");
			HashMap<Long, String> map = new HashMap<Long, String>();
			for(int k=0;k<genreArray.size();k++) {
				JSONObject genre = (JSONObject)genreArray.get(k);
				long genreId = (long)genre.get("id");
				String genreName = (String)genre.get("name");
				map.put(genreId, genreName);
			}
			
			//movieList에 영화 담기
			for(int i=0;i<resultArray.size();i++) {

				JSONObject result = (JSONObject)resultArray.get(i);

				long id = (long)result.get("id");
				String title = (String)result.get("title");
				String posterPath = (String)result.get("poster_path");
				JSONArray genreIdsArray = (JSONArray)result.get("genre_ids");
				ArrayList<Long> genreIds = new ArrayList<Long>();	// 장르 아이디값
				for(int j = 0; j < genreIdsArray.size(); j++) {
					genreIds.add((long)genreIdsArray.get(j));
				}
				String releaseDate = ((String)result.get("release_date")).substring(0,4);
				
				String genre = "";
				for(Long g : genreIds) {
					genre += map.get(g)+"/";
				}
				genre = genre.substring(0, genre.length()-1);


				// 영화 객체 삽입
				Movie m = new Movie();
				m.setMovieId((int)id);
				m.setMovieImg(posterPath);
				m.setMovieTitle(title);
				m.setGenre(genre);
				m.setReleaseDate(releaseDate);

				movieList.add(m);
				
				// 리뷰 개수 반환
				int reviewCount = rService.selectReviewCount(m.getMovieId());
				
				// 평점 반환
				double avgRating = 0;
				if(reviewCount!=0) {
					avgRating = rService.selectAvgRating(m.getMovieId());
				}
				
				JSONObject obj = new JSONObject();
				obj.put("movieId", m.getMovieId());
				obj.put("movieImg", m.getMovieImg());
				obj.put("movieTitle", m.getMovieTitle());
				obj.put("genre", m.getGenre());
				obj.put("releaseDate", m.getReleaseDate());
				obj.put("avgRating", avgRating);
				obj.put("reviewCount", reviewCount);
				
				array.add(obj);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		for(Movie m : movieList) {
		}
		return array.toString();
	}

	// 영화 검색 - 김세진
	@RequestMapping(value="searchMovie.re", produces="application/json; charset=UTF-8")
	@ResponseBody
	public String searchMovie(@RequestParam("search") String search, @RequestParam("page") Integer page) {
		ArrayList<Movie> movieList = new ArrayList<Movie>();
		JSONArray array = new JSONArray();
		long totalPages = 0;
		long totalResults = 0;
		try {
			String originalUrl = "https://api.themoviedb.org/3/search/movie?api_key=7bf40bf859def4eaf9886f19bb497169&region=KR&language=ko&query=";
			URL url = new URL(originalUrl+search+"&page="+page);

			BufferedReader bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
			String buffer = bf.readLine();

			JSONParser jsonParser = new JSONParser();
			JSONObject json = (JSONObject)jsonParser.parse(buffer);
			JSONArray resultArray = (JSONArray)json.get("results");

			// 장르
			URL url2 = new URL("https://api.themoviedb.org/3/genre/movie/list?api_key=7bf40bf859def4eaf9886f19bb497169&language=ko-KR");
			BufferedReader bf2 = new BufferedReader(new InputStreamReader(url2.openStream(), "UTF-8"));
			String buffer2 = bf2.readLine();
			JSONParser jsonParser2 = new JSONParser();
			JSONObject json2 = (JSONObject)jsonParser2.parse(buffer2);

			JSONArray genreArray = (JSONArray)json2.get("genres");
			HashMap<Long, String> map = new HashMap<Long, String>();
			for(int k=0;k<genreArray.size();k++) {
				JSONObject genre = (JSONObject)genreArray.get(k);
				long genreId = (long)genre.get("id");
				String genreName = (String)genre.get("name");
				map.put(genreId, genreName);
			}

			// 검색결과 받기
			totalPages = (long)json.get("total_pages");
			totalResults = (long)json.get("total_results");
			
			JSONObject obj1 = new JSONObject();
			obj1.put("totalPages", totalPages);
			obj1.put("totalResults", totalResults);
			array.add(obj1);

			for(int i=0;i<resultArray.size();i++) {
				JSONObject result = (JSONObject)resultArray.get(i);

				long id = (long)result.get("id");
				String title = (String)result.get("title");
				String posterPath = (String)result.get("poster_path");
				JSONArray genreIdsArray = (JSONArray)result.get("genre_ids");
				ArrayList<Long> genreIds = new ArrayList<Long>();   // 장르 아이디값
				for(int j = 0; j < genreIdsArray.size(); j++) {
					genreIds.add((long)genreIdsArray.get(j));
				}
				String releaseDate = ((String)result.get("release_date")).substring(0,4);


				String genre = "";
				for(Long g : genreIds) {
					genre += map.get(g)+"/";
				}
				genre = genre.substring(0, genre.length()-1);

				// 영화 객체 삽입
				Movie m = new Movie();
				m.setMovieId((int)id);
				m.setMovieImg(posterPath);
				m.setMovieTitle(title);
				m.setGenre(genre);
				m.setReleaseDate(releaseDate);
				movieList.add(m);
				
				// 리뷰 개수 반환
				int reviewCount = rService.selectReviewCount(m.getMovieId());
				
				// 평점 반환
				double avgRating = 0;
				if(reviewCount!=0) {
					avgRating = rService.selectAvgRating(m.getMovieId());
				}
				
				JSONObject obj2 = new JSONObject();
				obj2.put("movieId", m.getMovieId());
				obj2.put("movieImg", m.getMovieImg());
				obj2.put("movieTitle", m.getMovieTitle());
				obj2.put("genre", m.getGenre());
				obj2.put("releaseDate", m.getReleaseDate());
				obj2.put("avgRating", avgRating);
				obj2.put("reviewCount", reviewCount);

				array.add(obj2);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return array.toString();
	}

	
	
	// 영화 상세 페이지로 이동 (김이현)
	   @RequestMapping("movieDetail.re")
	   public ModelAndView movieDetail(@ModelAttribute Movie m, ModelAndView mv, @RequestParam("movieId") int movieId, HttpSession session, @ModelAttribute MovieLike ml) {

	      String apiURL = "https://api.themoviedb.org/3/movie/" + movieId + "?api_key=71c29f7f34f0823c338ede88ca814164&language=ko";
	      String apiURL2 = "https://api.themoviedb.org/3/movie/"+ movieId + "/credits?api_key=71c29f7f34f0823c338ede88ca814164&language=ko";

	      String result = "";
	      String result2 = "";
	      try {
	         URL url = new URL(apiURL);
	         URL url2 = new URL(apiURL2);

	         BufferedReader bf;
	         BufferedReader bf2;
	         bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
	         bf2 = new BufferedReader(new InputStreamReader(url2.openStream(), "UTF-8"));

	         result = bf.readLine();
	         result2 = bf2.readLine();

	         JSONParser jsonParser = new JSONParser();
	         JSONObject jsonObject = (JSONObject)jsonParser.parse(result);
	         JSONObject jsonObject2 = (JSONObject)jsonParser.parse(result2);

	         //         System.out.println(jsonObject);

	         String movieImg = (String)jsonObject.get("poster_path");
	         //            System.out.println(movieImg);
	         String title = (String)jsonObject.get("title");
	         String releaseDate = (String)jsonObject.get("release_date");

	         JSONArray genres = (JSONArray)jsonObject.get("genres");

	         String genre = "";
	         for(int i = 0; i < genres.size(); i++ ) {
	            JSONObject genresName = (JSONObject)genres.get(i);
	            genre += genresName.get("name") + "/";
	         }
	         if(genre.length()>0) {
	        	 genre = genre.substring(0, genre.length()-1);
	         }

	         //         System.out.println(genre);
	         //         double rating = (double)jsonObject.get("vote_average");
	         String overview = (String)jsonObject.get("overview");

	         JSONArray cast = (JSONArray)jsonObject2.get("cast");
	         JSONArray crew = (JSONArray)jsonObject2.get("crew");

	         String actor = "";

	         for(int i = 0; i < cast.size(); i++ ) {
	            JSONObject actors = (JSONObject)cast.get(i);
	            actor += actors.get("name") + ", ";
	         }
	         actor = actor.substring(0, actor.length()-2);

	         String director = null;
	         for(int i = 0; i < crew.size(); i++ ) {
	            JSONObject directors = (JSONObject)crew.get(i);
	            if(directors.get("job").equals("Director")) {
	               director = (String)directors.get("name");
	            }
	         }

	         Long runtime = (Long)jsonObject.get("runtime");


	         m.setMovieId(movieId);
	         m.setMovieImg(movieImg);
	         m.setMovieTitle(title);
	         m.setReleaseDate(releaseDate);
	         m.setGenre(genre);
	         m.setOverview(overview);
	         m.setDirector(director);
	         m.setActor(actor);
	         m.setRuntime(runtime);



	      } catch (Exception e) {
	         e.printStackTrace();
	      }

	      ArrayList<Review> list = rService.movieReviewList(movieId);
	      
	      if(list != null) {
				for(int i = 0; i < list.size(); i++) {
					int boardId = list.get(i).getBoardId();
					int likeCount = rService.allLikeCount(boardId);
					list.get(i).setLikeCount(likeCount);
					int commentCount = rService.allCommentCount(boardId);
					list.get(i).setCommentCount(commentCount);
//					System.out.println(list);
				}
	      }
	      Review review = rService.reviewRating(movieId);
	      
	      mv.addObject("m", m);
	      mv.addObject("review", review);
	      mv.addObject("list", list);
	      
	      Member member = (Member)session.getAttribute("loginUser");
	      String login ="";
	      boolean already = false;
	      if(member != null) {
	         login = member.getId();
	         for(int i = 0 ; i < list.size(); i++ ) {
	            if(list.get(i).getBoardWriter().equals(login) && list.get(i).getStatus().equals("Y")) {
	               already = true;
	            }
	         }
	         
	         
	      }
	      
	      mv.addObject("already", already);

	      // 좋아요 클릭상태 값 불러오기!
	      ml.setMemberId(login);
	      ml.setMovieId(movieId);
	      
	      
	      int movieLikeCount = rService.movieLikeCount(ml);
//	      System.out.println(ml);
	      mv.addObject("movieLikeCount", movieLikeCount);
	      
	      
	      int allHeartCountInt = rService.allHeartCount(movieId);
	      String allHeartCount = Integer.toString(allHeartCountInt);
	      
//	      System.out.println(allHeartCount);
	      mv.addObject("allHeartCount", allHeartCount);
	      
	      
	      mv.setViewName("movieDetail");
	      
	      
	      return mv;
	   }

	// 리뷰 더보기 (김이현)
	@RequestMapping("movieReviewList.re")
	public String movieReviewList(@RequestParam("movieId") int movieId, @RequestParam("movieTitle") String movieTitle, Model model) {
		//	      System.out.println(movieId);

		ArrayList<Review> list = rService.movieReviewList(movieId);
		
		
		
		if(list != null) {
			for(int i = 0; i < list.size(); i++) {
				int boardId = list.get(i).getBoardId();
				int likeCount = rService.allLikeCount(boardId);
				list.get(i).setLikeCount(likeCount);
				int commentCount = rService.allCommentCount(boardId);
				list.get(i).setCommentCount(commentCount);
//				System.out.println(list);
			}
			
			model.addAttribute("movieTitle",movieTitle);
			model.addAttribute("list", list);
			
			return "moreMovieReview";
		} else {
			throw new ReviewException("게시글 조회 실패");
		}  
		
	}

	// 리뷰 작성 (김이현)
	@RequestMapping("insertMovieReview.re")
	public String insertMovieReview(@ModelAttribute Review r, HttpSession session, Model model) {
		Member m = (Member)session.getAttribute("loginUser");

		if(m != null) {
			String boardWriter = m.getId();
//			System.out.println(boardWriter);
			r.setBoardWriter(boardWriter);  
		}

		int result = rService.insertMovieReview(r);
		
		
		if(result > 0) {
			model.addAttribute("movieId", r.getMovieId());
			return "redirect:movieDetail.re";
		} else {
			throw new ReviewException("리뷰 작성  실패");
		}
	}

	// 영화에 리뷰쓴거 상세보기 (김이현)
	@RequestMapping("movieReviewDetail.re")
	public String movieReviewDetail(@RequestParam("writer") String writer, @RequestParam("boardId") int boardId, HttpSession session,@RequestParam("movieTitle") String movieTitle,
										Model model, @ModelAttribute Rcomment rc , @ModelAttribute Like like,@ModelAttribute Report report) {
		
		Member m = (Member)session.getAttribute("loginUser");
		String login = "";
		String isAdmin = "";
		String userId ="";
		if(m != null) {
			login = m.getNickName();
			isAdmin = m.getIsAdmin();
			userId = m.getId();
		}
		
		boolean yn = false;
		if(!writer.equals(login) && isAdmin.equals("N")) {
			yn = true; // 조회수 증가
		}
		
		Review r = rService.movieReviewDetail(boardId, yn);
		ArrayList<Rcomment> rcList = rService.selectRcomment(boardId);
		
		
		rc.setBoardId(boardId);
		rc.setUserId(userId);
		int already = rService.rCommentAlready(rc);
		
		// 게시글에 좋아요 눌린상태인지 
		
		like.setMemberId(userId);
		like.setBoardId(boardId);
		int likeCount = rService.likeCount(like);
		
		// 게시글에 총 좋아요 개수
		 int allLikeCountInt = rService.allLikeCount(boardId);
	     String allLikeCount = Integer.toString(allLikeCountInt);
		
	     // 게시글에 달린 댓글 개수
	     int allCommentCountInt = rService.allCommentCount(boardId);
	     String allCommentCount = Integer.toString(allCommentCountInt);
		
	     
	     // 영화 리뷰 신고 상태 확인
	     	report.setReportWriter(userId);
	     	report.setReportContentId(boardId);
	     	report.setReportContentCategory("r");
	     	
	     int count = rService.reportCount(report);
		
	     
	     // 영화 리뷰 댓글 신고 상태 확인
	    	
	    for(int i=0; i< rcList.size(); i++) {
	    	
	    	int commentId = rcList.get(i).getCommentId();
	    		
	    	report.setReportContentId(commentId);
	    	report.setReportContentCategory("c");
	    	report.setReportWriter(userId);
	    		
//	    	System.out.println(report);
	    	int reportCount = rService.commentReportCount(report);
//	    		
	    	rcList.get(i).setReportCount(reportCount);
	    	
	    }
			
//	    System.out.println(rcList);
			
			
		if( r != null ) {
			model.addAttribute("count", count);
			model.addAttribute("already", already);
			model.addAttribute("r", r);
			model.addAttribute("rcList", rcList);
			model.addAttribute("movieTitle", movieTitle);
			model.addAttribute("likeCount", likeCount);
			model.addAttribute("allLikeCount", allLikeCount);
			model.addAttribute("allCommentCount", allCommentCount);
			return "movieReviewComment";
		} else {
			throw new ReviewException("코멘트 상세 조회 실패");
		}
		
		
	}
	
	// 영화 리뷰 수정 (김이현)
	@RequestMapping("updateMovieReview.re")
	public String updateMovieReview(@ModelAttribute Review r, HttpSession session, Model model, @RequestParam("movieTitle") String movieTitle) {
		 
		int result = rService.updateMovieReview(r);
//		System.out.println(movieTitle);
		if(result > 0) {
			model.addAttribute("movieTitle", movieTitle);
			model.addAttribute("boardId", r.getBoardId());
			model.addAttribute("writer", ((Member)session.getAttribute("loginUser")).getNickName());
			return "redirect:movieReviewDetail.re";
		} else {
			throw new ReviewException("코멘트 수정 실패");
		}
		
	}
	
	// 영화 리뷰 삭제 (김이현)
	@RequestMapping("deleteMovieReview.re")
	public String deleteMovieReview(@RequestParam("boardId") int boardId, @RequestParam("movieId") int movieId, Model model) {
//		System.out.println(boardId);
		int result = rService.deleteMovieReview(boardId);
		if(result > 0) {
			model.addAttribute("movieId", movieId);
			return "redirect:movieDetail.re";
		} else {
			throw new ReviewException("코멘트 삭제 실패");
		}
	}
	
	// 영화 리뷰에 댓글 작성 (김이현)
	@RequestMapping(value="insertRcomment.re")
	public void insertRcomment(@ModelAttribute Rcomment rc,HttpSession session,HttpServletResponse response) {
		Member m = (Member)session.getAttribute("loginUser");
		
//		System.out.println(m);
		rc.setUserId(m.getId());
//		System.out.println(rc);
		int result = rService.insertRcomment(rc);
		
		ArrayList<Rcomment> rcList = rService.selectRcomment(rc.getBoardId());
		

		response.setContentType("application/json; charset=UTF-8");
		GsonBuilder gb = new GsonBuilder();
		GsonBuilder gb2 = gb.setDateFormat("yyyy-MM-dd");
		Gson gson = gb2.create();
		
			try {
				gson.toJson(rcList, response.getWriter());
			} catch (JsonIOException | IOException e) {
				e.printStackTrace();
			}
	}

	// 영화 리뷰 댓글 수정 (김이현)
	@RequestMapping(value="updateRcomment.re")
	public void updateRcomment(@ModelAttribute Rcomment rc, HttpServletResponse response) {
		
		int result = rService.updateRcomment(rc);
		ArrayList<Rcomment> rcList = rService.selectRcomment(rc.getBoardId());
		
		
//		System.out.println(rc);
		if(result > 0 ) {
			System.out.println("업데이트 성공");
		}
		
		
		response.setContentType("application/json; charset=UTF-8");
		GsonBuilder gb = new GsonBuilder();
		GsonBuilder gb2 = gb.setDateFormat("yyyy-MM-dd");
		Gson gson = gb2.create();
		
		try {
			gson.toJson(rcList, response.getWriter());
		} catch (JsonIOException | IOException e) {
			e.printStackTrace();
		}
	}
	
	// 영화 리뷰 댓글 삭제 (김이현)
	@RequestMapping("deleteRcomment.re")
	public String deleteRcomment(@ModelAttribute Rcomment rc, Model model, @RequestParam("writer") String writer, @RequestParam("movieTitle") String movieTitle,
														@RequestParam("boardId") int boardId) {
		System.out.println(rc);
		
		int commentId = rc.getCommentId();
		int result = rService.deleteRcomment(commentId);
		
//		System.out.println(boardId);
		if(result > 0) {
			model.addAttribute("boardId", boardId);
			model.addAttribute("writer", writer);
			model.addAttribute("movieTitle", movieTitle);
			return "redirect:movieReviewDetail.re";
		}else {
			throw new ReviewException("영화 리뷰 댓글 삭제 실패");
		}
		
	}
	
	// 영화 리뷰 좋아요 (김이현)
	@RequestMapping("insertMovieLike.re")
	@ResponseBody
	public int insertMovieLike(@ModelAttribute MovieLike ml, HttpSession session, Model model,@RequestParam("movieId") int movieId) {
		Member m = (Member)session.getAttribute("loginUser");
		if( m != null) {
			String memberId = m.getId();
			ml.setMemberId(memberId);
		}
		
//		System.out.println(ml);
		
		int result = rService.insertMovieLike(ml);
		
		int heartCount = 0;
		if(result > 0) {
			heartCount = rService.allHeartCount(movieId);
		}else {
			throw new ReviewException("영화 좋아요 삽입 실패");
		}
		return heartCount;
			
		
	}
	
	// 영화 리뷰 좋아요 삭제(김이현)
	@RequestMapping("deleteMovieLike.re")
	@ResponseBody
	public int deleteMovieLike(@ModelAttribute MovieLike ml, HttpSession session, Model model,@RequestParam("movieId") int movieId) {
		Member m = (Member)session.getAttribute("loginUser");
		if( m != null) {
			String memberId = m.getId();
			ml.setMemberId(memberId);
		}
		
//		System.out.println(ml);
		
		int result = rService.deleteMovieLike(ml);
		int heartCount = 0;
		if(result > 0) {
			heartCount = rService.allHeartCount(movieId);
		}else {
			throw new ReviewException("영화 리뷰 좋아요 삭제 실패");
		}
		return heartCount;
		
	}
	
	// 리뷰에 달린 댓글 좋아요 insert
	@RequestMapping("insertLike.re")
	@ResponseBody
	public int insertLike(HttpSession session, @ModelAttribute Like like,@RequestParam("boardId") int boardId) {
		Member m = (Member)session.getAttribute("loginUser");
		
		if(m != null) {
			String memberId = m.getId();
			like.setMemberId(memberId);
		}
		
		int result = rService.insertLike(like);
		int likeCount = 0;
		if(result > 0) {
			likeCount = rService.allLikeCount(boardId);
		}else {
			throw new ReviewException("리뷰에 달린 댓글 좋아요 삽입 실패");
		}
		
		return likeCount;
		
	}
	
	
	// 리뷰에 달린 댓글 좋아요 삭제
	@RequestMapping("deleteLike.re")
	@ResponseBody
	public int deleteLike(HttpSession session, @ModelAttribute Like like,@RequestParam("boardId") int boardId) {
		Member m = (Member)session.getAttribute("loginUser");
		
		if(m != null) {
			String memberId = m.getId();
			like.setMemberId(memberId);
		}
		
		int result = rService.deleteLike(like);
		int likeCount = 0;
		if(result > 0) {
			likeCount = rService.allLikeCount(boardId);
		}else {
			throw new ReviewException("리뷰에 달린 댓글 좋아요 삭제 실패");
		}
		
		return likeCount;
		
	}
	

	
	
	
	

	

	
	
	
}