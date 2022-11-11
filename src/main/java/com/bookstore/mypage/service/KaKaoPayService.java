package com.bookstore.mypage.service;

import com.bookstore.mypage.domain.KaKaoPayApprovalDto;
import com.bookstore.mypage.domain.KaKaoPayReadyDto;
import com.bookstore.mypage.domain.KakaoPayDto;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

@Service
public class KaKaoPayService {


    public KaKaoPayReadyDto payReady(KakaoPayDto payInfo) {

        String memberEmail = payInfo.getMemberEmail();
        String point = payInfo.getPointCharge();


        // 카카오가 요구한 결제요청request값을 담아줍니다.
        MultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
        parameters.add("cid", "TC0ONETIME");
        parameters.add("partner_order_id", "ID");
        parameters.add("partner_user_id", memberEmail);
        parameters.add("item_name", "point");
        parameters.add("quantity", "1");
        parameters.add("total_amount", point);
        parameters.add("tax_free_amount", "0");
        parameters.add("approval_url", "http://localhost:8080/point/kakaoPaySuccess"); // 결제승인시 넘어갈 url
        parameters.add("cancel_url", "http://localhost/order/pay/cancel"); // 결제취소시 넘어갈 url
        parameters.add("fail_url", "http://localhost/order/pay/fail"); // 결제 실패시 넘어갈 url

        HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<>(parameters, this.getHeaders());
        // 외부url요청 통로 열기.
        RestTemplate template = new RestTemplate();
        String url = "https://kapi.kakao.com/v1/payment/ready";
        // template으로 값을 보내고 받아온 ReadyResponse값 readyResponse에 저장.
        KaKaoPayReadyDto kakaoPayResponse = template.postForObject(url, requestEntity, KaKaoPayReadyDto.class);
        // 받아온 값 return
        return kakaoPayResponse;
    }

    // 결제 승인요청 메서드
    public KaKaoPayApprovalDto payApprove(String tid, String pgToken) {

        // request값 담기.
        MultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
        parameters.add("cid", "TC0ONETIME");
        parameters.add("tid", tid);
        parameters.add("partner_order_id", "order_id"); // 주문명
        parameters.add("partner_user_id", "회사명");
        parameters.add("pg_token", pgToken);

        // 하나의 map안에 header와 parameter값을 담아줌.
        HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<>(parameters, this.getHeaders());

        // 외부url 통신
        RestTemplate template = new RestTemplate();
        String url = "https://kapi.kakao.com/v1/payment/approve";
        // 보낼 외부 url, 요청 메시지(header,parameter), 처리후 값을 받아올 클래스.
        KaKaoPayApprovalDto approveResponse = template.postForObject(url, requestEntity, KaKaoPayApprovalDto.class);

        return approveResponse;
    }
    // header() 셋팅
    private HttpHeaders getHeaders() {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "56cabbad77dd0cfa597781e5e910dba2");
        headers.set("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

        return headers;
    }
}

