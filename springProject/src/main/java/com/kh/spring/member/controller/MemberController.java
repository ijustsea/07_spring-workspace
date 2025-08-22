package com.kh.spring.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.spring.member.model.service.MemberService;
import com.kh.spring.member.model.service.MemberServiceImpl;
import com.kh.spring.member.model.vo.Member;

@Controller //Controller 타입의 어노테이션 붙여주면 빈 스캐닝을 통해 자동으로 빈등록
public class MemberController {
	
	//private MemberService mService = new MemberServiceImpl();
	@Autowired //(Dependency Injection) DI 특징
	private MemberServiceImpl mService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	
	/*
	//RequestMapping 타입의 어노테이션 붙여줌으로써 
	//HandlerMapping 등록
	@RequestMapping(value="login.me")
	public void loginMember() {
		
	}
	@RequestMapping(value="insert.me")
	public void insertMember() {
		
	}
	@RequestMapping(value="update.me")
	public void updateMember() {
		
	}
	*/
	
	
	//파라미터( 요청시 전달값 ) 받는 방법 
	//1번.request.getParameter (기존 jsp/servlet 방식)
	//  해당메소드 매개변수로 HttpServletRequest 작성해두면 
	//  스프링이 해당 메소드 호출시 자동으로 해당객체 생성해서 인자로 주입
	/*
	@RequestMapping("login.me")
	public String loginMember(HttpServletRequest request) {
		String userId = request.getParameter("id");
		String userPwd = request.getParameter("pwd");
		
		System.out.println("ID : " + userId);
		System.out.println("PWD : " + userPwd);
		
		return "main";
	}
	*/
	//2번.@RequestParam 이용하는법
	/*
	@RequestMapping("login.me")
	public String loginMember(@RequestParam(value="id", defaultValue="aaa") String userId, 
							  @RequestParam(value="pwd") String userPwd	) {
		System.out.println("ID : " + userId);
		System.out.println("PWD : " + userPwd);
		
		
		return "main";
	}
	*/
	/*
	 * 3번.@RequestParam 어노테이션 생략하는법
	 * 단, 매개변수명과 jsp의 name값을 동일하게 세팅해야지 자동으로 값주입
	 */
	/*
	@RequestMapping("login.me")
	public String loginMember(String id, String pwd) {
		
		System.out.println("ID : " + id);
		System.out.println("PWD : " + pwd);
		
		
		return "main";
	}
	*/
	
	/*
	 * 4번.커맨드 객체 방식
	 * 해당 메소드의 매개변수로 
	 * 요청 시 전달값을 담고자하는 vo 클래스 타입을 세팅후
	 * 요청 시 전달값의 키값(name값)을 
	 * vo 클래스 담고자하는 필드명으로 작성하면 자동주입해준다.
	 * 
	 * 스피링이 해당객체를 기본생성자로 생성후 setter 메소드를 찾아서
	 * 요청시 전달값을 해당 필드에 담아주는 내부적인 원리이다.
	 * 
	 * 반드시 jsp name값과 담고자하는 vo 필드명이 동일시키는것이 사용법이다.
	 */
	
	/*
	 * 요청처리후 응답페이지로 포워딩 또는 url재요청 
	 * 1.스프링에서 제공하는 Model 객체 사용하기
	 *   포워딩할 뷰로 전달하고하는 데이터를 맵형식(k-v)담을수 있는 영역
	 *   Model 객체는 requestScope다.
	 *   단. setAttribute 아닌 addAttribute 메소드 써야함.
	 */
	
	/*
	@RequestMapping("login.me")
	public String loginMember(Member m, Model model, HttpSession session) {
		Member loginUser = mService.loginMember(m);
			
		if(loginUser==null) {//에러페이지
			model.addAttribute("errorMsg","로그인실패");
			return "common/errorPage";
		}else {//성공
			
			session.setAttribute("loginUser", loginUser);
			return "redirect:/";
		}
		
		
	}
	*/
	
	/*
	 * 2.스프링에서 제공하는 ModelAndView 객체 이용하는방법~
	 *   Model은 데이터를 k-v 세트를 담을수 있는 공간이라한다면
	 *   View는 응답 뷰에 대한 정보를 담을 수 있는 공간
	 */
	@RequestMapping("login.me")
	public ModelAndView loginMember(Member m, HttpSession session, ModelAndView mv) {
		/* 암호화 작업전 방식
		Member loginUser = mService.loginMember(m);
			
		if(loginUser==null) {//에러페이지
			mv.addObject("errorMsg", "로그인 실패");
			mv.setViewName("common/errorPage");
			
		}else {//성공			
			session.setAttribute("loginUser", loginUser);
			mv.setViewName("redirect:/");			
		}
		return mv;
		*/
		
		//암호화 작업 후에 해야하는 과정
		//Member m userId 필드 : 사용자가 입력한 아이디
                 //userPwd 필드 : 사용자가 입력한 비번 (평문) 
		Member loginUser = mService.loginMember(m);
		//지금은 loginUser 객체에 오로지 아이디만을 가지고 조회한 회원정보 담김
		//match로 사용자 입력한 비밀번호와 암호화된 비밀번호를 확인함
		//userPwd(평문)와 DB의 loginUser.userPwd(암호문)
		
		if(loginUser != null && bcryptPasswordEncoder.matches(m.getUserPwd(),loginUser.getUserPwd() )) {
			session.setAttribute("loginUser", loginUser);
			mv.setViewName("redirect:/");				
		}else {
			mv.addObject("errorMsg", "로그인 실패");
			mv.setViewName("common/errorPage");
		}
		return mv;
	}
	
