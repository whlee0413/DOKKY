package com.won.dokky.member.mapper;

import com.won.dokky.member.MemberVO;

public interface MemberMapper {
	public void memberInsert(MemberVO member);
	public MemberVO memberSelect(MemberVO member);
	public int memberUpdate(MemberVO member);
	public int memberDelete(String member);
	//id중복체크
	public int memberIdCheck(String user_id);
}
