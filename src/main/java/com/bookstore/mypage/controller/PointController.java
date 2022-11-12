package com.bookstore.mypage.controller;


import com.bookstore.common.utils.PageHandler;
import com.bookstore.common.utils.SearchCondition;
import com.bookstore.member.domain.MemberDto;
import com.bookstore.member.domain.PrincipalDetails;
import com.bookstore.member.service.MemberService;
import com.bookstore.mypage.domain.KaKaoPayReadyDto;
import com.bookstore.mypage.domain.KakaoPayDto;
import com.bookstore.mypage.domain.PointDto;
import com.bookstore.mypage.service.KaKaoPayService;
import com.bookstore.mypage.service.PointService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;
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
@SessionAttributes({"tid", "pointChargeInfo"})
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


    /**
     * 카카오 페이 api 사용 point 충전 진행(결제 요청)
     * @param payInfo 충전될 포인트 정보
     * @param model 결제 고유번호, 포인트 정보
     * @return 결제 고유번호, redirect url
     */
    @PostMapping("/kakaoPay")
    @ResponseBody
    public KaKaoPayReadyDto kakaoPay(KakaoPayDto payInfo, Model model) {

        KaKaoPayReadyDto kaKaoPayReadyDto = kaKaoPayService.payReady(payInfo);

        // 객체 공유를 위한 @SessionAttributes 사용 -> model.addAttribute()를 활용하여 객체를 세션에 저장
        model.addAttribute("tid", kaKaoPayReadyDto.getTid());
        model.addAttribute("pointChargeInfo", payInfo);

        return kaKaoPayReadyDto;

    }


    /**
     * 카카오 페이 결제 성공(결제 승인 요청)
     * @param pg_token 결제 승인 인증 토큰
     * @param tid 결제 고유 번호
     * @param payInfoDto 진행될 포인트 정보
     * @param sessionS session 데이터 정리
     * @param rttr 포인트 충전 성공여부
     * @return 포인트 사용 내역 화면
     */
    @GetMapping("/kakaoPaySuccess")
    public String kakaoPaySuccess(@RequestParam("pg_token") String pg_token,
                                  @ModelAttribute("tid") String tid,
                                  @ModelAttribute("pointChargeInfo") KakaoPayDto payInfoDto,
                                  SessionStatus sessionS, RedirectAttributes rttr){

        log.info("kakaoPaySuccess get............................................");
        log.info("kakaoPaySuccess pg_token : " + pg_token);

        PointDto pointDto = new PointDto(payInfoDto.getMemberEmail(), payInfoDto.getPointCharge(), payInfoDto.getPointCurrent());

        try {

            String resultConfirm = kaKaoPayService.payApprove(tid, pg_token, payInfoDto);

            if (resultConfirm.equals("SUCCESS")) {
                pointService.chargePoint(pointDto);
                rttr.addFlashAttribute("msg", "포인트 충전 성공");
            } else {
                throw new Exception("FAIL");
            }

        } catch (Exception e) {
            e.printStackTrace();
            rttr.addFlashAttribute("msg", "포인트 충전 실패");
        }

        sessionS.setComplete(); // @SessionAttributes에 저장된 객체들 제거

        return "redirect:/point/history";

    }
}
