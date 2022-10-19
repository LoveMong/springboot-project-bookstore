package com.bookstore.home.controller;


import com.bookstore.admin.domain.BookDto;
import com.bookstore.home.service.HomeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
    public String bookSearchDetail(@RequestParam("num") int bookNum, Model model) {

        BookDto bookDto = homeService.bookSearchDetail(bookNum);

        model.addAttribute("bookDetail", bookDto);

        return "/home/bookSearchDetail";

    }
}
