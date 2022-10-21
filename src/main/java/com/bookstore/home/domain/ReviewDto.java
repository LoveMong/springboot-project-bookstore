package com.bookstore.home.domain;


import lombok.*;

@Builder
@Getter
@Setter
@ToString
@NoArgsConstructor // 파라미터가 없는 기본 생성자 생성
@AllArgsConstructor // 필드 값을 파라미터로 받는 생성자 생성
public class ReviewDto {

    private int reviewNum;

    private double reviewGrade;

    private String memberEmail;

    private int bookNum;

    private String reviewComment;

    private String reviewDate;


}
