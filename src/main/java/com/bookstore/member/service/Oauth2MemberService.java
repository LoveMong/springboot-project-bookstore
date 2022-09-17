package com.bookstore.member.service;

import com.bookstore.member.domain.MemberDto;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Primary;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class Oauth2MemberService extends DefaultOAuth2UserService {

    private final MemberService memberService;
    private final PasswordEncoder passwordEncoder;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {

        OAuth2User oAuth2User = super.loadUser(userRequest);

        String provider = userRequest.getClientRegistration().getRegistrationId(); // google
        String providerId = oAuth2User.getAttribute("sub");
        String memberName = oAuth2User.getAttribute("name");
        String memberEmail = oAuth2User.getAttribute("eamil");

        MemberDto memberDto = memberService.selectMemberByEmail(memberEmail);

        if (memberDto == null) {
            memberDto = MemberDto.builder()
                    .memberEmail(memberEmail)
                    .memberName(memberName)
                    .build();
            memberService.createMember(memberDto);
        }

        return memberDto;

    }


}
