package com.bookstore.mypage.domain;

import lombok.Data;

@Data
public class KaKaoPayApprovalDto {

    private String aid;
    private String tid;
    private String cid;
    private String sid;
    private String partner_order_id;
    private String partner_user_id;
    private String payment_method_type;
    private String item_name;
    private String item_code;
    private int quantity;
    private String created_at;
    private String approved_at;
    private String payload;
    private AmountDto amount;

}
