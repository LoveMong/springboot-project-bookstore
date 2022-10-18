package com.bookstore.admin.controller;

import com.bookstore.admin.domain.BookDto;
import com.bookstore.admin.service.AdminService;
import com.bookstore.common.utils.PageHandler;
import com.bookstore.common.utils.SearchCondition;
import com.bookstore.member.domain.MemberDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;


/**
 * 회원 리스트 관리를 위한 컨트롤러
 *
 * @author L
 */
@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
@Slf4j
public class MemberController {

    private final AdminService adminService;


    /**
     * 등록된 회원 리스트 출력
     *
     * @param sc 회원 리스트 페이징 처리 및 검색 조
     * @param model 회원 리스트, 페이징 설정 등
     * @return
     */
    @GetMapping("/memberList")
    public String memberList(SearchCondition sc, Model model) {

        try {
            int totalCnt = adminService.searchMemberResultCnt(sc);
            PageHandler pageHandler = new PageHandler(totalCnt, sc);
            List<MemberDto> memberDto = adminService.searchMemberSelectPage(sc);

            model.addAttribute("memberList", memberDto);
            model.addAttribute("pageHandler", pageHandler);
        } catch (Exception e) {
            model.addAttribute("totalCnt", 0);
        }

        return "/admin/memberList";

    }


}
