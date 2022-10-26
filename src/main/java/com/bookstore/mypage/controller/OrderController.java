package com.bookstore.mypage.controller;


import com.bookstore.mypage.domain.CartDto;
import com.bookstore.mypage.service.OrderService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.validation.Valid;

/**
 * 도서 주문 관련 기능을 위한 컨트롤러
 * @author L
 */
@Controller
@RequestMapping("/order")
@RequiredArgsConstructor
@Slf4j
public class OrderController {


    private final OrderService orderService;


    /**
     * 구매 예정 도서 정보 장바구니 저장
     * @param cartDto 해당 도서 번호, 수량 등 정보
     * @param result 장바구니 정보 유효성 검사 결과를 담은 객체
     * @return 장바구니 등록 성고 여부 정보
     */
    @PostMapping("/addCart")
    @ResponseBody
    public String addCart(@Valid CartDto cartDto, BindingResult result) {

        String resultConfirm;

        if (result.hasErrors()) {
            resultConfirm = "등록 실패";
            return resultConfirm;
        } else {
            try {
                if (orderService.addCart(cartDto) != 1) {
                    throw new Exception("ADD_FAILED");
                } else {
                    resultConfirm = "등록 성공";
                }
            } catch (Exception e) {
                e.printStackTrace();
                resultConfirm = "등록 실패";
                return resultConfirm;
            }
        }

        return resultConfirm;

    }
}
