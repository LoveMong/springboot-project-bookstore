package com.bookstore.admin.controller;


import com.bookstore.admin.domain.BookDto;
import com.bookstore.admin.service.AdminService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.File;
import java.nio.file.Files;
import java.util.Objects;


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

        File checkFile = new File(Objects.requireNonNull(file.getOriginalFilename()));
        String type = null;

        type = Files.probeContentType(checkFile.toPath());
        log.info("MIME TYPE : " + type);

        if (!type.startsWith("image")) {
            throw new Exception("이미지 파일이 아닙니다.");
        }
        adminService.enrollBook(bookDto, file);

        return "/";

    }
}
