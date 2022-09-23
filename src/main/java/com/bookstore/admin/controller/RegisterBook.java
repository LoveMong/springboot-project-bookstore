package com.bookstore.admin.controller;


import com.bookstore.admin.domain.BookDto;
import com.bookstore.admin.service.AdminService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;


@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class RegisterBook {

    private final AdminService adminService;


    @GetMapping("/enrollBook")
    public String enrollBook() {
        return "/admin/bookEnroll";
    }


    @PostMapping("/enrollBook")
    public String enrollBook(BookDto bookDto, MultipartFile file) throws Exception {

        adminService.enrollBook(bookDto, file);


        return "";

    }
}
