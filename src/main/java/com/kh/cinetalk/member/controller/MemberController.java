package com.kh.cinetalk.member.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.Date;
import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletResponse;

import org.aspectj.lang.annotation.Before;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.kh.cinetalk.hangout.model.vo.Hangout;
import com.kh.cinetalk.member.model.exception.MemberException;
import com.kh.cinetalk.member.model.service.EmailAuthService;
import com.kh.cinetalk.member.model.service.MemberService;
import com.kh.cinetalk.member.model.vo.Email;
import com.kh.cinetalk.member.model.vo.Member;
import com.kh.cinetalk.review.model.vo.Movie;
@SessionAttributes("loginUser")
@Controller
public class MemberController {
	
	@Autowired
	private MemberService mService;
	
	@Autowired
	private BCryptPasswordEncoder bcrypt;
	
	@Autowired
	private EmailAuthService emailAuthService;

	
	//로그인
	@RequestMapping(value = "login.me", method = RequestMethod.POST)
	public String login(@ModelAttribute Member m, Model model) {
		Member loginUser = mService.login(m);
		System.out.println("m:" + m);
		System.out.println("loginUser: " + loginUser);
		System.out.println(m.getPwd());
		System.out.println(bcrypt.encode(m.getPwd())); //암호화된 비밀번호 확인
		System.out.println(loginUser.getPwd());
		if(bcrypt.matches(m.getPwd(), loginUser.getPwd())) { //(암호화 전, 암호화 후) boolean값 반환함
			 model.addAttribute("loginUser", loginUser);
			 System.out.println("로그인성공");
			 return "redirect:/";
		} else {
//			model.addAttribute("msg", "로그인 실패");
//			return "../common/errorPage";
			throw new MemberException("로그인에 실패하였습니다.");
		}
		
	}
	
	//로그아웃
	@RequestMapping("logout.me")
	public String logout(SessionStatus status) {
		status.setComplete();
		return "redirect:/";
	}
	
	//회원가입 페이지 이동
	@RequestMapping("enroll.me")
	public String enroll() {
		return "enroll";
	}
	
	//회원가입
	@RequestMapping("insertMember.me")
	public String insertMember(@ModelAttribute Member m, @RequestParam("year") int year, @RequestParam("month") int month, @RequestParam("day") int day) {
		Date birthDay = new Date(new GregorianCalendar(year, month-1, day).getTimeInMillis());
		m.setBirthDay(birthDay);
		System.out.println(m.getBirthDay());
//		System.out.println(m);
//		System.out.println(bcrypt);
		
		//암호화 진행
		String encPwd = bcrypt.encode(m.getPwd());
//		System.out.println(encPwd);
		m.setPwd(encPwd);
		
		int result = mService.insertMember(m);
		
		if(result > 0) {
			System.out.println("회원가입 성공");
			return "redirect:/";
		} else {
			throw new MemberException("회원가입 실패");
		}
	}
	
	//회원가입 아이디 중복체크
	@RequestMapping("checkId.me")
	public void checkId(@RequestParam("id") String id, PrintWriter out) {
		int count = mService.checkId(id);
		String result = count == 0 ? "yes":"no";
		out.println(result);
	}
	
	//회원가입 닉네임 중복체크
		@RequestMapping("checkNickName.me")
		public void checkNickName(@RequestParam("nickName") String nickName, PrintWriter out) {
			int count = mService.checkNickName(nickName);
			String result = count == 0 ? "yes":"no";
			out.println(result);
		}
	
	//아이디 찾기 페이지로
	@RequestMapping("findId.me")
	public String findId() {
		
		return "findId";
	}
	
	//비밀번호 찾기 페이지로
	@RequestMapping("findPwd.me")
	public String findPwd() {
		return "findPwd";
	}
	
	
	//정보 수정 페이지로
		@RequestMapping("updateMyInfo.me")
		public String updateMyInfo() {
			return "update";
		}
		
