package com.bookstore.mypage.domain;


import lombok.*;

@Builder
@Getter @Setter
@ToString
@NoArgsConstructor // 파라미터가 없는 기본 생성자 생성
@AllArgsConstructor // 필드 값을 파라미터로 받는 생성자 생성
public class PointDto {

    private int pointNum; // 포인트 관리 번호
    private int pointCurrent; // 현재 포인트 잔액
    private String pointChangeDate; // 포인트 변화(증감)일시
    private int pointChange; // 충전/사용 된 포인트
    private int pointUse; // 결제된 포인트



}
