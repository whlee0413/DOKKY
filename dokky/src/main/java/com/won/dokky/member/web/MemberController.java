package com.won.dokky.member.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.won.dokky.member.MemberVO;
import com.won.dokky.member.service.MemberService;

@Controller
public class MemberController {

	
	@Autowired
	MemberService memberService;
	
	
		// 회원가입
		@RequestMapping("/joinForm")
		public String joinForm(MemberVO member) {
			return "/member/joinForm";
		}
		
		@RequestMapping(value = "/join", method = RequestMethod.POST)
		public String joinReg(MemberVO member, HttpSession session) {
			
			memberService.memberRegister(member);
			session.setAttribute("login", memberService.memberSelect(member));
			return "/member/joinOk";
		}
		
		// id 중복 체크 
		@RequestMapping(value = "/idCheck" , method = RequestMethod.POST)
		public @ResponseBody String idDuplChk(@ModelAttribute("vo") MemberVO vo) throws Exception{
		    int result = memberService.memberIdCheck(vo.getMemId());
		    return String.valueOf(result);
		}
		
		
		// 로그인 페이지이동
		@RequestMapping("/loginForm")
		public String loginForm(MemberVO member) {
			return "/member/loginForm";
		}
		

		
		// 로그인 처리
		@RequestMapping(value = "/login", method = RequestMethod.POST)
		public String memLogin(MemberVO member, HttpSession session, Model model) {
			String returnURL="";
			
		if ( session.getAttribute("login") != null ){
	            // 기존에 login이란 세션 값이 존재한다면
	            session.removeAttribute("login"); // 기존값을 제거해 준다.
			}
			
			
	        // 로그인이 성공하면 MemberVO 객체를 반환함.
	        MemberVO vo = memberService.memberSelect(member);
	        
	        String prev_url = (String)session.getAttribute("prev_url");
	        if(prev_url == null) {
	        	prev_url="/";
	        }
	        
	        if ( vo != null ){ // 로그인 성공
	            session.setAttribute("login", vo); // 세션에 login인이란 이름으로 VO 객체를 저장해 놈.
	               returnURL = "redirect:" +prev_url; // 로그인 성공시 메인페이지로 이동하고
	               
	        }else { // 로그인에 실패한 경우
	        	//id, 비밀번호 조회
	        	int idCheck =memberService.memberIdCheck(member.getMemId());
	        	if(idCheck == 0) {
	        		model.addAttribute("wrongId", "존재하지 않는 ID입니다.");
	        	}else {
	        		model.addAttribute("wrongPw", "비밀번호가 일치하지 않습니다.");
	        	}
	               returnURL = "/member/loginForm"; 
	        }
	        return returnURL; // 위에서 설정한 returnURL 을 반환해서 이동시킴
	    }
		
		
		// 로그아웃
		@RequestMapping("/logout")
		public String memLogout(MemberVO member, HttpSession session) {
			session.invalidate();
			return "redirect:/loginForm";
		}
		
		
		
		// 수정
		@RequestMapping(value = "/modifyForm")
		public ModelAndView modifyForm(HttpServletRequest request) {
			
			HttpSession session = request.getSession();
			MemberVO vo = (MemberVO) session.getAttribute("login");
			
			ModelAndView mav = new ModelAndView();
			mav.addObject("member", memberService.memberSelect(vo));
			
			mav.setViewName("/member/modifyForm");
			
			return mav;
		}
		
		@RequestMapping(value = "/modify", method = RequestMethod.POST)
		public ModelAndView modify(MemberVO member, HttpServletRequest request) {
			
			ModelAndView mav = new ModelAndView();
			HttpSession session = request.getSession();
			
			MemberVO mem = memberService.memberUpdate(member);
			if(mem == null) {
				mav.setViewName("/member/modifyForm");
			} else { 
				session.setAttribute("login", mem);
				
				mav.addObject("member", mem);
				mav.setViewName("/member/modifyOk");
			}
			return mav;
		}
		
		// 삭제
		@RequestMapping("/remove")
		public String memRemove( @RequestParam(value="memId", required=false) String member
									,HttpServletRequest request) {
			
			int result = memberService.memberRemove(member);
			
			if(result == 0) {
				return "redirect:/modifyForm";
			}else {
			HttpSession session = request.getSession();
			session.invalidate();
			
			return "redirect:/joinForm";
			}
		}
	
}	