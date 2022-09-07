package com.bookstore.common.validation;

import com.bookstore.member.domain.MemberDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import java.util.regex.Pattern;

/**
 * MemberDto 객체 검증 클래스
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

        String memberEmail = memberDto.getMemberEmail();
        String memberName = memberDto.getMemberName();
        String memberPassword = memberDto.getMemberPassword();


//      memberId가 null이거나 빈 문자열이면 memberId 필드에서 required 라는 error 코드 저장
//      if (member_id == null || "".equals(member_id.trim())) {
//         errors.rejectValue("member_id", "required", "id는 필수값 입니다.");
//      }



        if (idCheck(memberName)) {
            errors.rejectValue("memberName", "form", "아이디에 공백 또는 특스문자가 입력되었습니다.");
        }

//      회원 이름 유효성 검사
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "memberName", "required", "공백 오류");
        if (memberName.length() <= 1 || memberName.length() >= 10) {
            errors.rejectValue("memberName", "length", "이름 길이 오류");
        }


//      회원 비밀번호 유효성 검사
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "memberPassword", "required", "공백 오류");
        if (!pwdCheck(memberPassword)) {
            errors.rejectValue("memberPassword", "form", "비밀번호 형식 오류");
        }


//      회원 이메일 형식 검사
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "memberEmail", "required", "공백 오류");
        if (!emailCheck(memberEmail)) {
            errors.rejectValue("memberEmail", "form", "이메일 형식 오류");
        }



    }


    private boolean idCheck(String memberName) { // 이름에 공백 포함 시 false 반환
        return Pattern.matches("/\\s/g", memberName);
    }
    private boolean pwdCheck(String memberPassword) { // 비밀번호는 영문 대소문자와 숫자 4~12자리로 입력 아니면 false 반환
        return Pattern.matches("^[a-zA-z0-9]{4,12}$", memberPassword);
    }
    private boolean emailCheck(String memberEmail) { // 이메일 형식 검사 아니면 false 반환
        return Pattern.matches("\\w+@\\w+\\.\\w+(\\.\\w+)?", memberEmail);
    }

}
