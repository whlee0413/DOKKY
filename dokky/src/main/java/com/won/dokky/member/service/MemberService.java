package com.won.dokky.member.service;

import com.won.dokky.member.MemberVO;

public interface MemberService {
	void memberRegister(MemberVO member);
	public MemberVO memberSelect(MemberVO member);
	public MemberVO memberUpdate(MemberVO member);
	public int memberRemove(String member);
	public int memberIdCheck(String memId);
}