	@RequestMapping("logout.me")
	public String logoutMember(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping("enrollForm.me")
	public String enrollMember() {
		return "member/enrollPage";
	}
	
	@RequestMapping("insert.me")
	public String insertMember(Member m, Model model, HttpSession session) {
		//spring 기본생성자로 vo 만들어서 초깃값들어있음.
		System.out.println(m);
		//1.한글 깨짐.->스프링 인코딩 필터 등록.
		//2.나이 미입력시 -> 빈문자열이 int형변환 되지 않아서 400에러 발생
		//member클래스의 age의 자료형을 int->String으로 변경하면 해결.
		//3.비밀번호가 너무 잘보임 -> 보안성이 없음. 
		// 사용자가 입력한 비밀번호 평뮨 => Bcrypt 방식의  암호화를 통해 암호문으로 변경 
		//: 1) 스프링 시큐리티 모듈에서 제공 (라이브러리 추가 pom.xml)
		//: 2) BcryptPassWordEncoder라는 클래스 빈등록
		//: 3) web.xml에 spring-security.xml 파일을 pre-loading 할수있도록 작성.
		
		
		//평문(있는 그대로의 값) --암호화--> 암호문($#fd@afdvc)
		//암호문($#fd@afdvc) --복호화--> 평문(있는 그대로의 값) 
		//암호화 방식 -> 1. 단방향암호화방식 SHA-256, SHA-512
		
		//복호화 방식 -> 2. Bcrypt 복화화방식
		//salting 기법(랜던값) : 평문 + 랜덤값
		
		//System.out.println("평문 : " + m.getUserPwd());
		
		//암호화 작업(암호문 생성 과정)
		String encPwd = bcryptPasswordEncoder.encode(m.getUserPwd());
		//System.out.println(encPwd);
		m.setUserPwd(encPwd); //Member 객체에 평문대신 암호문으로 변경 userPwd -> encPwd
		
		int result = mService.insertMember(m);
		
			
		if(result>0) {//회원가입 성공
			session.setAttribute("alertMsg", "성공적으로 회원가입 되었습니다.");
			return "redirect:/";
		}else {//회원가입 실패 
			model.addAttribute("errorMsg","회원가입 실패");
			return "common/errorPage";
		}
	}
	
	@RequestMapping("myPage.me")
	public String myPage() {
		return "member/myPage";
	}
	
	@RequestMapping("update.me")
	public String updateMember(Member m, Model model, HttpSession session) {
		int result = mService.updateMember(m);
		 
		if(result>0) {//수정성공
			//db로 부터 수정된 회원정보를 다시 조회해서 session을 갈아끼우기 
			//session에 loginUser라는 키값으로 덮어 씌어야함.
			//Member updateMem = mService.loginMember(m);
			//session.setAttribute("loginUser", updateMem);
			
			session.setAttribute("loginUser", mService.loginMember(m));
			session.setAttribute("alertMsg", "성공적으로 회원정보 변경되었습니다.");
			return "redirect:myPage.me";
			
		}else {//수정실패
			model.addAttribute("errorMsg", "회원정보 수정실패");
			return "common/errorPage";
		}
		
	}
	
	@RequestMapping("delete.me")
	public String deleteMember(String userPwd, Model model , HttpSession session) {
		
	    Member sessionUser = (Member)session.getAttribute("loginUser");	    
	    
		 if (sessionUser != null && bcryptPasswordEncoder.matches(userPwd, sessionUser.getUserPwd())) {
		
			int result = mService.deleteMember(sessionUser.getUserId());
			 
			if(result>0) {//탈퇴 성공
				session.setAttribute("alertMsg", "성공적으로 회원탈되 되었습니다.");
				session.removeAttribute("loginUser");
				return "redirect:/";
				
			}else {//수정실패
				model.addAttribute("errorMsg", "회원탈퇴 실패");
				return "common/errorPage";
			}
		
	    }else {
	    	model.addAttribute("errorMsg", "비밀번호가 일치하지 않습니다.");
	        return "common/errorPage";
	    }
	}
	
}
