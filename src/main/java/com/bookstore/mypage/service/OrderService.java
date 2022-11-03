package com.bookstore.mypage.service;

import com.bookstore.admin.domain.BookDto;
import com.bookstore.home.mapper.HomeMapper;
import com.bookstore.mypage.domain.AddressDto;
import com.bookstore.mypage.domain.CartDto;
import com.bookstore.mypage.domain.OrderDto;
import com.bookstore.mypage.mapper.OrderMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderMapper orderMapper;

    private final HomeMapper homeMapper;


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

        List<CartDto> cartList = orderMapper.readCartInfo(memberEmail);

        for (int i = 0; i < cartList.size(); i++) {

            int boonNum = cartList.get(i).getBookNum();

            BookDto bookInfo = homeMapper.bookSearchDetail(boonNum);

            cartList.get(i).setBookTitle(bookInfo.getBookTitle());
            cartList.get(i).setBookPrice(bookInfo.getBookPrice());
            cartList.get(i).setBookThumbUrl(bookInfo.getBookThumbUrl());

        }
        return cartList;
    }


    /**
     * 장바구니 선택된 품목 삭제
     * @param list
     * @return
     * @throws Exception
     */
    @Transactional(rollbackFor = Exception.class)
    public void deleteCartInfo(List<Integer> list) throws Exception {

        for (int num : list) {

            if (orderMapper.deleteCartInfo(num) != 1) {
                throw new Exception("DEL_ERR");
            }

        }
    }


    /**
     * 도서 정보 검색
     * @param bookNum 해당 도서 번호
     * @return 도서 정보
     */
    public CartDto searchBookByBookNum(int bookNum) {
        return orderMapper.searchBookByBookNum(bookNum);
    }


    /**
     * 장바구니의 도서 중 구매 선택된 도서 정보 확인
     * @param order 장바구니에 담긴 도서 정보(도서이름, 판매가, 구매 수량 등)
     * @return 도서 정보 리스트
     */
    public List<CartDto> makeCartInfoList(OrderDto order) {

        List<CartDto> cartInfoList = new ArrayList<>();

        for (int i = 0; i < order.getCartInfoList().size(); i++) {

            String checkBox = order.getCartInfoList().get(i).getCheckBox();

            if (checkBox != null) {

                int bookNum = order.getCartInfoList().get(i).getBookNum();

                CartDto cartInfo = orderMapper.searchBookByBookNum(bookNum);
                cartInfo.setBookOrderCount(order.getCartInfoList().get(i).getBookOrderCount());
                cartInfo.setCartNum(order.getCartInfoList().get(i).getCartNum());

                cartInfoList.add(cartInfo);

            }

        }

        return cartInfoList;

    }


    /**
     * 기본 배송주소 정보 검색
     * @param memberEmail 고객 아이디(이메일)
     * @return 등록된 주소리스트
     */
    public AddressDto searchMainAddressByMemberEmail(String memberEmail) {
        return orderMapper.searchMainAddressByMemberEmail(memberEmail);
    }


    /**
     * 추가된 배송주소 정보 검색
     * @param memberEmail 고객 아이디(이메일)
     * @return 등록된 주소리스트
     */
    public List<AddressDto> searchAddedAddressByMemberEmail(String memberEmail) {
        return orderMapper.searchAddedAddressByMemberEmail(memberEmail);
    }

    public int registerAddress(AddressDto addressDto) {

        return orderMapper.registerAddress(addressDto);
    }


    /**
     * 기본 배송주소 수정
     * @param addressDto 수정할 주소 정보
     * @return 수정 성공 여부
     */
    public int updateAddress(AddressDto addressDto) {

        return orderMapper.updateAddress(addressDto);
    }



}
