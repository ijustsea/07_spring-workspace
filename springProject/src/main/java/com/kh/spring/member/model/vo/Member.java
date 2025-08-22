package com.kh.spring.member.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/*
 *  Lombok(룸복)~ maven에서 라이브러리 가져와야함.
 * 1.pom.xml에서 dependency로 Lombok lib 다운로드
 * 2.다운로드된 Lombok jar 찾아서 설치(작업할 IDE선택 후 설치)
 * 3.IDE 재실행
 * (주의점 앞에 2글자이상은 소문자로 필드부네이밍을 해야지 문제 안생김)
 */

@NoArgsConstructor //기본 생성자
@AllArgsConstructor //전체 매개변수 생성자
@Getter
@Setter
@ToString
public class Member {
	
	private String userId;
	private String userPwd;
	private String userName;
	private String email;
	private String gender;
	//private int age;
	private String age;
	private String phone;
	private String address;
	private Date enrollDate;
	private Date modifyDate;
	private String status;
	
	
	
	
}
