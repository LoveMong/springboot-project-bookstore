package com.bookstore;


import com.bookstore.member.domain.MemberDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@Slf4j
public class HelloController {

    @GetMapping("/")
    public String mainHome(Authentication authentication) {

//        if (authentication != null) {
//
//            log.info("타입정보 : " + authentication.getClass());
//
//            MemberDto memberDto = (MemberDto) authentication.getPrincipal();
//            log.info("ID 정보 : " + memberDto.getMemberEmail());
//            log.info("등급 정보 : " + memberDto.getMemberRank());
//            log.info("이름 정보 : " + memberDto.getMemberName());
//
//
//        }

        return "mainHome";

    }

}
