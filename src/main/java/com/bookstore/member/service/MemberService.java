package com.bookstore.member.service;

import com.bookstore.member.domain.MemberDto;
import com.bookstore.member.mapper.MemberMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class MemberService implements UserDetailsService {

    private final MemberMapper memberMapper;


    public void createMember(MemberDto member) {
        memberMapper.createMember(member);
    }

    public MemberDto selectMemberByEmail(String email) {
        return memberMapper.selectMemberByEmail(email);
    }

    @Override
    public MemberDto loadUserByUsername(String memberEmail) throws UsernameNotFoundException {
        MemberDto memberDto = memberMapper.selectMemberByEmail(memberEmail);
        if (memberDto == null) {
            throw new UsernameNotFoundException("Member no authorized.");
        }
        return memberDto;
    }
}
