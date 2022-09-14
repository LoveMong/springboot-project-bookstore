package com.bookstore.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * 로그인기능을 위한 컨트롤러
 *
 * @author L
 */
@Controller
@RequestMapping("/account")
public class LoginController {

    /**
     * 로그인 화면으로 이동하는 메소드
     *
     * @return 로그인 화면
     */
    @GetMapping("/sign-in")
    public String loginForm() {
        return "/member/loginForm";
    }


//    @PostMapping("/sign-in")
//    public String login() {
//
//    }
}

