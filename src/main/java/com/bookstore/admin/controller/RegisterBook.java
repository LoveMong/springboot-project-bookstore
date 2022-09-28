package com.bookstore.admin.controller;


import com.bookstore.admin.domain.BookDto;
import com.bookstore.admin.service.AdminService;
import com.bookstore.common.utils.PageHandler;
import com.bookstore.common.utils.SearchCondition;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.File;
import java.nio.file.Files;
import java.util.List;
import java.util.Objects;


/**
 * 도서등록기 능을 위한 컨트롤러
 * @author L
 */
@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
@Slf4j
public class RegisterBook {

    private final AdminService adminService;


    /**
     * 도서 등록 화면으로 이동
     *
     * @return 도서 등록 화면
     */
    @GetMapping("/enrollBook")
    public String enrollBook() {
        return "/admin/bookEnroll";
    }


    /**
     * 도서 등록
     * @param bookDto 등록될 도서 정보
     * @param file 도서 표지 이미지파일
     * @return 도서 리스트 출력 화면
     * @throws Exception
     */
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

        return "redirect:/admin/bookList";

    }


    /**
     * 등록된 도서 리스트 출력
     * @param sc 도서 리스트 페이징 처리 및 검색 조건
     * @param model 도서 리스트, 페이징 설정 등
     * @return
     */
    @GetMapping("/bookList")
    public String bookList(SearchCondition sc, Model model) {

        try {
            int totalCnt = adminService.searchResultCnt(sc);
            PageHandler pageHandler = new PageHandler(totalCnt, sc);
            List<BookDto> bookDto = adminService.searchSelectPage(sc);

            model.addAttribute("bookList", bookDto);
            model.addAttribute("pageHandler", pageHandler);
        } catch (Exception e) {
            model.addAttribute("totalCnt", 0);
        }

        return "/admin/bookList";

    }



}
