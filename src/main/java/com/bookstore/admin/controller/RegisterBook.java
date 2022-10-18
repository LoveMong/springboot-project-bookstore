package com.bookstore.admin.controller;


import com.bookstore.admin.domain.BookDto;
import com.bookstore.admin.service.AdminService;
import com.bookstore.common.utils.PageHandler;
import com.bookstore.common.utils.SearchCondition;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.io.File;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.util.List;
import java.util.Objects;


/**
 * 도서등록기 능을 위한 컨트롤러
 *
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
     *
     * @param bookDto 등록될 도서 정보
     * @param result 유효성 검사 error 정보
     * @param file 도서 표지 이미지파일
     * @param model 도서 등록 성공여부 확인 메시지를 담은 객체
     * @param rattr 도서 등록 성공여부 확인 메시지를 담은 객체(redirect)
     * @return 도서 리스트 출력 화면
     * @throws Exception
     */
    @PostMapping("/enrollBook")
    public String enrollBook(@Valid BookDto bookDto, BindingResult result, @RequestParam("image") MultipartFile file,
                             Model model, RedirectAttributes rattr) throws Exception {

        String confirmMessage = "ENR_OK";

        try {

            if (result.hasErrors()) {
                throw new Exception("enroll failed. " + result);
            }

            File checkFile = new File(Objects.requireNonNull(file.getOriginalFilename()));
            String type = null;

            type = Files.probeContentType(checkFile.toPath());
            log.info("MIME TYPE : " + type);

            if (!type.startsWith("image")) {
                throw new Exception("이미지 파일이 아닙니다.");
            }

            if (adminService.enrollBook(bookDto, file) != 1) {
                throw new Exception("enroll failed.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "ENR_ERR");
            return "admin/bookEnroll";
        }

        rattr.addFlashAttribute("msg", confirmMessage);

        return "redirect:/admin/bookList";

    }


    /**
     * 등록된 도서 리스트 출력
     *
     * @param sc    도서 리스트 페이징 처리 및 검색 조건
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


    /**
     * 도서 상세 페이지 출력
     *
     * @param sc      도서 리스트 페이징 처리 및 검색 조건
     * @param bookNum 해당 도서 번호
     * @param model   해당 도서 정보
     * @param rattr 도서 상세정보 읽기 성공여부 확인 메시지
     * @return 도서 상세 페이지
     */
    @GetMapping("/bookDetail")
    public String bookView(@RequestParam("bookNum") int bookNum, SearchCondition sc, Model model, RedirectAttributes rattr) {

        BookDto bookDetail = null;

        try {

            bookDetail = adminService.searchBookDetailByBookNum(bookNum);

            if (bookDetail == null) {
                throw new Exception("read failed.");
            }


        } catch (Exception e) {
            e.printStackTrace();
            rattr.addFlashAttribute("msg", "READ_ERR");
            return "redirect:/admin/bookList" + sc.getQueryString();
        }


        model.addAttribute("bookDetail", bookDetail);
        model.addAttribute("searchCondition", sc);

        return "/admin/bookDetail";

    }


    /**
     * 도서 수정 페이지 출력
     *
     * @param sc      도서 리스트 페이징 처리 및 검색 조건
     * @param bookNum 해당 도서 번호
     * @param model   해당 도서 정보
     * @return 도서 수정 페이지
     */
    @GetMapping("/bookUpdate")
    public String bookUpdate(@RequestParam("bookNum") int bookNum, SearchCondition sc, Model model) {

        BookDto bookDetail = adminService.searchBookDetailByBookNum(bookNum);

        model.addAttribute("bookDetail", bookDetail);
        model.addAttribute("searchCondition", sc);

        return "/admin/bookUpdate";

    }


    /**
     * 도서 수정
     *
     * @param sc      도서 리스트 페이징 처리 및 검색 조건
     * @param bookDto 수정 도서 정보
     * @param file    도서 표지 이미지 파일
     * @param result  유효성 검사 error 정보
     * @param model 수정 도서 정보를 담은 객체
     * @param rattr 도서 수정 성공 여부 확인 메시지
     * @return 도서 목록 리스트 페이지
     * @throws Exception
     */
    @PostMapping("/bookUpdate")
    public String bookUpdate(@Valid BookDto bookDto, BindingResult result, Model model, SearchCondition sc,
                             @RequestParam(value = "image", required = false) MultipartFile file, RedirectAttributes rattr) throws Exception {

        if (result.hasErrors()) {

            model.addAttribute("bookDetail", bookDto);

            return "admin/bookUpdate";

        } else {

            adminService.bookUpdate(bookDto, file);

            String keywordEncode = URLEncoder.encode(sc.getKeyword(), "UTF-8");
            sc.setKeyword(keywordEncode);

            rattr.addFlashAttribute("msg", "UPD_OK");

        }

        return "redirect:/admin/bookList" + sc.getQueryString();

    }


    /**
     * 도서 삭제
     * @param bookNum 삭제 대상 도서번호
     * @param sc 도서 리스트 페이징 처리 및 검색 조건
     * @param rattr 도서 삭제 성공 여부 확인 메시지
     * @return 도서 목록 리스트 페이지
     * @throws Exception
     */
    @PostMapping("/bookRemove")
    public String bookRemove(@RequestParam("bookNum") int bookNum, SearchCondition sc, RedirectAttributes rattr) throws Exception {

        String confirmMessage = "DEL_OK";

        try {
            if (adminService.bookRemove(bookNum) != 1) {
                throw new Exception("Delete failed.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            confirmMessage = "DEL_ERR";
        }


        String keywordEncode = URLEncoder.encode(sc.getKeyword(), "UTF-8");
        sc.setKeyword(keywordEncode);

        rattr.addFlashAttribute("msg", confirmMessage);

        return "redirect:/admin/bookList" + sc.getQueryString();

    }
}
