package com.bookstore.member.service;

import com.bookstore.member.domain.MemberDto;
import com.bookstore.member.domain.PrincipalDetails;
import com.bookstore.member.mapper.MemberMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class PrincipalDetailService implements UserDetailsService {

    private final MemberMapper memberMapper;

    @Override
    public UserDetails loadUserByUsername(String memberEmail) throws UsernameNotFoundException {
        MemberDto memberDto = memberMapper.selectMemberByEmail(memberEmail);
        if (memberDto == null) {
            throw new UsernameNotFoundException("Member no authorized.");
        }
        return new PrincipalDetails(memberDto);
    }
}
