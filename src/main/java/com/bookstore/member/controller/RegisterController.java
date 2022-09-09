package com.bookstore.member.controller;

import com.bookstore.common.validation.MemberValidator;
import com.bookstore.member.domain.MemberDto;
import com.bookstore.member.service.MemberService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;


/**
 * 회원가입 기능 컨트롤을 위한 클래스
 * @author L
 */

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/account")
public class RegisterController {

    private final MemberService memberService;

    private final PasswordEncoder passwordEncoder;


    /**
     * 해당 Controler로 들어오는 요청에 대한 추가적인 설정 메소드
     * @param binder validator 설정을 위한 매개변수
     */
//    @InitBinder // 특정 컨트롤러에서 바인딩 또는 검증 설정 변경
//    public void initBinder(WebDataBinder binder) {
//        binder.setValidator(new MemberValidator()); // MemberValidator를 로컬 validator로 등록(Controller 내에서만 사용 가능)
//    }


    /**
     * 회원가입 양식 화면으로 이동하는 메소드
     * @return 회원가입 양식 화면
     */
    @GetMapping("/sign-up")
    public String joinForm() {
        return "/member/joinForm";
    }


    /**
     *
     */
    @PostMapping("/sign-up")
    @ResponseBody
    public int joinMember(@Valid MemberDto memberDto,
                             BindingResult bindingResult,
                             Model model) throws Exception {

        int joinSuccessResult = 0;

        if (bindingResult.hasErrors()) {
            log.info("bindingResult : " + bindingResult);
            return joinSuccessResult;
        } else {
            String pwdBcrypt = passwordEncoder.encode(memberDto.getMemberPassword());
            memberDto.setMemberPassword(pwdBcrypt);
            memberService.createMember(memberDto);
            joinSuccessResult = 1;
        }

        return joinSuccessResult;

    }
}
