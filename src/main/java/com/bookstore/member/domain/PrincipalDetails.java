package com.bookstore.member.domain;

import lombok.*;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;

import java.util.Collection;
import java.util.Collections;
import java.util.Map;


@Builder
@Getter
@Setter
@ToString
public class PrincipalDetails implements UserDetails, OAuth2User {

    private MemberDto memberDto;
    private Map<String, Object> attributes;


    // 일반 시큐리티 로그인시 사용
    public PrincipalDetails(MemberDto memberDto) {
        this.memberDto = memberDto;
    }

    // OAuth2.0 로그인시 사용
    public PrincipalDetails(MemberDto memberDto, Map<String, Object> attributes) {
        this.memberDto = memberDto;
        this.attributes = attributes;
    }

    public MemberDto getMemberDto() {
        return memberDto;
    }

    /**
     * 해당 유저의 권한 목록
     * @return
     */
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return Collections.singletonList(new SimpleGrantedAuthority(this.memberDto.getMemberRole()));
    }

    /**
     * 비밀번호
     * @return
     */
    @Override
    public String getPassword() {
        return this.memberDto.getMemberPassword();
    }

    /**
     * PK 값
     * @return
     */
    @Override
    public String getUsername() {
        return this.memberDto.getMemberEmail();
    }

    /**
     * 계정 만료 여부
     * ture : 만료 안됨
     * false : 만료
     * @return
     */
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    /**
     * 계정 잠김 여부
     * ture : 잠기지 않음
     * false : 잠김
     * @return
     */
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    /**
     * 비밀번호 만료 여부
     * ture : 만료 안됨
     * false : 만료
     * @return
     */
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    /**
     * 사용자 활성화 여부
     * ture : 활성화
     * false : 비활성화
     * @return
     */
    @Override
    public boolean isEnabled() {
        return true;
    }

    // 리소스 서버로 부터 받는 회원정보
    @Override
    public Map<String, Object> getAttributes() {
        return attributes;
    }

    // Member의 Primarykey
    @Override
    public String getName() {
        return memberDto.getMemberEmail();
    }


}
