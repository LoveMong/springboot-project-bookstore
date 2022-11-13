package com.bookstore.admin.controller;

import com.bookstore.admin.service.AdminService;
import com.bookstore.common.utils.PageHandler;
import com.bookstore.common.utils.SearchCondition;
import com.bookstore.member.domain.MemberDto;
import com.bookstore.member.domain.PrincipalDetails;
import com.bookstore.member.service.MemberService;
import com.bookstore.mypage.domain.OrderDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
@Slf4j
public class OrderManagementController {

    private final AdminService adminService;

    private final MemberService memberService;


    @GetMapping("/orderList")
    public String myOrders(SearchCondition sc, Model model, @AuthenticationPrincipal PrincipalDetails principalDetails) {

        String memberEmail = principalDetails.getMemberDto().getMemberEmail();
        MemberDto memberDto = memberService.selectMemberByEmail(memberEmail);

        try {
            int totalCnt = adminService.searchOrderListResultCnt(sc);
            PageHandler pageHandler = new PageHandler(totalCnt, sc);
            List<OrderDto> orderList = adminService.searchOrderList(sc);

            model.addAttribute("orderList", orderList);
            model.addAttribute("pageHandler", pageHandler);
            model.addAttribute("memberInfo", memberDto);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("totalCnt", 0);
        }
        return "/admin/orderList";
    }

}
