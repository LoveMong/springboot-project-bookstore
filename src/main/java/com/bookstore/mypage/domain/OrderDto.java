package com.bookstore.mypage.domain;

import lombok.Data;

import java.util.List;

@Data
public class OrderDto {

    private List<CartDto> cartInfoList;

    private int orderNum; // 주문 번호
    private String orderDate; // 주문일
    private int orderState; // 주문 상태(배송 상태)
    private int bookNum; // 도서 번호
    private int bookOrderCount; // 도서 주문 수량
    private String memberEmail; // 고객 아이디
    private String memberAddress; // 고객 주소

//    private int orderTotalPrice;   // 도서 구매 합계 금액
//    private int bookSalePrice; // 도서 판매 금액

}
