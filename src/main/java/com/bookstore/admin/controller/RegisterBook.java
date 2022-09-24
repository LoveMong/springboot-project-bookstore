package com.bookstore.admin.controller;


import com.bookstore.admin.domain.BookDto;
import com.bookstore.admin.service.AdminService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;


@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
@Slf4j
public class RegisterBook {

    private final AdminService adminService;


    @GetMapping("/enrollBook")
    public String enrollBook() {
        return "/admin/bookEnroll";
    }


    @PostMapping("/enrollBook")
    public String enrollBook(@Valid BookDto bookDto, @RequestParam("image") MultipartFile file) throws Exception {



        log.info("book : " + bookDto);
        log.info("file : " + file.getOriginalFilename());


        adminService.enrollBook(bookDto, file);


        return "";

    }
}
