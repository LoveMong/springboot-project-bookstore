package com.bookstore.mypage.controller;


import com.bookstore.mypage.domain.KaKaoPayReadyDto;
import com.bookstore.mypage.domain.KakaoPayDto;
import com.bookstore.common.utils.PageHandler;
import com.bookstore.common.utils.SearchCondition;
import com.bookstore.member.domain.MemberDto;
import com.bookstore.member.domain.PrincipalDetails;
import com.bookstore.member.service.MemberService;
import com.bookstore.mypage.domain.PointDto;
import com.bookstore.mypage.service.KaKaoPayService;
import com.bookstore.mypage.service.PointService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;
import java.util.Objects;

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

    private final MemberService memberService;

    private final KaKaoPayService kaKaoPayService;


    /**
     * 포인트 충전 및 사용내역 조회
     *
     * @param sc               조회 기준 기간 설정
     * @param model            로그인된 고객 정보 및 포인트 내역
     * @param principalDetails 로그인된 고객정보
     * @return 포인트 내역 조회 화면
     */
    @GetMapping("/history")
    public String history(SearchCondition sc, Model model, @AuthenticationPrincipal PrincipalDetails principalDetails) {

        String memberEmail = principalDetails.getMemberDto().getMemberEmail();
        sc.setMemberEmail(memberEmail);

        try {
            int totalCnt = pointService.searchPointResultCnt(sc);
            PageHandler pageHandler = new PageHandler(totalCnt, sc);
            MemberDto memberDto = memberService.selectMemberByEmail(memberEmail);
            List<PointDto> pointList = pointService.searchPointList(sc);

            model.addAttribute("memberInfo", memberDto);
            model.addAttribute("pointList", pointList);
            model.addAttribute("pageHandler", pageHandler);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("totalCnt", 0);
        }
        return "/mypage/pointHistory";
    }


    /**
     * 포인트 충전 화면으로 이동
     *
     * @param principalDetails 로그인된 고객정보
     * @param model            고객 정보
     * @return 포인트 충전 화면
     */
    @GetMapping("/charge")
    public String charge(@AuthenticationPrincipal PrincipalDetails principalDetails, Model model) {

        String memberEmail = principalDetails.getMemberDto().getMemberEmail();
        MemberDto memberDto = memberService.selectMemberByEmail(memberEmail);

        model.addAttribute("memberInfo", memberDto);

        return "/mypage/pointCharge";
    }


    /**
     * 포인트 충전 진행
     *
     * @param pointDto 충전할 포인트 정보
     * @param rttr     포인트 충전 성공 여부 메시지
     * @return 포인트 내역 조회 화면
     */
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


    @PostMapping("/kakaoPay")
    @ResponseBody
    public KaKaoPayReadyDto kakaoPay(KakaoPayDto payInfo) {

        log.info("payInfo : " + payInfo);

        return kaKaoPayService.payReady(payInfo);

    }

    @GetMapping("/kakaoPaySuccess")
    public String kakaoPaySuccess(@RequestParam("pg_token") String pg_token){
        log.info("kakaoPaySuccess get............................................");
        log.info("kakaoPaySuccess pg_token : " + pg_token);

        return null;

    }
}
