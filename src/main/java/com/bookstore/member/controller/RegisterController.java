package com.bookstore.member.controller;

import com.bookstore.member.domain.MemberDto;
import com.bookstore.member.service.EmailService;
import com.bookstore.member.service.MemberService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.validation.Valid;


/**
 * 회원가입 기능 컨트롤을 위한 클래스
 *
 * @author L
 */
@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/account")
public class RegisterController {

    private final MemberService memberService;
    private final EmailService emailService;
    private final PasswordEncoder passwordEncoder;


    /**
     * 회원가입 양식 화면으로 이동하는 메소드
     * @return 회원가입 양식 화면
     */
    @GetMapping("/sign-up")
    public String joinForm() {
        return "/member/joinForm";
    }


    /**
     * 회원가입 처리(ajax) 메소드(입력받은 회원정보 유효성 검사 후 DB 저장)
     *
     * @param memberDto 입력받은 회원정보 객체(아이디, 이름, 비밀번호 등)
     * @param bindingResult 객체 바인딩 처리시 결과(error) 정보
     * @return ajaxResult 회원가입 실패 시 0 반환(Binding Error), 성공 시 1 반환
     * @throws Exception
     */
    @PostMapping("/sign-up")
    @ResponseBody
    public int joinMember(@Valid MemberDto memberDto,
                          BindingResult bindingResult) throws Exception {

        int joinSuccessResult = 0;

        if (bindingResult.hasErrors()) {
            log.info("bindingResult : " + bindingResult);
            return joinSuccessResult;
        } else {
            String encodePassword = passwordEncoder.encode(memberDto.getMemberPassword());
            memberDto.setMemberPassword(encodePassword);
            memberService.createMember(memberDto);
            joinSuccessResult = 1;
        }

        return joinSuccessResult;

    }


    /**
     * 가입 메일주소 중복 확인(Ajax)
     *
     * @param mail 확인 대상 메일주소
     * @return 1: 사용가능한 메일주소 / 0: 이미 존재하는 메일주소
     */
    @GetMapping("/mailCheck")
    @ResponseBody
    public int mailCheck(String mail) throws NullPointerException {

        MemberDto member = memberService.selectMemberByEmail(mail);

        return member == null ? 1 : 0;

    }


    /**
     * 메일 인증에 필요한 인증번호 생성(Ajax)
     *
     * @param mail 생성된 인증번호을 수신할 메일주소
     * @return 인증번호 반환
     * @throws Exception
     */
    @GetMapping("/sendAuthKey")
    @ResponseBody
    public int sendAuthkey(String mail) throws Exception {

        return emailService.mailCheck(mail);

    }

}
