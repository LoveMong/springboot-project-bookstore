package com.bookstore.admin.domain;


import lombok.*;

@Builder
@Getter @Setter
@ToString
@NoArgsConstructor // 파라미터가 없는 기본 생성자 생성
@AllArgsConstructor // 필드 값을 파라미터로 받는 생성자 생성
public class BookDto {

    private int bookNum; // 도서 번호
    private String bookTitle; // 제목
    private int bookPrice; // 가격
    private String bookPublisher; // 출판사
    private String bookAuthor; // 작가
    private String bookPublishingDate; // 출판일
    private int bookCategory; // 카테고리
    private double bookGrade; // 평점
    private int bookStock; // 재고
    private String bookSearchPictureUrl;
    private String bookPictureUrl; // 사진 URL
    private String bookThumbUrl; // 사진 썸네일 URL


}
