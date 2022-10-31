package com.bookstore.mypage.domain;


import lombok.*;

@Builder
@Getter @Setter
@ToString
@NoArgsConstructor // 파라미터가 없는 기본 생성자 생성
@AllArgsConstructor // 필드 값을 파라미터로 받는 생성자 생성
public class AddressDto {

    private int addressNum; // 주소 고유 번호
    private String memberEmail;	//등록한 주소의 아이디
    private String receiverAddress;	// 수령인 주소
    private String receiverName; // 수령인 이름
    private String receiverPhone; // 수령인 연락처
    private String addressCheckMain; // 기본 배송지(MAIN)/ 추가 배송지(ADDITION) 구분

}
