package com.bookstore.mypage.controller;


import com.bookstore.admin.domain.BookDto;
import com.bookstore.home.service.HomeService;
import com.bookstore.member.domain.PrincipalDetails;
import com.bookstore.mypage.domain.AddressDto;
import com.bookstore.mypage.domain.CartDto;
import com.bookstore.mypage.domain.OrderDto;
import com.bookstore.mypage.service.OrderService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;

/**
 * 도서 주문 관련 기능을 위한 컨트롤러
 *
 * @author L
 */
@Controller
@RequestMapping("/order")
@RequiredArgsConstructor
@Slf4j
public class OrderController {


    private final OrderService orderService;

    private final HomeService homeService;


    /**
     * 구매 예정 도서 정보 장바구니 저장
     *
     * @param cartDto 해당 도서 번호, 수량 등 정보
     * @param result  장바구니 정보 유효성 검사 결과를 담은 객체
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


    /**
     *
     * @param model
     * @param principalDetails
     * @return
     */
    @GetMapping("/cart")
    public String cart(Model model, @AuthenticationPrincipal PrincipalDetails principalDetails) {

        log.info("memberEmail : " + principalDetails.getMemberDto().getMemberEmail());

        List<CartDto> cartList = orderService.readCartInfo(principalDetails.getMemberDto().getMemberEmail());

        for (int i = 0; i < cartList.size(); i++) {

            int boonNum = cartList.get(i).getBookNum();

            BookDto bookInfo = homeService.bookSearchDetail(boonNum);

            cartList.get(i).setBookTitle(bookInfo.getBookTitle());
            cartList.get(i).setBookPrice(bookInfo.getBookPrice());
            cartList.get(i).setBookThumbUrl(bookInfo.getBookThumbUrl());

        }

        model.addAttribute("cartList", cartList);

        return "/mypage/cart";

    }


    /**
     * 장바구니 내 선택품목 삭제
     * @param list
     * @return
     */
    @PostMapping("/deleteCart")
    @ResponseBody
    public String deleteCart(@RequestParam("selectNum") List<Integer> list) {

        log.info("list : " + list);

        String resultConfirm = "";

        for (int num : list) {

            try {
                if (orderService.deleteCartInfo(num) != 1) {
                    throw new Exception("DEL_ERR");
                } else {
                    resultConfirm = "삭제 성공";
                }
            } catch (Exception e) {
                e.printStackTrace();
                resultConfirm = "삭제 실패";
            }

        }

        return resultConfirm;

    }


    /**
     * 결제 정보 확인 및 진행 페이지로 이동
     * @param order 장바구니 내 주문 선택 품목 정보 리스트
     * @param model 고객 배송주소지 정보 및 결제 예정 도서 정보
     * @param principalDetails 로그인된 고객 정보
     * @return 결제 진행 페이지 화면
     */
    @PostMapping("/payInfo")
    public String payInfo(@ModelAttribute(value = "OrderDto") OrderDto order, Model model,
                          @AuthenticationPrincipal PrincipalDetails principalDetails) {


        String memberEmail = principalDetails.getMemberDto().getMemberEmail();

        AddressDto mainAddress = orderService.searchMainAddressByMemberEmail(memberEmail); // 메인 배송주소 검색
        List<AddressDto> addedAddressList = orderService.searchAddedAddressByMemberEmail(memberEmail); // 추가된 배송주소 검색

        List<CartDto> cartInfoList = new ArrayList<>();

        for (int i = 0; i < order.getCartInfoList().size(); i++) {

            String checkBox = order.getCartInfoList().get(i).getCheckBox();

            if (checkBox != null) {

                int bookNum = order.getCartInfoList().get(i).getBookNum();

                CartDto cartInfo = orderService.searchBookByBookNum(bookNum);
                cartInfo.setBookOrderCount(order.getCartInfoList().get(i).getBookOrderCount());
                cartInfo.setCartNum(order.getCartInfoList().get(i).getCartNum());

                cartInfoList.add(cartInfo);

            }

        }

        model.addAttribute("mainAddress", mainAddress);
        model.addAttribute("addedAddress", addedAddressList);
        model.addAttribute("list", cartInfoList);

        return "/mypage/payment";

    }


    /**
     * 주소 등록(기본 배송지 / 추가 배송지)
     * @param addressDto 등록할 배송주소 정보
     * @return 등록 성공 여부
     */
    @PostMapping("registerAddress")
    @ResponseBody
    public String registerAddress(AddressDto addressDto) {

        String resultConfirm = "등록 성공";

        try {
            if (orderService.registerAddress(addressDto) != 1) {
                throw new Exception("failed register");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resultConfirm = "등록 실패";
        }

        return resultConfirm;

    }


    /**
     * 기본 배송주소 수정
     * @param addressDto 수정할 주소 정보
     * @return 수정 성공 여부
     */
    @PostMapping("updateAddress")
    @ResponseBody
    public String updateAddress(AddressDto addressDto) {

        String resultConfirm = "수정 성공";

        try {
            if (orderService.updateAddress(addressDto) != 1) {
                throw new Exception("failed update");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resultConfirm = "수정 실패";
        }

        return resultConfirm;

    }

}
