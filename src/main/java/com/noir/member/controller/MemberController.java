package com.noir.member.controller;

import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.support.HttpRequestHandlerServlet;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.noir.member.service.MemberService;
import com.noir.member.vo.GoogleProfile;
import com.noir.member.vo.KakaoProfile;
import com.noir.member.vo.MemberVO;
import com.noir.member.vo.NaverProfile;
import com.noir.member.vo.OAuthToken;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	//멤버 로그인 화면 요청
	@RequestMapping(value="/loginForm.do")
	public ModelAndView loginForm(HttpServletRequest req,HttpServletResponse resp)throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		String viewName = (String)req.getAttribute("viewName");
		mav.setViewName(viewName);
		
		return mav;
		
	}
	
	//멤버 회원가입 화면 요청
	@RequestMapping(value="/registerForm.do")
	public ModelAndView registerForm(HttpServletRequest req,HttpServletResponse resp)throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		String viewName = (String)req.getAttribute("viewName");
		mav.setViewName(viewName);
		
		return mav;
		
	}
	
	//구글 로그인 회원 전화번호 입력 요청폼
	@RequestMapping(value="/googleForm.do")
	public ModelAndView googleForm(HttpServletRequest req,HttpServletResponse resp)throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		String viewName = (String)req.getAttribute("viewName");
		mav.setViewName(viewName);
		
		return mav;
		
	}
	
	//구글 회원 전화번호 저장
	@RequestMapping(value="/saveGooglePhone",method=RequestMethod.POST)
	public ModelAndView saveGooglePhone(@RequestParam("phone")String phone,
			HttpServletRequest req,HttpServletResponse resp)throws Exception {
				
		memberService.saveGooglePhone(req,phone);
				
		return new ModelAndView("forward:/WEB-INF/views/member/saveSuccess.jsp");
	}
	
	//멤버 회원가입 처리
	@RequestMapping(value="/register.do",method=RequestMethod.POST)
	public ModelAndView register(HttpServletRequest req, HttpServletResponse resp)throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		//회원가입 폼 값 받아오기
		String loginId = req.getParameter("loginId");
		String password = req.getParameter("password");
		String name = req.getParameter("name");
		String phone = req.getParameter("phone");
		String agreePolicy = req.getParameter("agreePolicy");
		
		boolean hasError = false;
		
		//값 유효성 검사
	    if (loginId == null || loginId.trim().isEmpty()) {
	        req.setAttribute("loginIdError", "아이디를 입력해주세요.");
	        hasError = true;
	    }
	    if (password == null || password.trim().isEmpty()) {
	        req.setAttribute("passwordError", "비밀번호를 입력해주세요.");
	        hasError = true;
	    }
	    if (name == null || name.trim().isEmpty()) {
	        req.setAttribute("nameError", "이름을 입력해주세요.");
	        hasError = true;
	    }
	    if (phone == null || phone.trim().isEmpty()) {
	    	req.setAttribute("phoneError", "전화번호를 입력해주세요.");
	    	hasError = true;
	    }
	    
	    if (agreePolicy==null|| agreePolicy.isEmpty()) {
	    	req.setAttribute("agreePolicyError", "개인정보 처리방침 동의는 필수 선택입니다.");
	    	hasError =true;
	    }

	    if (hasError) {
	        mav.setViewName("/member/registerForm");
	        return mav;
	    }
	    
	    memberService.register(req);
	    
	    return new ModelAndView("forward:/WEB-INF/views/member/registerSuccess.jsp");
		
	}
	
	//로그인
	@RequestMapping(value="/login.do",method=RequestMethod.POST)
	public ModelAndView login(HttpServletRequest req, HttpServletResponse resp) {
		
		ModelAndView mav = new ModelAndView();
		
		//로그인 사용자 정보 받아오기
		MemberVO member = memberService.login(req);
		
		if(member==null) {
			mav.setViewName("/member/loginForm");
			return mav;
		}
		
		HttpSession session = req.getSession();
		session.setAttribute("member", member);
		
		MemberVO members = (MemberVO) session.getAttribute("member");
		Integer memberId = members.getId();
		System.out.println("로그인한 member 객체 : " + members);
		System.out.println("로그인한 memberid : " + memberId);
		
		mav.setViewName("redirect:/main.do");
		
		return mav;
	}
	
	//로그아웃
	@RequestMapping("/logout.do")
	public ModelAndView logout(HttpServletRequest req,HttpServletResponse resp) {
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = req.getSession();
		
		//세션 무효화
		session.invalidate();
		
		mav.setViewName("redirect:/main.do");
		
		return mav;
	}
	
	
	//카카오 로그인
	@RequestMapping(value="/KakaoCallback",
					produces="application/json;charset=utf-8",
					method=RequestMethod.GET)
	public ModelAndView kakaoCallback(String code,
			HttpServletRequest req,
			HttpServletResponse resp) throws Exception{
		ModelAndView mav = new ModelAndView();
		
		RestTemplate rt = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
		
		LinkedMultiValueMap<String,String> params = new LinkedMultiValueMap<String, String>();
		
		params.add("grant_type", "authorization_code");
		params.add("client_id", "f21e91b25c99a317f8ac6471ac3f3c5a");
		params.add("redirect_uri", "http://localhost:8090/noir/member/KakaoCallback");
		params.add("code", code);
		
		HttpEntity<MultiValueMap<String,String>> kakaoTokenRequest = new HttpEntity<>(params,headers);
		
		ResponseEntity<String> respEntity = rt.exchange("https://kauth.kakao.com/oauth/token",
												HttpMethod.POST,
												kakaoTokenRequest,
												String.class
											);
		
		ObjectMapper objMapper = new ObjectMapper();
		
		OAuthToken oAuthToken = objMapper.readValue(respEntity.getBody(),OAuthToken.class);
		
		RestTemplate rt2 = new RestTemplate();
		
		HttpHeaders header2 = new HttpHeaders();
					header2.add("Authorization", "Bearer "+oAuthToken.getAccess_token());
					header2.add("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
		
		HttpEntity<MultiValueMap<String, String>> kakaoProfileRequest2 = new HttpEntity<>(header2);
					
		ResponseEntity<String> respEntity2 = rt2.exchange(
				"https://kapi.kakao.com/v2/user/me",
				HttpMethod.POST,
				kakaoProfileRequest2,
				String.class);
		
		ObjectMapper objMapper2 = new ObjectMapper();
		
		KakaoProfile kakaoProfile = objMapper2.readValue(respEntity2.getBody(),KakaoProfile.class);
		
		//카카오 프로필 카카오 고유 ID로 가입되어 있는지 조회
		MemberVO member = memberService.findByKakaoId(req,kakaoProfile);
		
		//조회되지 않는다면 새로 회원가입
		if(member == null) {
			//카카오 서비스에서 받아온 회원정보로 회원가입처리
			member = memberService.registerKakaoLogin(req,kakaoProfile);
		}
		
		HttpSession session = req.getSession();
		session.setAttribute("member", member);
		
		mav.setViewName("redirect:/main.do");
		
		return mav;
	}
	
	//네이버 로그인
	@RequestMapping(value="/NaverCallback")
	public ModelAndView naverCallback(String code,String state,
			HttpServletRequest req, HttpServletResponse resp) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		//1.AccessToken 요청
		RestTemplate rt = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
		
		LinkedMultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", "EcRl77o5MKP8XONskdgt");
		params.add("client_secret", "jQ1Ger1kUa");
		params.add("code", code);
		params.add("state", state);
		
		HttpEntity<MultiValueMap<String, String>> tokenRequest = new HttpEntity<MultiValueMap<String,String>>(params,headers);
		
		ResponseEntity<String> tokenResponse = rt.exchange(
				"https://nid.naver.com/oauth2.0/token",
				HttpMethod.POST,
				tokenRequest,
				String.class
		);
		
		ObjectMapper objectMapper = new ObjectMapper();
		OAuthToken naverToken = objectMapper.readValue(tokenResponse.getBody(), OAuthToken.class);
		
		RestTemplate rt2 = new RestTemplate();
		HttpHeaders profileHeaders = new HttpHeaders();
		profileHeaders.add("Authorization", "Bearer " + naverToken.getAccess_token());

		HttpEntity<String> profileRequest = new HttpEntity<>(profileHeaders);

		ResponseEntity<String> profileResponse = rt2.exchange(
			"https://openapi.naver.com/v1/nid/me",
			HttpMethod.GET,
			profileRequest,
			String.class
		);
		
		NaverProfile naverProfile = objectMapper.readValue(profileResponse.getBody(), NaverProfile.class);
		
		MemberVO member = memberService.findByNaverId(req,naverProfile);
		
		if(member == null) {
			member = memberService.registerNaverLogin(req,naverProfile);
		}
		
		HttpSession session = req.getSession();
		session.setAttribute("member", member);
		
		mav.setViewName("redirect:/main.do");
		
		return mav;
	}
	
	//구글 로그인
	@RequestMapping(value="/GoogleCallback")
	public ModelAndView googleCallback(String code,String state,
			HttpServletRequest req, HttpServletResponse resp) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		
		// 1. Access Token 요청
	    RestTemplate rt = new RestTemplate();

	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

	    MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
	    params.add("code", code);
	    params.add("client_id", "1094665047278-252f9pu3h7e9547j7e39tjcnq83r6a2p.apps.googleusercontent.com");
	    params.add("client_secret", "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");
	    params.add("redirect_uri", "http://localhost:8090/noir/member/GoogleCallback");
	    params.add("grant_type", "authorization_code");

	    HttpEntity<MultiValueMap<String, String>> tokenRequest = new HttpEntity<>(params, headers);

	    ResponseEntity<String> tokenResponse = rt.exchange(
	        "https://oauth2.googleapis.com/token",
	        HttpMethod.POST,
	        tokenRequest,
	        String.class
	    );
	    
	    ObjectMapper mapper = new ObjectMapper();
	    OAuthToken token = mapper.readValue(tokenResponse.getBody(), OAuthToken.class);

	    // 2. 사용자 정보 요청
	    HttpHeaders profileHeader = new HttpHeaders();
	    profileHeader.add("Authorization", "Bearer " + token.getAccess_token());

	    HttpEntity<String> profileRequest = new HttpEntity<>(profileHeader);

	    ResponseEntity<String> profileResponse = rt.exchange(
	        "https://www.googleapis.com/oauth2/v2/userinfo",
	        HttpMethod.GET,
	        profileRequest,
	        String.class
	    );
	    
	    GoogleProfile googleProfile = mapper.readValue(profileResponse.getBody(), GoogleProfile.class);
		
		MemberVO member = memberService.findByGoogleId(req,googleProfile);
		
		if(member == null) {
			member = memberService.registerGoogleLogin(req,googleProfile);
		}
		
		HttpSession session = req.getSession();
		session.setAttribute("member", member);
		
		if(member.getPhone()==null)	mav.setViewName("redirect:/member/googleForm.do");
		
		if(member.getPhone()!=null) mav.setViewName("redirect:/main.do");
		
		return mav;
	}
	
}
