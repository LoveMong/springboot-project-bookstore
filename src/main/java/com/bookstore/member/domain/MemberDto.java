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
    private String memberName;

    @NotEmpty
    @Email
    @Pattern(regexp = "\\w+@\\w+\\.\\w+(\\.\\w+)?", message = "이메일 형식이 아닙니다.")
    private String memberEmail;

    @NotEmpty
    @Length(min = 4, max = 12)
    private String memberPassword;

    private Date memberRegisterDate;

    private String role;

}
