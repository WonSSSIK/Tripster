package com.tripster.controller;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import com.tripster.domain.MemberVO;
import com.tripster.dto.LoginDTO;
import com.tripster.service.MemberService;

@Controller
@RequestMapping("/member/*")
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Inject
	private MemberService service;

	//로그인 화면 접근
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void loginGET(@ModelAttribute("dto") LoginDTO dto) {

	}

	//로그인 처리
	@RequestMapping(value = "/loginPost", method = RequestMethod.POST)
	public void loginPOST(LoginDTO dto, HttpSession session, Model model) throws Exception {

		MemberVO vo = service.login(dto);

		if (vo == null) {
			return;
		}
		model.addAttribute("memberVO", vo);
	}

	//회원가입 화면 접근
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void registerGET(MemberVO vo, Model model) throws Exception {

	}
	
	//회원가입 처리
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registerPost(MemberVO vo, RedirectAttributes rttr) throws Exception {
		
		System.out.println(vo);
		
		logger.info("회원 등록");
		logger.info(vo.toString());
		
		service.register(vo);
		
		rttr.addFlashAttribute("msg", "success");
		
		return "redirect:/member/login";
	}
	
	//로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request,
						 HttpServletResponse response, HttpSession session) throws Exception {
		
		Object obj = session.getAttribute("login");
		
		if(obj != null) {
			MemberVO vo = (MemberVO)obj;
			
			session.removeAttribute("login");
			session.invalidate();
			
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			
			if(loginCookie != null) {
				loginCookie.setPath("/");
				loginCookie.setMaxAge(0);
				response.addCookie(loginCookie);
				
				//로그인 유지 구현 후 주석처리 삭제
				//service.keepLogin(vo.getUid(), session.getId(), new Date());
			}
		}
		return "member/logout";
	}
	
	//유저 추천페이지 위한 설문페이지 제공
	@RequestMapping(value = "/register/detail", method = RequestMethod.GET)
	public String userDetail(MemberVO vo, Model model) throws Exception {

		return "member/userDetail";
	}
	
	//유저 추천페이지 위한 설문페이지 제공
	@RequestMapping(value = "/register/editDetail", method = RequestMethod.GET)
	public String editUserDetail(MemberVO vo, Model model) throws Exception {

		return "member/editUserDetail";
	}
}

