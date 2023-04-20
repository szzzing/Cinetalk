package com.kh.cinetalk.hangout.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.kh.cinetalk.common.MovieInfo;
import com.kh.cinetalk.common.PageInfo;
import com.kh.cinetalk.common.Pagination;
import com.kh.cinetalk.hangout.model.exception.HangoutException;
import com.kh.cinetalk.hangout.model.service.HangoutService;
import com.kh.cinetalk.hangout.model.vo.Hangout;
import com.kh.cinetalk.hangout.model.vo.Hcomment;
import com.kh.cinetalk.member.model.vo.Member;
import com.kh.cinetalk.report.model.vo.Report;
import com.kh.cinetalk.review.model.vo.Movie;

@Controller
public class HangoutController {
	@Autowired
	private HangoutService hService;
	

	@RequestMapping(value="hangoutList.ha")
	public String movieListView(Model model) {
		int count = hService.getListCount();
		model.addAttribute("hangoutCount", count);
		return "hangoutList";
	}
	
	@RequestMapping(value="selectAllHangoutList.ha", produces="application/json; charset=UTF-8")
	@ResponseBody
	public String selectAllHangoutList(Model model, @RequestParam(value="page", required=false) Integer page) {
		JSONArray array = new JSONArray();
		int currentPage = 1;
		if(page!=null) {
			currentPage = page;
		}
		int listCount = hService.getListCount();
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 18);
		
		ArrayList<Hangout> hList = hService.selectAllHangoutList(pi);
		ArrayList<Movie> mList = new ArrayList<Movie>();
		for(Hangout h : hList) {
			
			int interestCount = hService.selectInterestCount(h.getBoardId());
			int joinCount = hService.selectJoinCount(h.getBoardId());
			JSONObject obj = new JSONObject();
			
			Movie m = null;
			if(h.getMovieId()!=null) {
				m = MovieInfo.getMovieInfo(h.getMovieId());
				obj.put("isMovie", true);
				obj.put("movieTitle", m.getMovieTitle());
				obj.put("genre", m.getGenre());
			} else {
				obj.put("isMovie", false);
			}
			obj.put("boardId", h.getBoardId());
			obj.put("boardTitle", h.getBoardTitle());
			obj.put("boardWriter", h.getBoardWriter());
			obj.put("nickName", h.getNickName());
			obj.put("boardCount", h.getBoardCount());
			obj.put("createDate", h.getCreateDate()+"");
			obj.put("hangoutNumber", h.getHangoutNumber());
			obj.put("gender", h.getGender());
			obj.put("local", h.getLocal());
			obj.put("age", h.getAge());
			obj.put("nowNumber", h.getNowNumber());
			obj.put("isClose", h.getIsClose());
			obj.put("joinCount", joinCount);
			obj.put("interestCount", interestCount);
			
			array.add(obj);
		}
		
