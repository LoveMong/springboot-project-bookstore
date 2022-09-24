package com.bookstore.admin.domain;


import lombok.*;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotBlank;

@Builder
@Getter @Setter
@ToString
@NoArgsConstructor // 파라미터가 없는 기본 생성자 생성
@AllArgsConstructor // 필드 값을 파라미터로 받는 생성자 생성
public class BookDto {

    private int bookNum; // 도서 번호

    @NotBlank()
    @Length(max = 15)
    private String bookTitle; // 제목

    @NotBlank
    private int bookPrice; // 가격

    @NotBlank
    private String bookPublisher; // 출판사

    @NotBlank
    private String bookAuthor; // 작가

    @NotBlank
    private String bookPublishingDate; // 출판일

    @NotBlank
    private int bookCategory; // 카테고리

    @NotBlank
    private String bookContent; // 소개 내용

    private double bookGrade; // 평점

    private int bookStock; // 재고

    private String bookSearchPictureUrl; // 카카오 open api 이미지 url

    private String bookPictureUrl; // 사진 URL

    private String bookThumbUrl; // 사진 썸네일 URL


}
