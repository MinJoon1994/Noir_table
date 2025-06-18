package com.noir.member.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.noir.member.vo.MemberVO;

@Repository
public class MemberDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	//1.회원등록
	public void register(MemberVO memberVO) {
		sqlSession.insert("mapper.member.insertMember",memberVO);
	}
	
	//2.회원 가입된 아이디 존재하는지 체크
	public boolean countByLoginId(String loginId) {
		Integer count = sqlSession.selectOne("mapper.member.countByLoginId", loginId);
		return count !=null && count > 0;
		
	}
	//3.로그인 처리
	public MemberVO login(String loginId,String password) {
		Map<String,String> map = new HashMap<>();
		map.put("login_id",loginId);
		map.put("password", password);
		return sqlSession.selectOne("mapper.member.login",map);
	}
	
	//4.카카오 로그인 회원 등록
	public void registerKakao(MemberVO memberVO) {
		sqlSession.insert("mapper.member.insertKakaoMember",memberVO);
	}
	
	//5.소셜 로그인 회원 고유 ID로 회원가입 유무 판별
	public MemberVO findBySnsId(String snsId) {
		
		return sqlSession.selectOne("mapper.member.findByKakaoId",snsId);
	}
	
	//6.구글 로그인 회원 등록
	public void registerGoogle(MemberVO memberVO) {
	
		sqlSession.insert("mapper.member.insertGoogleMember",memberVO);
		
	}
	
	//7.구글 로그인 회원 전화번호 등록
	public void saveGooglePhone(String phone, String snsId) {
		
		Map<String,String> map = new HashMap<>();
		map.put("phone", phone);
		map.put("snsId", snsId);
		
		sqlSession.update("mapper.member.saveGooglePhone",map);
		
	}
	
	//8.회원 개인정보 수정
	public void updateMember(MemberVO member) {
		
		sqlSession.update("mapper.member.updateMember",member);
		
	}
	
	//9.소셜 로그인 연동
	public void snslink(MemberVO member) {
		sqlSession.update("mapper.member.snslink",member);
	}
	

}
