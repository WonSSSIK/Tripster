package com.tripster.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.tripster.domain.MemberVO;
import com.tripster.dto.LoginDTO;
import com.tripster.service.MemberService;

@Controller
@RequestMapping("/member/*")
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Inject
	private MemberService service;

	//로그인
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void loginGET(@ModelAttribute("dto") LoginDTO dto) {

	}

	@RequestMapping(value = "/loginPost", method = RequestMethod.POST)
	public void loginPOST(LoginDTO dto, HttpSession session, Model model) throws Exception {

		MemberVO vo = service.login(dto);

		if (vo == null) {
			return;
		}
		model.addAttribute("memberVO", vo);
	}

	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void registerGET(MemberVO vo, Model model) throws Exception {

		logger.info("넌 찍히니?");
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registerPost(MemberVO vo, Model model) throws Exception {
		
		System.out.println(vo);
		
		logger.info("회원 등록");
		logger.info(vo.toString());
		
		service.insertMember(vo);
		
		model.addAttribute("result", "success");
		
		return "/member/registerPost";
	}
}

