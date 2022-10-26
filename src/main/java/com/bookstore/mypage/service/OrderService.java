package com.bookstore.mypage.service;

import com.bookstore.member.domain.MemberDto;
import com.bookstore.mypage.domain.CartDto;
import com.bookstore.mypage.mapper.OrderMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.naming.ldap.SortResponseControl;
import java.util.List;

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


    /**
     * 장바구니 조회
     * @param memberEmail 고객 이메일(아이디)
     * @return 장바구니에 담긴 품목 리스트
     */
    public List<CartDto> readCartInfo(String memberEmail) {
        return orderMapper.readCartInfo(memberEmail);
    }


    /**
     * 장바구니 선택된 품목 삭제
     * @param cartNum 품목 번호
     * @return 삭제 성공 여부(성공 시 1 반환)
     */
    public int deleteCartInfo(int cartNum) {
        return orderMapper.deleteCartInfo(cartNum);
    }


}
