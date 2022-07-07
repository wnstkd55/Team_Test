package kr.co.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.service.UserService;
import kr.co.vo.UsersVO;

@Controller
@RequestMapping("/user/*")
public class UserController {
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Inject
	UserService service;
	
	// 회원가입 get
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void getRegister() throws Exception{
		logger.info("get register");
		
	}
	
	// 회원가입 post
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String postRegister(UsersVO vo) throws Exception{
		logger.info("post register");
		int result = service.idChk(vo);
		try {
			if(result == 1) {
				return "/user/register";
			}else if(result ==0 ) {
				service.register(vo);
			}
		}catch(Exception e) {
			throw new RuntimeException();
		}
		return "redirect:/";
	}
	
	// 로그인
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(UsersVO vo, HttpServletRequest req, RedirectAttributes
			 rttr) throws Exception{
		HttpSession session = req.getSession();
		UsersVO login = service.login(vo);
		
		if(login == null) {
			session.setAttribute("user", null);
			rttr.addFlashAttribute("user",false);
		}else {
			session.setAttribute("user", login);
		}
		
		return "redirect:/";
	}
	
	// 로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) throws Exception{
		session.invalidate();
		return "redirect:/";
	}
	
	// 회원정보수정 get
	@RequestMapping(value = "/userUpdateView", method = RequestMethod.GET)
	public String registerUpdateView() throws Exception{
		return "user/userUpdateView";
	}
	// 회원정보수정 post
	@RequestMapping(value = "userUpdate", method = RequestMethod.POST)
	public String registerUpdate(UsersVO vo, HttpSession session) throws Exception{
		service.userUpdate(vo);
		session.invalidate();
		
		return "redirect:/";
	}
	
	// 회원탈퇴 get	
	@RequestMapping(value = "/userDeleteView", method = RequestMethod.GET)
	public String userDeleteView() throws Exception{
		return "user/userDeleteView";
	}
	// 회원탈퇴 post
	@RequestMapping(value = "/userDelete", method = RequestMethod.POST)
	public String userDelete(UsersVO vo, HttpSession session, RedirectAttributes rttr) throws Exception{
		UsersVO user = (UsersVO) session.getAttribute("user");
		String sessionPwd = user.getUserPwd();
		String voPwd = vo.getUserPwd();
		if(!(sessionPwd.equals(voPwd))) {
			rttr.addFlashAttribute("msg", false);
			return "redirect:/user/userDeleteView";
		}
		service.userDelete(vo);
		session.invalidate();
		return "redirect:/";
	}
	
	// 패스워드 체크
	@ResponseBody
	@RequestMapping(value="/passChk", method = RequestMethod.POST)
	public int passChk(UsersVO vo) throws Exception{
		int result = service.passChk(vo);
		return result;
	}
	
	// 아이디 중복 체크
	@ResponseBody
	@RequestMapping(value="/idChk", method = RequestMethod.POST)
	public int idChk(UsersVO vo) throws Exception{
		int result = service.idChk(vo);
		return result;
	}
	
}
