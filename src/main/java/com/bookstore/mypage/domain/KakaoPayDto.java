package com.bookstore.mypage.domain;


import lombok.Data;

@Data
public class KakaoPayDto {

    private String memberEmail;
    private String pointCharge;
    private String pointCurrent;

}