		return array.toString();
	}
	
	// 모임게시판 글쓰기 뷰
	@RequestMapping("writeHangout.ha")
	public String writeHangout() {
		return "writeHangout";
	}
	
	// 모임게시판 글쓰기
	@RequestMapping(value="insertHangout.ha", method={RequestMethod.GET, RequestMethod.POST})
	public String insertHangout(HttpSession session, @ModelAttribute Hangout h) {
		Member m = (Member)session.getAttribute("loginUser");
		
		if(m!=null) {
			h.setBoardWriter(m.getId());
			h.setNickName(m.getNickName());
		}
		int result = hService.insertHangout(h);
		
		if(result>0) {
			return "redirect:hangoutList.ha";
		} else {
			throw new HangoutException("모임게시판 글쓰기에 실패하였습니다.");
		}
	}
	
	// 모임게시판 글 상세보기
	@RequestMapping("hangoutDetail.ha")
	public String selectHangout(HttpSession session, @RequestParam("boardId") int boardId, @RequestParam("writer") String writer, Model model, Report report) {
		Member loginUser = null;
		loginUser = (Member)session.getAttribute("loginUser");
		if(loginUser==null || (loginUser.getIsAdmin().equals("N") && !loginUser.getId().equals(writer))) {
			hService.updateHangoutCount(boardId);
		}
		if(loginUser!=null && loginUser.getIsAdmin().equals("N") && !loginUser.getId().equals(writer)) {
			// 관심, 참여를 눌렀는가?
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("id", loginUser.getId());
			map.put("boardId", boardId+"");
			int isInterest = hService.isInterest(map);
			int isJoin = hService.isJoin(map);
			model.addAttribute("isInterest", isInterest);
			model.addAttribute("isJoin", isJoin);
		}
		
		Hangout h = hService.selectHangout(boardId);
		if(h.getMovieId()!=null) {
			Movie m = MovieInfo.getMovieInfo(h.getMovieId());
			model.addAttribute("m", m);
		}
		
		// 신고 상태 확인 김이현
		int count = 0;

		if(loginUser!=null) {
			report.setReportWriter(loginUser.getId());
			report.setReportContentId(boardId);
			report.setReportContentCategory("h");
			
			count = hService.reportCount(report);
		}
     	
		
		
		model.addAttribute("h", h);
		model.addAttribute("count", count);
		
		return "hangoutDetail";
	}

	// 글수정뷰
	@RequestMapping(value="modifyHangout.ha", method={RequestMethod.GET, RequestMethod.POST})
	public String modifyHangout(@RequestParam("boardId") int boardId, Model model) {
		Hangout h = hService.selectHangout(boardId);
		if(h.getMovieId()!=null) {
			Movie m = MovieInfo.getMovieInfo(h.getMovieId());
			model.addAttribute("m", m);
		}
		model.addAttribute("h", h);
		return "modifyHangout";
	}
	
	// 글수정
	@RequestMapping(value="updateHangout.ha", method={RequestMethod.GET, RequestMethod.POST})
	public String updateHangout(HttpSession session, @ModelAttribute Hangout h, Model model) {
		Member m = (Member)session.getAttribute("loginUser");
		Hangout original = hService.selectHangout(h.getBoardId());
		
		if(m!=null) {
			h.setBoardWriter(m.getId());
			h.setNickName(m.getNickName());
		}
		h.setNowNumber(original.getNowNumber());
		int result = hService.updateHangout(h);
		
		if(result>0) {
			model.addAttribute("boardId", h.getBoardId());
			model.addAttribute("writer", h.getBoardWriter());
			return "redirect:hangoutDetail.ha";
		} else {
			throw new HangoutException("글수정 실패");
		}
	}
	
	// 글삭제
	@RequestMapping(value="deleteHangout.ha", method={RequestMethod.GET, RequestMethod.POST})
	public String deleteHangout(HttpSession session, @RequestParam("boardId") int boardId) {

		int result = hService.deleteHangout(boardId);
		hService.deleteAllInterest(boardId);
		hService.deleteAllJoin(boardId);
		hService.deleteAllComment(boardId);
		
		if(result>0) {
			return "redirect:hangoutList.ha";
		} else {
			throw new HangoutException("글삭제 실패");
		}
	}
	
	@RequestMapping(value="insertInterest.ha", produces="application/json; charset=UTF-8")
	@ResponseBody
	public void insertInterest(@RequestParam("boardId") int boardId, @RequestParam("id") String id) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("boardId", boardId+"");
		int result = hService.insertInterest(map);
		
		if(result<=0) {
			throw new HangoutException("관심 실패");
		}
	}
	
	@RequestMapping(value="deleteInterest.ha", produces="application/json; charset=UTF-8")
	@ResponseBody
	public void deleteInterest(@RequestParam("boardId") int boardId, @RequestParam("id") String id) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("boardId", boardId+"");
		int result = hService.deleteInterest(map);
		
		if(result<=0) {
			throw new HangoutException("관심 삭제 실패");
		}
	}
	
	@RequestMapping(value="insertJoin.ha", produces="application/json; charset=UTF-8")
	@ResponseBody
	public void insertJoin(@RequestParam("boardId") int boardId, @RequestParam("id") String id, HttpServletResponse response) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("boardId", boardId+"");
		int result = hService.insertJoin(map);
		
		// 현재인원 증가
		if(result>0) {
			Hangout h = hService.selectHangout(boardId);
			h.setNowNumber(h.getNowNumber()+1);
			System.out.println(h.getNowNumber());
			hService.updateHangout(h);
			h = hService.selectHangout(boardId);
			
			response.setContentType("application/json; charset=UTF-8");
			Gson gson = new Gson();
			GsonBuilder gb = new GsonBuilder();
			gson = gb.create();
			try {
				gson.toJson(h, response.getWriter());
			} catch (JsonIOException | IOException e) {
				e.printStackTrace();
			}
		} else {
			throw new HangoutException("참여 실패");
		}
	}
	
	@RequestMapping(value="deleteJoin.ha", produces="application/json; charset=UTF-8")
	@ResponseBody
	public void deleteJoin(@RequestParam("boardId") int boardId, @RequestParam("id") String id, HttpServletResponse response) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("boardId", boardId+"");
		int result = hService.deleteJoin(map);
		
		// 현재인원 감소
		if(result>0) {
			Hangout h = hService.selectHangout(boardId);
			h.setNowNumber(h.getNowNumber()-1);
			hService.updateHangout(h);
			h = hService.selectHangout(boardId);
			
			response.setContentType("application/json; charset=UTF-8");
			Gson gson = new Gson();
			GsonBuilder gb = new GsonBuilder();
			gson = gb.create();
			try {
				gson.toJson(h, response.getWriter());
			} catch (JsonIOException | IOException e) {
				e.printStackTrace();
			}
		}else {
			throw new HangoutException("참여 삭제 실패");
		}
	}
	
	@RequestMapping("insertComment.ha")
	@ResponseBody
	public void insertComment(@ModelAttribute Hcomment c, HttpSession session, HttpServletResponse response) {
		Member m = (Member)session.getAttribute("loginUser");
		
		if(m!=null) {
			c.setNickName(m.getNickName());
			c.setUserId(m.getId());
		}
		int result = hService.insertComment(c);
		
		int commentId = hService.selectLastCommentId();
		
		System.out.println(c);
		System.out.println(commentId);
		
		c = hService.selectComment(commentId-1);
		System.out.println(c);
		
		if(result>0) {
			response.setContentType("application/json; charset=UTF-8");
			Gson gson = new Gson();
			GsonBuilder gb = new GsonBuilder().setDateFormat("yyyy-MM-dd");
			gson = gb.create();
			try {
				gson.toJson(c, response.getWriter());
			} catch (JsonIOException | IOException e) {
				e.printStackTrace();
			}
		}else {
			throw new HangoutException("댓글 삽입 실패");
		}
	}
	
	// 댓글 전체 불러오기
	@RequestMapping(value="selectAllCommentList.ha", produces="application/json; charset=UTF-8")
	@ResponseBody
	public void selectAllCommentList(@RequestParam("boardId") int boardId, HttpServletResponse response) {
		ArrayList<Hcomment> cList = new ArrayList<Hcomment>();	// 모든 댓글을 저장할 리스트
		
		ArrayList<Hcomment> pcList = new ArrayList<Hcomment>();	// 원댓글을 저장할 리스트
		ArrayList<Hcomment> ccList = new ArrayList<Hcomment>();	// 대댓글을 저장할 리스트
		
		pcList = hService.selectParentComment(boardId);
		for(Hcomment pc : pcList) {
			cList.add(pc);	// 원댓글 저장
			
			ccList = hService.selectChildComment(pc.getCommentId());
			for(Hcomment cc : ccList) {
				cList.add(cc);
			}
		}
		
		response.setContentType("application/json; charset=UTF-8");
		Gson gson = new Gson();
		GsonBuilder gb = new GsonBuilder().setDateFormat("yyyy-MM-dd");
		gson = gb.create();
		try {
			gson.toJson(cList, response.getWriter());
		} catch (JsonIOException | IOException e) {
			e.printStackTrace();
		}
	}
	
	// 댓글 수정
	@RequestMapping("updateComment.ha")
	@ResponseBody
	public void updateComment(@ModelAttribute Hcomment c, HttpServletResponse response) {
		
		int result = hService.updateComment(c);
		Hcomment comment = hService.selectComment(c.getCommentId());
		
		if(result>0) {
			response.setContentType("application/json; charset=UTF-8");
			Gson gson = new Gson();
			GsonBuilder gb = new GsonBuilder().setDateFormat("yyyy-MM-dd");
			gson = gb.create();
			try {
				gson.toJson(comment, response.getWriter());
			} catch (JsonIOException | IOException e) {
				e.printStackTrace();
			}
		}else {
			throw new HangoutException("댓글 수정 실패");
		}
	}
	
	// 댓글 삭제
	@RequestMapping("deleteComment.ha")
	@ResponseBody
	public void deleteComment(@RequestParam("commentId") int commentId, HttpServletResponse response) {
		int result = hService.deleteComment(commentId);
		
		System.out.println(result);
		
		if(result>0) {
			response.setContentType("application/json; charset=UTF-8");
			Gson gson = new Gson();
			GsonBuilder gb = new GsonBuilder().setDateFormat("yyyy-MM-dd");
			gson = gb.create();
			try {
				gson.toJson(result, response.getWriter());
			} catch (JsonIOException | IOException e) {
				e.printStackTrace();
			}
		}else {
			throw new HangoutException("댓글 삭제 실패");
		}
	}
	
	// 검색
	@RequestMapping(value="searchHangout.ha", produces="application/json; charset=UTF-8")
	@ResponseBody
	public String searchHangout(@RequestParam("search") String search, @RequestParam("local") String local, @RequestParam("gender") String gender, @RequestParam("age") String age, @RequestParam("hangoutNumber") String hangoutNumber, @RequestParam("page") Integer page) {
		JSONArray array = new JSONArray();
		
		// 페이징
		int currentPage = 1;
		if(page!=null) {
			currentPage = page;
		}
		int listCount = hService.getListCount();
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 18);
		
		// 검색값 가져오기
		HashMap<String, String> searchMap = new HashMap<String, String>();
		if(search.trim().equals("")) {
			search = null;
		}
		searchMap.put("search", search);
		searchMap.put("local", local);
		searchMap.put("age", age);
		searchMap.put("gender", gender);
		searchMap.put("hangoutNumber", hangoutNumber);
		System.out.println("searchMap : "+searchMap);
		
		ArrayList<Hangout> hList = hService.searchHangout(searchMap, pi);
		ArrayList<Movie> mList = new ArrayList<Movie>();
		System.out.println(hList);
		
		int resultCount = hService.getSearchHangoutResultCount(searchMap);
		int maxPage = resultCount/18 + (resultCount%18==0 ? 0 : 1);
		System.out.println("maxPage : "+maxPage);
		
		JSONObject obj2 = new JSONObject();
		obj2.put("resultCount", resultCount);
		obj2.put("maxPage", maxPage);
		array.add(obj2);
		
		for(Hangout h : hList) {
			
			int interestCount = hService.selectInterestCount(h.getBoardId());
			int joinCount = hService.selectJoinCount(h.getBoardId());
			JSONObject obj = new JSONObject();
			
			Movie m = null;
			if(h.getMovieId()!=null) {
				m = MovieInfo.getMovieInfo(h.getMovieId());
				obj.put("isMovie", true);
				obj.put("movieTitle", m.getMovieTitle());
				obj.put("genre", m.getGenre());
			} else {
				obj.put("isMovie", false);
			}
			obj.put("boardId", h.getBoardId());
			obj.put("boardTitle", h.getBoardTitle());
			obj.put("boardWriter", h.getBoardWriter());
			obj.put("nickName", h.getNickName());
			obj.put("boardCount", h.getBoardCount());
			obj.put("createDate", h.getCreateDate()+"");
			obj.put("hangoutNumber", h.getHangoutNumber());
			obj.put("gender", h.getGender());
			obj.put("local", h.getLocal());
			obj.put("age", h.getAge());
			obj.put("nowNumber", h.getNowNumber());
			obj.put("isClose", h.getIsClose());
			obj.put("joinCount", joinCount);
			obj.put("interestCount", interestCount);
			
			array.add(obj);
		}
		System.out.println(array);
		
		return array.toString();
	}
	
}