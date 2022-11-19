package com.bookstore.home.controller;


import com.bookstore.admin.domain.BookDto;
import com.bookstore.common.utils.PageHandler;
import com.bookstore.common.utils.ReviewPageHandler;
import com.bookstore.common.utils.SearchCondition;
import com.bookstore.home.domain.ReviewDto;
import com.bookstore.home.service.HomeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;


/**
 *
 */
@Controller
@RequestMapping
@RequiredArgsConstructor
@Slf4j
public class HomeController {

    private final HomeService homeService;


    /**
     * 메인 홈 출력
     *
     * @param model 신간 도서 , 베스트셀러 도서, 인기 도서 정보
     * @return 메인 홈 화면
     */
    @GetMapping("/")
    public String mainHome(Model model) {

        List<BookDto> bookListGrade = homeService.searchBookListGrade();
        List<BookDto> bookListBest = homeService.searchBookListBest();
        List<BookDto> bookListNew = homeService.searchBookListNew();

        model.addAttribute("bookListGrade", bookListGrade);
        model.addAttribute("bookListBest", bookListBest);
        model.addAttribute("bookListNew", bookListNew);

        return "/home/mainHome";

    }


    /**
     * 도서 검색 상세 페이지 출력
     *
     * @param bookNum  해당 도서 번호
     * @param page     페이징 처리 -> 출력 시작 번호
     * @param pageSize 페이징 처리 -> 출력할 개수
     * @param model    도서 정보, 도서 리뷰 정보, 페이징 정보
     * @return 도서 검색 상세 페이지 화면
     */
    @GetMapping("/bookSearchDetail")
    public String bookSearchDetail(@RequestParam("num") int bookNum,
                                   @RequestParam(value = "page", defaultValue = "1") int page,
                                   @RequestParam(value = "pageSize", defaultValue = "5") int pageSize, Model model) {

        HashMap<String, Integer> map = new HashMap<>();
        map.put("bookNum", bookNum);
        map.put("offset", (page - 1) * pageSize);
        map.put("pageSize", pageSize);

        BookDto bookDto = homeService.bookSearchDetail(bookNum);
        List<ReviewDto> bookReview = homeService.searchBookReview(map);
        int countReview = homeService.countReview(bookNum);
        ReviewPageHandler pageHandler = new ReviewPageHandler(countReview, page, pageSize);

        model.addAttribute("bookDetail", bookDto);
        model.addAttribute("bookReview", bookReview);
        model.addAttribute("pageHandler", pageHandler);

        return "/home/bookSearchDetail";

    }


    /**
     * 도서 리뷰 삭제
     *
     * @param reviewNum 해당 도서 번호
     * @return 도서 리뷰 삭제 성공 여부
     */
    @GetMapping("/deleteReview")
    @ResponseBody
    public String deleteReview(@RequestParam("reviewNum") int reviewNum) {

        String resultConfirm = "DEL_OK";

        try {
            if (homeService.deleteReview(reviewNum) != 1) {
                throw new Exception("Delete failed.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resultConfirm = "DEL_ERR";
            return resultConfirm;
        }

        return resultConfirm;

    }


    /**
     * 도서 구매 리뷰 수정
     *
     * @param reviewDto 수정된 리뷰 정보
     * @return 리뷰 수정 성공 여부
     */
    @PostMapping("/updateReview")
    @ResponseBody
    public String updateReview(ReviewDto reviewDto) {

        String resultConfirm = "수정 완료!";

        try {
            if (homeService.updateReview(reviewDto) != 1) {
                throw new Exception("Update failed.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resultConfirm = "수정 실패!";
            return resultConfirm;
        }

        return resultConfirm;

    }


    /**
     * 도서 리뷰 등록
     *
     * @param reviewDto 등록할 리뷰 내용
     * @return 리뷰 등록 성공 여부
     */
    @PostMapping("/enrollReview")
    @ResponseBody
    public String enrollReview(ReviewDto reviewDto) {

        String resultConfirm;

        int confirm = homeService.enrollReview(reviewDto);

        switch (confirm) {
            case 1:
                resultConfirm = "등록 완료!";
                break;
            case 2:
                resultConfirm = "구매 후 리뷰 등록이 가능합니다.";
                break;
            case 3:
                resultConfirm = "구매 후 리뷰는 한번만 등록 가능합니다.";
                break;
            default:
                resultConfirm = "등록 실패";
        }

        return resultConfirm;

    }


    /**
     * 도서 검색(통합, 제목, 작가, 카테고리 등)
     * @param sc 검색 조건
     * @param model 검색된 도서 정보 및 페이징 처리 객체
     * @return 도서 검색 화면
     */
    @GetMapping("/search")
    public String search(SearchCondition sc, Model model) {

        try {
            List<BookDto> bookDtoList;
            PageHandler pageHandler;

            if (!sc.getSelectOption().equals("")) {
                bookDtoList = homeService.searchBookListSelect(sc);
                pageHandler = new PageHandler(0, sc);
            } else {
                int totalCnt = homeService.searchBookListResultCnt(sc);
                pageHandler = new PageHandler(totalCnt, sc);
                bookDtoList = homeService.searchBookList(sc);
            }

            model.addAttribute("pageHandler", pageHandler);
            model.addAttribute("bookList", bookDtoList);

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("totalCnt", 0);
        }


        return "/home/mainSearch";
    }
}
