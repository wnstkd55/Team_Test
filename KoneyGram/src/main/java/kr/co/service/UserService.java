package kr.co.service;

import kr.co.vo.UsersVO;

public interface UserService {
	
	// 회원가입
	public void register(UsersVO vo) throws Exception;
	
	// 로그인
	public UsersVO login(UsersVO vo) throws Exception;
	
	// 회원정보수정
	public void userUpdate(UsersVO vo) throws Exception;
	
	// 회원탈퇴
	public void userDelete(UsersVO vo) throws Exception;
	
	// 패스워드 체크
	public int passChk(UsersVO vo) throws Exception;
	
	// 아이디 중복 체크
	public int idChk(UsersVO vo) throws Exception;
	
}
