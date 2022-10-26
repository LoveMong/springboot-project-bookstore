package com.bookstore.mypage.service;

import com.bookstore.mypage.domain.CartDto;
import com.bookstore.mypage.mapper.OrderMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderMapper orderMapper;


    /**
     * 구매 예정 도서 정보 장바구니 저장
     * @param cartDto 해당 도서 정보
     * @return 저장 성공 시 1 반환
     */
    public int addCart(CartDto cartDto) {
        return orderMapper.addCart(cartDto);
    }


}
