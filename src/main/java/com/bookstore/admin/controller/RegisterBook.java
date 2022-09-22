package com.bookstore.admin.controller;


import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class RegisterBook {


    @GetMapping("/enrollBook")
    public String enrollBook() {
        return "/admin/bookEnroll";
    }
}
