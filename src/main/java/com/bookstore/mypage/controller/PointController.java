package com.bookstore.mypage.controller;


import com.bookstore.common.utils.PageHandler;
import com.bookstore.common.utils.SearchCondition;
import com.bookstore.member.domain.PrincipalDetails;
import com.bookstore.mypage.domain.PointDto;
import com.bookstore.mypage.service.PointService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

/**
 * 포인트 관리를 위한 컨트롤러
 *
 * @author L
 */
@Controller
@RequestMapping("/point")
@RequiredArgsConstructor
@Slf4j
public class PointController {

    private final PointService pointService;


    @GetMapping("/history")
    public String history(SearchCondition sc, Model model, @AuthenticationPrincipal PrincipalDetails principalDetails) {

        String memberEmail = principalDetails.getMemberDto().getMemberEmail();
        sc.setMemberEmail(memberEmail);

        try {
            int totalCnt = pointService.searchPointResultCnt(sc);
            PageHandler pageHandler = new PageHandler(totalCnt, sc);
            List<PointDto> pointList = pointService.searchPointList(sc);

            model.addAttribute("pointList", pointList);
            model.addAttribute("pageHandler", pageHandler);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("totalCnt", 0);
        }
        return "/mypage/pointHistory";
    }


    @GetMapping("/charge")
    public String charge() {
        return "/mypage/pointCharge";
    }


    @PostMapping("/charge")
    public String charge(PointDto pointDto, RedirectAttributes rttr) throws Exception {

        log.info("point : " + pointDto);

        try {
            pointService.chargePoint(pointDto);
            rttr.addFlashAttribute("msg", "포인트 충전 완료");
        } catch (Exception e) {
            e.printStackTrace();
            rttr.addFlashAttribute("msg", "포인트 충전 실패");
        }

        return "redirect:/point/history";
    }
}
