package com.bookstore.mypage.mapper;


import com.bookstore.mypage.domain.AddressDto;
import com.bookstore.mypage.domain.CartDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface OrderMapper {


    // 구매 예정 도서 정보 장바구니 저장
    int addCart(CartDto cartDto);

    // 장바구니 조회
    List<CartDto> readCartInfo(String memberEmail);

    // 장바구니 삭제
    int deleteCartInfo(int cartNum);

    CartDto searchBookByBookNum(int bookNum);

    List<AddressDto> searchAddressByMemberEmail(String memberEmail);

}
