package com.bookstore.member.service;

import com.bookstore.member.domain.MemberDto;
import com.bookstore.member.mapper.MemberMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class MemberService {

    private final MemberMapper memberMapper;


    public void createMember(MemberDto member) {
        memberMapper.createMember(member);
    }

    public MemberDto selectMemberByEmail(String email) {
        return memberMapper.selectMemberByEmail(email);
    }

}
