package com.bookstore.mypage.domain;


import lombok.*;

import java.util.List;

@Builder
@Getter @Setter
@ToString
@NoArgsConstructor // 파라미터가 없는 기본 생성자 생성
@AllArgsConstructor // 필드 값을 파라미터로 받는 생성자 생성
public class PayInfoDto {

    private List<CartDto> payInfoBook;

    private String orderNumber; // 주문번호
    private String memberEmail;
    private String memberRank;
    private int memberPoint;
    private int orderTotalPrice;
    private int orderTotalBookCount;

    private String receiverAddress;
    private String receiverName;
    private String receiverPhone;


}
