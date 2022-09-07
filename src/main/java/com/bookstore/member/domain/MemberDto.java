package com.bookstore.member.domain;


import lombok.*;

import javax.validation.constraints.NotBlank;
import java.util.Date;

@Builder
@Getter @Setter
@ToString
@NoArgsConstructor // 파라미터가 없는 기본 생성자 생성
@AllArgsConstructor // 필드 값을 파라미터로 받는 생성자 생성
public class MemberDto {

    @NotBlank
    private String memberName;

    private String memberEmail;

    private String memberPassword;

    private Date memberRegisterDate;

    private String role;

}
