package com.bookstore.member.controller;

import com.bookstore.member.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;


/**
 * 로그인기능을 위한 컨트롤러
 *
 * @author L
 */
@Controller
@RequestMapping("/account")
@RequiredArgsConstructor
public class LoginController {


    private final MemberService memberService;

    private final PasswordEncoder passwordEncoder;



    /**
     * 로그인 화면으로 이동하는 메소드
     * @return 로그인 화면
     */
    @GetMapping("/sign-in")
    public String loginForm() {
        return "/member/loginForm";
    }

    @GetMapping("/sign-in/error")
    public String loginErrorForm() {
        String message = URLEncoder.encode("아이디 또는 패스워드가 일치하지 않습니다.", StandardCharsets.UTF_8);
        return "redirect:/account/sign-in?message=" + message;
    }


}

