package com.bookstore.member.controller;

import com.bookstore.member.domain.ResetPasswordInfoDto;
import com.bookstore.member.service.MemberService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;


@Controller
@Slf4j
@RequestMapping("/account")
@RequiredArgsConstructor
public class ResetPasswordController {


    private final MemberService memberService;
    private final PasswordEncoder passwordEncoder;


    /**
     * 비밀번호 찾기 양식 화면으로 이동
     * @return 비밀번호 찾기 화면
     */
    @GetMapping("/searchPassword")
    public String searchPassword() {

        return "member/searchPasswordForm";

    }


    /**
     * 비밀번호 재설정 화면으로 이동
     * @param email 비밀번호 재설정 대상 아이디(email)
     * @param model 아이디 전달
     * @return 재설정 화면
     */
    @GetMapping("/resetPassword")
    public String resetPassword(String email, Model model) {

        model.addAttribute("email", email);

        return "member/resetPasswordForm";

    }


    /**
     * 비밀번호 재설정 적용
     * @param info 새로운 비밀번호, 적용 대상 아이디(email)
     * @param result 적용 데이터(비밀번호, 아이디) 유효성 검사 결과
     * @return 데이터 검증 실패 시 0, 성공 시 1
     */
    @PostMapping("/resetPassword")
    @ResponseBody
    public int resetPassword(@Valid ResetPasswordInfoDto info, BindingResult result) {


        if (result.hasErrors()) {

            return 0;

        } else {

            String encodePassword = passwordEncoder.encode(info.getPassword());

            memberService.updatePassword(info.getEmail(), encodePassword);

        }

        return 1;

    }

}
