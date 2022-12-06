package com.bookstore.mypage.controller;


import com.bookstore.common.utils.PageHandler;
import com.bookstore.common.utils.SearchCondition;
import com.bookstore.member.domain.MemberDto;
import com.bookstore.member.domain.PrincipalDetails;
import com.bookstore.member.service.MemberService;
import com.bookstore.mypage.domain.AddressDto;
import com.bookstore.mypage.domain.CartDto;
import com.bookstore.mypage.domain.OrderDto;
import com.bookstore.mypage.domain.PayInfoDto;
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

    private final MemberService memberService;


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
     * 장바구니 조회
     *
     * @param model            장바구니에 담긴 도서 정보 리스트
     * @param principalDetails 로그인된 고객 정보
     * @return 장바구니 화면
     */
    @GetMapping("/cart")
    public String cart(Model model, @AuthenticationPrincipal PrincipalDetails principalDetails) {

        String memberEmail = principalDetails.getMemberDto().getMemberEmail();

        List<CartDto> cartList = orderService.readCartInfo(memberEmail);
        MemberDto memberDto = memberService.selectMemberByEmail(memberEmail);

        model.addAttribute("memberInfo", memberDto);
        model.addAttribute("cartList", cartList);

        return "/mypage/cart";

    }


    /**
     * 장바구니 내 선택품목 삭제
     *
     * @param list 선택 품목(도서 번호) 리스트
     * @return 삭제 성공 여부
     */
    @PostMapping("/deleteCart")
    @ResponseBody
    public String deleteCart(@RequestParam("selectNum") List<Integer> list) throws Exception {

        String resultConfirm = "삭제 성공";

        try {
            orderService.deleteCartInfo(list);
        } catch (Exception e) {
            e.printStackTrace();
            resultConfirm = "삭제 실패";
        }

        return resultConfirm;

    }


    /**
     * 결제 정보 확인 및 진행 페이지로 이동
     *
     * @param order            장바구니 내 도서 정보 리스트
     * @param model            고객 배송주소지 정보 및 결제 예정 도서 정보
     * @param principalDetails 로그인된 고객 정보
     * @return 결제 진행 페이지 화면
     */
    @PostMapping("/payInfo")
    public String payInfo(@ModelAttribute(value = "OrderDto") OrderDto order, Model model,
                          @AuthenticationPrincipal PrincipalDetails principalDetails) {

        String memberEmail = principalDetails.getMemberDto().getMemberEmail();

        MemberDto memberDto = memberService.selectMemberByEmail(memberEmail);
        AddressDto mainAddress = orderService.searchMainAddressByMemberEmail(memberEmail); // 메인 배송주소 검색
        List<AddressDto> addedAddressList = orderService.searchAddedAddressByMemberEmail(memberEmail); // 추가된 배송주소 검색
        List<CartDto> cartInfoList = orderService.makeCartInfoList(order);


        model.addAttribute("memberInfo", memberDto);
        model.addAttribute("mainAddress", mainAddress);
        model.addAttribute("addedAddress", addedAddressList);
        model.addAttribute("list", cartInfoList);

        return "/mypage/payment";

    }

    /**
     * 바로결제 진행 시 정보 확인 및 결제 페이지로 이동
     *
     * @param order            도서 정보 리스트
     * @param model            고객 배송주소지 정보 및 결제 예정 도서 정보
     * @return 결제 진행 페이지 화면
     */
    @PostMapping("/payInfoDirect")
    public String payInfoDirect(CartDto order, Model model) {

        log.info("order : " + order);

        String memberEmail = order.getMemberEmail();

        MemberDto memberDto = memberService.selectMemberByEmail(memberEmail);
        AddressDto mainAddress = orderService.searchMainAddressByMemberEmail(memberEmail); // 메인 배송주소 검색
        List<AddressDto> addedAddressList = orderService.searchAddedAddressByMemberEmail(memberEmail); // 추가된 배송주소 검색
        List<CartDto> cartInfoList = new ArrayList<>();
        cartInfoList.add(order);


        model.addAttribute("memberInfo", memberDto);
        model.addAttribute("mainAddress", mainAddress);
        model.addAttribute("addedAddress", addedAddressList);
        model.addAttribute("list", cartInfoList);

        return "/mypage/payment";

    }


    /**
     * 주소 등록(기본 배송지 / 추가 배송지)
     *
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
     *
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


    /**
     * 도서 상품 결제 진행
     *
     * @param payInfoDto 도서 및 결제 정보
     * @param model 도서 결제 정보
     * @return 주문 내역 화면
     */
    @PostMapping("/payment")
    public String payment(@ModelAttribute(value = "PayInfoDto") PayInfoDto payInfoDto, Model model) throws Exception {

        orderService.proceedPayment(payInfoDto);

        model.addAttribute("payInfo", payInfoDto);

        return "/mypage/orderComplete";

    }


    /**
     * 주문 내역 확인
     *
     * @param sc               주문내역 페이징 처리 및 검색 조건
     * @param model            주문내역 리스트, 페이징 설정 등
     * @param principalDetails 로그인된 고객정보
     * @return 주문내역 화면
     */
    @GetMapping("/myOrders")
    public String myOrders(SearchCondition sc, Model model, @AuthenticationPrincipal PrincipalDetails principalDetails) {

        String memberEmail = principalDetails.getMemberDto().getMemberEmail();
        MemberDto memberDto = memberService.selectMemberByEmail(memberEmail);
        sc.setMemberEmail(memberEmail);

        model.addAttribute("memberInfo", memberDto);

        try {
            int totalCnt = orderService.searchOrderResultCnt(sc);
            PageHandler pageHandler = new PageHandler(totalCnt, sc);
            List<OrderDto> orderList = orderService.searchMyOrderList(sc);

            model.addAttribute("myOrderList", orderList);
            model.addAttribute("pageHandler", pageHandler);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("totalCnt", 0);
        }
        return "/mypage/order";
    }


    /**
     * 주문내역 상세 보기
     * @param orderNumber 주문 번호
     * @param model 결제 정보, 구매 도서 정보
     * @param sc 검색 조건
     * @return 주문내역 상세 화면
     */
    @GetMapping("/orderDetail")
    public String orderDetail(@RequestParam("num") String orderNumber, SearchCondition sc, Model model,
                              @AuthenticationPrincipal PrincipalDetails principalDetails) {

        if (principalDetails != null) {
            String memberEmail = principalDetails.getMemberDto().getMemberEmail();
            MemberDto memberDto = memberService.selectMemberByEmail(memberEmail);

            model.addAttribute("memberInfo", memberDto);
        }

        List<PayInfoDto> orderDetail = orderService.searchOrderDetail(orderNumber); // 결제 정보
        List<CartDto> searchOrderDetailBookInfo = orderService.searchOrderDetailBookInfo(orderNumber); // 구매 도서 정보

        model.addAttribute("bookInfoList", searchOrderDetailBookInfo);
        model.addAttribute("orderDetail", orderDetail);
        model.addAttribute("searchCondition", sc);

        return "/mypage/orderDetail";
    }

}
