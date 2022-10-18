package com.bookstore.admin.domain;


import lombok.*;

import javax.validation.constraints.*;

@Builder
@Getter @Setter
@ToString
@NoArgsConstructor // 파라미터가 없는 기본 생성자 생성
@AllArgsConstructor // 필드 값을 파라미터로 받는 생성자 생성
public class BookDto {

    private int bookNum; // 도서 번호

    @NotBlank(message = "제목을 입력해주세요.")
    @Size(min = 1, max = 100, message = "1~100 사이의 입력 길이만 허용합니다.")
    private String bookTitle; // 제목

    @NotNull(message = "가격을 입력해주세요.")
    @PositiveOrZero(message = "숫자 입력만 가능합니다.")
    private int bookPrice; // 가격

    @NotBlank(message = "출판사를 입력해주세요.")
    @Size(min = 1, max = 30, message = "1~30 사이의 입력 길이만 허용합니다.")
    private String bookPublisher; // 출판사

    @NotBlank(message = "작가를 입력해주세요.")
    @Size(min = 1, max = 30, message = "1~30 사이의 입력 길이만 허용합니다.")
    private String bookAuthor; // 작가

    @NotBlank
    @Pattern(regexp = "^(19|20)\\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$", message = "yyyy-mm-dd 형식으로 입력해주세요.")
    private String bookPublishingDate; // 출판일

    @NotNull(message = "카테고리를 입력해주세요.")
    private int bookCategory; // 카테고리

    @NotBlank(message = "도서 소개 내용을 입력해주세요.")
    private String bookContent; // 소개 내용

    private double bookGrade; // 평점

    @NotNull(message = "재고를 입력해주세요.")
    @PositiveOrZero(message = "숫자 입력만 가능합니다.")
    private int bookStock; // 재고

    private String bookSearchPictureUrl; // 카카오 open api 이미지 url

    private String bookPictureUrl; // 사진 URL

    private String bookThumbUrl; // 사진 썸네일 URL


}
