package com.spring.minip.common.validation;

import com.spring.minip.member.domain.MemberDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import java.util.regex.Pattern;

/**
 * MemberDto 객체 검증 클래스
 *
 * @Project : spring-minip
 * @Date : 2022-06-21
 * @Author L
 */
@Slf4j
public class MemberValidator implements Validator {
//  (Interface)Validator : 데이터를 검증하기 위한 인터페이스

    /**
     * 매개변수로 들어온 클래스가 이 검증기로 검증가능한 객체인지 알려주는 메서드
     * @param clazz the {@link Class} that this {@link Validator} is
     * being asked if it can {@link #validate(Object, Errors) validate}
     * @return 매개변수의 객체가 MemberDto 타입일 경우에만 검증 가능(true 반환)
     */
    @Override
    public boolean supports(Class<?> clazz) {
//      return MemberDto.class.isAssignableFrom(clazz); clazz가 MemberDto 또는 그 자손인지 확인
        return MemberDto.class.equals(clazz);
    }

    /**
     * 객체를 검증하는 메서드
     * @param target the object that is to be validated (can be {@code null}) 검증할 객체
     * @param errors contextual state about the validation process (never {@code null}) 검증시 발생한 에러 저장소
     */
    @Override
    public void validate(Object target, Errors errors) {
        log.info("LocalValidator,validate() is called");

//      (Interface) Errors : 객체 전체에 대한 error를 저장(reject) 또는 필드(id, pwd)에 대한 error를 저장(rejectValue)
//      target은 MemberDto 타입으로 형변환, InstanceOf는 생략(위 supports 메서드에서 이미 확인)
        MemberDto memberDto = (MemberDto)target;

        String member_id = memberDto.getMember_id();
        String member_pwd = memberDto.getMember_pwd();
        String member_name = memberDto.getMember_name();
        String member_eamil = memberDto.getMember_email();


//      memberId가 null이거나 빈 문자열이면 memberId 필드에서 required 라는 error 코드 저장
//      if (member_id == null || "".equals(member_id.trim())) {
//         errors.rejectValue("member_id", "required", "id는 필수값 입니다.");
//      }


//      회원 아이디 유효성 검사
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "member_id", "required", "아이디를 입력해주세요.");
        if (member_id.length() < 4 || member_id.length() > 12) {
            errors.rejectValue("member_id", "length", "아이디의 길이는 4 ~ 12 사이로 입력해주세요.");
        }
        if (!idCheck(member_id)) {
            errors.rejectValue("member_id", "form", "아이디에 공백 또는 특스문자가 입력되었습니다.");
        }

//      회원 이름 유효성 검사
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "member_name", "required", "공백 오류");
        if (member_name.length() <= 1 || member_name.length() >= 10) {
            errors.rejectValue("member_name", "length", "이름 길이 오류");
        }


//      회원 비밀번호 유효성 검사
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "member_pwd", "required", "공백 오류");
        if (!pwdCheck(member_pwd)) {
            errors.rejectValue("member_pwd", "form", "비밀번호 형식 오류");
        }


//      회원 이메일 형식 검사
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "member_email", "required", "공백 오류");
        if (!emailCheck(member_eamil)) {
            errors.rejectValue("member_email", "form", "이메일 형식 오류");
        }



    }


    private boolean idCheck(String member_id) { // 아이디에 특수문자 포함 그리고 공백 또는 특수문자 포함 시 false 반환
        return Pattern.matches("^[0-9|a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣|\\s]*$", member_id) && Pattern.matches("^[0-9|a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]*$", member_id);
    }
    private boolean pwdCheck(String member_pwd) { // 비밀번호는 영문 대소문자와 숫자 4~12자리로 입력 아니면 false 반환
        return Pattern.matches("^[a-zA-z0-9]{4,12}$", member_pwd);
    }
    private boolean emailCheck(String member_email) { // 이메일 형식 검사 아니면 false 반환
        return Pattern.matches("\\w+@\\w+\\.\\w+(\\.\\w+)?", member_email);
    }

}
