package com.bookstore.mypage.service;

import com.bookstore.mypage.domain.*;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

@Service
public class KaKaoPayService {


    /**
     * 결제 준비
     * @param payInfo 진행될 결제 정보
     * @return 결제 고유 번호, Redirect Url(사용자 정보 입력 화면)
     */
    public KaKaoPayReadyDto payReady(KakaoPayDto payInfo) {

        String memberEmail = payInfo.getMemberEmail(); // 고객 아이디(Email)
        String point = payInfo.getPointCharge(); // 충전할 포인트 금액(결제 금액과 1:1)

        // 카카오 단건 결제 api에서 필요한 필수 Request parameter
        MultiValueMap<String, String> parameters = new LinkedMultiValueMap<>();
        parameters.add("cid", "TC0ONETIME"); // 가맹점 코드 -> test 코드로 임의 입력
        parameters.add("partner_order_id", "ID"); // 가맹점 주문번호
        parameters.add("partner_user_id", memberEmail); // 가맹점 회원 id
        parameters.add("item_name", "point"); // 상품명
        parameters.add("quantity", "1"); // 상품 수량
        parameters.add("total_amount", point); // 상품 총액
        parameters.add("tax_free_amount", "0"); // 상품 비과세 금액
        parameters.add("approval_url", "http://localhost:8080/point/kakaoPaySuccess"); // 결제승인시 넘어갈 url
        parameters.add("cancel_url", "http://localhost:8080/point/charge"); // 결제취소시 넘어갈 url
        parameters.add("fail_url", "http://localhost:8080/point/charge"); // 결제 실패시 넘어갈 url

        HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<>(parameters, this.getHeaders());

        // 외부 url 요청 통로 열기.
        RestTemplate template = new RestTemplate();
        String url = "https://kapi.kakao.com/v1/payment/ready";

        return template.postForObject(url, requestEntity, KaKaoPayReadyDto.class);

    }


    /**
     * 결제승인 요청 메서드
     * @param tid 결제 고유 번호
     * @param pgToken 결제승인 요청을 인증하는 토큰
     * @param payInfoDto 진행될 결제 정보
     * @return 결제 성공 여부
     */
    public String payApprove(String tid, String pgToken, KakaoPayDto payInfoDto) {

        String memberEmail = payInfoDto.getMemberEmail();
        String resultConfirm = "SUCCESS";

        // request값 담기.
        MultiValueMap<String, String> parameters = new LinkedMultiValueMap<>();
        parameters.add("cid", "TC0ONETIME"); // 가맹점 코드
        parameters.add("tid", tid); // 결제 고유번호
        parameters.add("partner_order_id", "ID"); // 가맹점 주문번호, 결제 준비 API 요청과 일치해야 함
        parameters.add("partner_user_id", memberEmail); // 가맹점 회원 id, 결제 준비 API 요청과 일치해야 함
        parameters.add("pg_token", pgToken); // 결제승인 요청을 인증하는 토큰

        // 하나의 map안에 header와 parameter값을 담아줌.
        HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<>(parameters, this.getHeaders());

        // 외부url 통신
        RestTemplate template = new RestTemplate();
        String url = "https://kapi.kakao.com/v1/payment/approve";

        // 보낼 외부 url, 요청 메시지(header,parameter), 처리후 값을 받아올 클래스.
        // response로 결제 금액 정보, 걸제 상세 정보등 받아올 수 있다.
        try {
            template.postForObject(url, requestEntity, KaKaoPayApprovalDto.class);
        } catch (Exception e) {
            e.printStackTrace();
            resultConfirm = "FAIL";
        }

        return resultConfirm;
    }


    /**
     * header 설정
     * @return header
     */
    private HttpHeaders getHeaders() {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "KakaoAK 56cabbad77dd0cfa597781e5e910dba2");
        headers.set("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

        return headers;
    }
}

