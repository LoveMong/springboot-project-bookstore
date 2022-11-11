package com.bookstore.mypage.domain;

import lombok.Data;

@Data
public class AmountDto {

    private int total;
    private int tax_free;
    private int vat;
    private int point;
    private int discount;

}
