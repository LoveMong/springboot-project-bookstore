package com.bookstore.member.domain;


import lombok.*;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import java.util.Date;

@Builder
@Getter @Setter
@ToString
@NoArgsConstructor // 파라미터가 없는 기본 생성자 생성
@AllArgsConstructor // 필드 값을 파라미터로 받는 생성자 생성
public class MemberDto {

    @NotBlank
    @Length(min = 2, max = 10)
    private String memberName; // 회원 이름

    @NotEmpty
    @Email
    @Pattern(regexp = "\\w+@\\w+\\.\\w+(\\.\\w+)?", message = "이메일 형식이 아닙니다.")
    private String memberEmail; // 회원 아이디(Email)

    @NotEmpty
    @Pattern(regexp = "(?=.*[0-9])(?=.*[a-zA-Z])(?=.*\\W)(?=\\S+$).{8,16}", message = "비밀번호는 8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.")
    private String memberPassword; // 회원 비밀번호

    private String memberRank; // 회원 등급

    private int memberPoint; // 회원 포인트

    private Date memberRegisterDate; // 회원 가입일

    private String memberRole; // 일반 or 관리자



}
