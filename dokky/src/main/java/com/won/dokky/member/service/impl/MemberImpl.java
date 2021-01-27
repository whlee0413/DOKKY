package com.won.dokky.member.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.won.dokky.member.MemberVO;
import com.won.dokky.member.mapper.MemberMapper;
import com.won.dokky.member.service.MemberService;

@Service
public class MemberImpl implements MemberService{

	
	@Autowired
	MemberMapper memberMapper;
	
	
	@Override
	public void memberRegister(MemberVO member) {
		memberMapper.memberInsert(member);
	}


	@Override
	public MemberVO memberSelect(MemberVO member) {
		
		return memberMapper.memberSelect(member);
	}


	@Override
	public MemberVO memberUpdate(MemberVO member) {
		int result = memberMapper.memberUpdate(member);
		
		if(result == 0 ) {
			System.out.println("Modify Fail!!");
			return null;
		} else {
			System.out.println("Modify Success!!");
		}
		return member;
	}


	@Override
	public int memberRemove(String member) {
	
		return  memberMapper.memberDelete(member);
	}


	@Override
	public int memberIdCheck(String memId) {
		return memberMapper.memberIdCheck(memId);
	}




	

	

}