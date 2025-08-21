package com.kh.spring.member.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.spring.member.model.service.MemberService;
import com.kh.spring.member.model.service.MemberServiceImpl;
import com.kh.spring.member.model.vo.Member;

@Controller //Controller 타입의 어노테이션 붙여주면 빈 스캐닝을 통해 자동으로 빈등록
public class MemberController {
	
	//private MemberService mService = new MemberServiceImpl();
	@Autowired //(Dependency Injection) DI 특징
	private MemberServiceImpl mService;
	
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
	@RequestMapping("login.me")
	public String loginMember(Member m) {
		Member loginUser = mService.loginMember(m);
		
		if(loginUser==null) {//에러페이지
			System.out.println("로그인실패");
		}else {//성공
			System.out.println("로그인성공");
			
		}
		
		return "main";
	}
	
}
