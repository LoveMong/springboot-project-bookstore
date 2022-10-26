package com.bookstore.mypage.domain;


import lombok.*;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Builder
@Getter @Setter
@ToString
@NoArgsConstructor // 파라미터가 없는 기본 생성자 생성
@AllArgsConstructor // 필드 값을 파라미터로 받는 생성자 생성
public class CartDto {


    private int cartNum;

    @NotBlank(message = "고객 아이디가 입력되지 않음")
    private String memberEmail;

    @NotNull(message = "도서 수량이 입력되지 않음")
    private int bookCount;

    @NotNull(message = "도서 번호가 입력되지 않음")
    private int bookNum;

    private String bookThumbUrl; // 도서 표지 썸네일 URL
    private String bookTitle; // 도서 제목
    private int bookPrice; // 도서 가격


}
