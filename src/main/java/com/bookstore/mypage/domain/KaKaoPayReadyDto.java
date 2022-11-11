package com.bookstore.mypage.domain;

import lombok.Data;

@Data
public class KaKaoPayReadyDto {

    private String tid;
    private String next_redirect_pc_url;

}
