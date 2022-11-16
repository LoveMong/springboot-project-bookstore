package com.bookstore.admin.controller;

import com.bookstore.admin.service.AdminService;
import com.bookstore.common.utils.PageHandler;
import com.bookstore.common.utils.SearchCondition;
import com.bookstore.mypage.domain.OrderDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 주문목록 관리를 위한 컨트롤러
 *
 * @author L
 */
@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
@Slf4j
public class OrderManagementController {

    private final AdminService adminService;


    /**
     * 주문목록 리스트 출력
     * @param sc 검색 조건
     * @param model 주문목록, 검색조건
     * @return 주문 목록 출력 화면
     */
    @GetMapping("/orderList")
    public String myOrders(SearchCondition sc, Model model) {

        try {
            int totalCnt = adminService.searchOrderListResultCnt(sc);
            PageHandler pageHandler = new PageHandler(totalCnt, sc);
            List<OrderDto> orderList = adminService.searchOrderList(sc);

            model.addAttribute("orderList", orderList);
            model.addAttribute("pageHandler", pageHandler);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("totalCnt", 0);
        }
        return "/admin/orderList";
    }


    /**
     * 배송 진행 상태 조작
     * @param confirmNumber 배송 상태 번호(0: 배송준비, 1: 배송중, 2: 배송완료)
     * @param orderNumber 주문 번호
     * @return 배송상태 업데이트 결과
     */
    @GetMapping("/delivery")
    @ResponseBody
    public String delivery(@RequestParam("cNum") int confirmNumber, @RequestParam("oNum") String orderNumber) {

        return adminService.updateOrderState(confirmNumber, orderNumber);
    }

}
