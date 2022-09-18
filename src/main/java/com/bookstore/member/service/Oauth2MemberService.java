package com.bookstore.member.service;

import com.bookstore.member.domain.MemberDto;
import com.bookstore.member.domain.PrincipalDetails;
import com.bookstore.member.mapper.MemberMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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

    public void setPasswordEncoder(PasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }


    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {

        OAuth2User oAuth2User = super.loadUser(userRequest);

        String memberName = oAuth2User.getAttribute("name");
        String memberEmail = oAuth2User.getAttribute("email");
        String uuid = UUID.randomUUID().toString().substring(0, 6);
        String password = passwordEncoder.encode("패스워드"+uuid);  // 사용자가 입력한 적은 없지만 만들어준다

        MemberDto memberDto = memberMapper.selectMemberByEmail(memberEmail);

        if (memberDto == null) {
            memberDto = MemberDto.builder()
                    .memberEmail(memberEmail)
                    .memberName(memberName)
                    .memberPassword(password)
                    .build();
            memberMapper.createMember(memberDto);
        }

        return new PrincipalDetails(memberDto, oAuth2User.getAttributes());

    }


}
