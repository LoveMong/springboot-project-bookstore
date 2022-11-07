package com.bookstore.mypage.mapper;


import com.bookstore.common.utils.SearchCondition;
import com.bookstore.mypage.domain.AddressDto;
import com.bookstore.mypage.domain.CartDto;
import com.bookstore.mypage.domain.OrderDto;
import com.bookstore.mypage.domain.PayInfoDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.security.core.parameters.P;

import java.util.List;

@Mapper
public interface OrderMapper {


    // 구매 예정 도서 정보 장바구니 저장
    int addCart(CartDto cartDto);

    // 장바구니 조회
    List<CartDto> readCartInfo(String memberEmail);

    // 장바구니 삭제
    int deleteCartInfo(int cartNum);

    // 도서 정보 검색
    CartDto searchBookByBookNum(int bookNum);

    // 기본 배송주소 정보 검색
    AddressDto searchMainAddressByMemberEmail(String memberEmail);

    // 추가된 배송주소 정보 검색
    List<AddressDto> searchAddedAddressByMemberEmail(String memberEmail);

    int registerAddress(AddressDto addressDto);

    // 기본 배송주소 수정
    int updateAddress(AddressDto addressDto);

    // 주문된 도서 정보
    void registerOrderInfo(OrderDto payInfo);

    // 도서 정보 수정(판매 수량, 재고)
    void updateBookInfo(OrderDto payInfo);

    // 고객 포인트 정보 수정
    void updateMemberPointInfo(PayInfoDto payInfo);

    // 포인트 사용 내역 등록
    void registerPointUse(PayInfoDto payInfo);

    // 사용 포인트의 합 출력
    int searchMemberPointSum(String memberEmail);

    // 고객 등급 수정
    void upgradeMemberRank(String memberEmail, String memberRank);

    List<OrderDto> searchMyOrderList(SearchCondition sc);

    int searchOrderResultCnt(SearchCondition sc);


}
