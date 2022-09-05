package com.bookstore.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/account")
public class LoginController {

    @GetMapping("/sign-in")
    public String loginForm() {
        return "/member/loginForm";
    }
}