		//정보 수정
		@RequestMapping("update.me")
		public String update(@ModelAttribute Member m, Model model, @RequestParam("year") int year, @RequestParam("month") int month, @RequestParam("day") int day, @RequestParam("currentPwd") String pwd, @RequestParam("newPwd") String newPwd) {
			//생년월일 처리
			Date birthDay = null;
			if(year > 0 & month > 0 & day > 0) {
				birthDay = new Date(new GregorianCalendar(year, month-1, day).getTimeInMillis());
				m.setBirthDay(birthDay);
			}
			int result = mService.updateMember(m); //여기서 result값 1 됨
			//update 처리
			m = (Member)model.getAttribute("loginUser");
			if(bcrypt.matches(pwd, m.getPwd())) {
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("id", m.getId());
				map.put("newPwd", bcrypt.encode(newPwd));
				
				result += mService.updatePwd(map);
			}
			
			if(result == 2) {
				model.addAttribute("loginUser", mService.login(m));
				return "redirect:/";
			} else {
				throw new MemberException("회원수정에 실패하였습니다.");
			}
		}
		
	
	//아이디 찾기
	@RequestMapping("findMyId.me")
	public String test(Email email, Model model){
//		System.out.println(email.getEmail());
//		System.out.println(email.getName());
		int check = mService.checkMember(email); //유효한 멤버인지 확인
//		System.out.println("체크값" + check);
		if(check == 1) {
			Map<String, Object> map = emailAuthService.getEmailAuth(email.getEmail());
			String id = mService.getId(email); //아이디 얻어옴
			
			model.addAttribute("id", id);
			model.addAttribute("authCode", map.get("emailAuthCode"));
			return "findId";
		} else {
			throw new MemberException("회원 정보가 일치하지 않습니다.");
		}
	}
	
	//비밀번호 찾기
	@RequestMapping("updateTempPwd.me")
	public String findPwd(Email email, Model model) {
		int check = mService.checkMember(email); //유효한 멤버인지 확인
		int result = 0;
		String tempPwd = "";
		Map<String, Object> map = new HashMap<String, Object>();
		if(check == 1) {
			map = emailAuthService.getEmailAuth(email.getEmail());
			tempPwd = makeTempPwd();
			
			HashMap<String, String> param = new HashMap<String, String>();
			param.put("encTempPwd", bcrypt.encode(tempPwd));
			param.put("email", email.getEmail());
			
			result = mService.updateTempPwd(param);
			} else {
				throw new MemberException("회원 정보가 일치하지 않습니다.");
		}
		if(result > 0) {
			model.addAttribute("authCode", map.get("emailAuthCode"));
			model.addAttribute("tempPwd", tempPwd);
			return "findPwd";
		} else {
			throw new MemberException("비밀번호 발급에 실패하였습니다.");
		}
	}
	
	//임시 비밀번호 생성
	private String makeTempPwd() {
		int leftLimit = 48;
		int rightLimit = 122;
		int targetStringLength = 10;
		Random random = new Random();
		String generatedString = random.ints(leftLimit, rightLimit + 1)
                .filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97))
                .limit(targetStringLength)
                .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
                .toString();
		return generatedString;
	}

	//검색 페이지로, 검색 기능
	@RequestMapping(value="search.me")
	public String search(@RequestParam("keyword") String keyword, Model model, HttpServletResponse response) {
		//행아웃 검색
		ArrayList<Hangout> list = mService.searchList(keyword); 
		
		//영화 검색
		ArrayList<Movie> movieList = new ArrayList<Movie>();
		JSONArray array = new JSONArray();
//		long totalPages = 0;
//		long totalResults = 0;
		
		try {
			URL url = new URL("https://api.themoviedb.org/3/search/movie?api_key=7bf40bf859def4eaf9886f19bb497169&region=KR&language=ko&query=" + keyword);
			
			BufferedReader bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
			String buffer = bf.readLine();
//			System.out.println("영화result" + buffer);
			
			JSONParser jsonParser = new JSONParser();
			JSONObject json = (JSONObject)jsonParser.parse(buffer);
			JSONArray resultArray = (JSONArray)json.get("results");
			
//			totalPages = (long)json.get("total_pages");
//			totalResults = (long)json.get("total_results");
			
//			JSONObject obj1 = new JSONObject();
//			obj1.put("totalPges", totalPages);
//			obj1.put("totlaResults", totalResults);
//			array.add(obj1);
			
//			System.out.println(resultArray);
			
			for(int i = 0; i < resultArray.size(); i++) {
				JSONObject result = (JSONObject)resultArray.get(i);
				
				long id = (long)result.get("id");
				String title = (String)result.get("title");
				String posterPath = (String)result.get("poster_path");
				
				Movie movie = new Movie();
				
				movie.setMovieId((int)id);
				movie.setMovieImg(posterPath);
				movie.setMovieTitle(title);
				movieList.add(movie);
			}
			
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		response.setContentType("text/html;charset=UTF-8");
		if(list != null) {
//			System.out.println(list);
			model.addAttribute("list", list);
			model.addAttribute("keyword", keyword);
			model.addAttribute("movieList", movieList);
			System.out.println("뭅리시트" + movieList);
			return "search";
		} else {
			throw new MemberException("게시글 검색 실패");
		}
	}
	
	//리뷰 카운팅
	@RequestMapping("cinetalk/")
	public String countReview(Model model) {
		int result = mService.countReview();
		System.out.println("결과" + result);
		model.addAttribute("rCount", result);
		
		return "redirect:/";
	}
	
}
