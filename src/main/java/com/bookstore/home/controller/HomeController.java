package com.bookstore.home.controller;


import com.bookstore.admin.domain.BookDto;
import com.bookstore.common.utils.ReivewPageHandler;
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
        int countReview = homeService.countReview();
        ReivewPageHandler pageHandler = new ReivewPageHandler(countReview, page, pageSize);

        model.addAttribute("bookDetail", bookDto);
        model.addAttribute("bookReview", bookReview);
        model.addAttribute("pageHandler", pageHandler);

        return "/home/bookSearchDetail";

    }


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


    @PostMapping("/updateReview")
    @ResponseBody
    public String updateReview(ReviewDto reviewDto) {

        String resultConfirm = "UPD_OK";

        try {
            if (homeService.updateReview(reviewDto) != 1) {
                throw new Exception("Update failed.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resultConfirm = "UPD_ERR";
            return resultConfirm;
        }

        return resultConfirm;



    }
}
