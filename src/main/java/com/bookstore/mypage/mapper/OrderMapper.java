package com.bookstore.mypage.mapper;


import com.bookstore.mypage.domain.CartDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OrderMapper {


    // 구매 예정 도서 정보 장바구니 저장
    int addCart(CartDto cartDto);

}
