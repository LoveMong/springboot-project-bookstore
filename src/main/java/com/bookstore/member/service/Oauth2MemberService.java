package com.bookstore.member.service;

import com.bookstore.member.domain.MemberDto;
import com.bookstore.member.domain.PrincipalDetails;
import com.bookstore.member.mapper.MemberMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class Oauth2MemberService extends DefaultOAuth2UserService {

    private final MemberMapper memberMapper;
    private PasswordEncoder passwordEncoder;



    @Autowired
    public void setPasswordEncoder(@Lazy PasswordEncoder passwordEncoder) {
        // SecurityConfig PasswordEncoder 와 순환참조 문제 발생 -> @Lazy 사용 의존성 주입 시기를 메소드 호출하는 시기로 늦춰 해결
        this.passwordEncoder = passwordEncoder;
    }


    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {

        OAuth2User oAuth2User = super.loadUser(userRequest); // 로그인 사옹쟈의 정보를 가져옴

        String memberName = oAuth2User.getAttribute("name"); // 로그인 사용자의 이름 정보
        String memberEmail = oAuth2User.getAttribute("email"); // 로그인 사용자의 이메일 주소 정보
        String uuid = UUID.randomUUID().toString().substring(0, 6); // 패스워드 생성에 필요
        String password = passwordEncoder.encode("패스워드"+uuid); // 패스워드 생성(사용자 입력값  X)

        MemberDto memberDto = memberMapper.selectMemberByEmail(memberEmail);

        // 회원 존재 유무 확인 후 회원이 아니라면 가입 처리
        if (memberDto == null) {
            memberDto = MemberDto.builder()
                    .memberEmail(memberEmail)
                    .memberName(memberName)
                    .memberPassword(password)
                    .memberRole("Role_Member")
                    .build();
            memberMapper.createMember(memberDto);
        }

        return new PrincipalDetails(memberDto, oAuth2User.getAttributes());

    }

}
