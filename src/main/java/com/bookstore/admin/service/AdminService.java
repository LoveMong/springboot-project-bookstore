package com.bookstore.admin.service;

import com.bookstore.admin.domain.BookDto;
import com.bookstore.admin.domain.UploadResultDto;
import com.bookstore.admin.mapper.AdminMapper;
import com.bookstore.common.utils.FileStoreHandler;
import com.bookstore.common.utils.SearchCondition;
import com.bookstore.member.domain.MemberDto;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class AdminService {


    @Value("${file.upload.location}/")
    private String uploadPath;

    private final AdminMapper adminMapper;

    private final FileStoreHandler fileStore;


    /**
     * 도서 등록 서비스 로직
     * @param bookDto 해당 도서 정보
     * @param uploadFile 해당 도서 파일 정보
     * @throws Exception
     */
    public int enrollBook(BookDto bookDto, MultipartFile uploadFile) throws Exception {


        UploadResultDto bookPictureUrl = fileStore.uploadFile(uploadFile);


        bookDto.setBookPictureUrl(bookPictureUrl.getBookPictureUrl());
        bookDto.setBookThumbUrl(bookPictureUrl.getBookThumbUrl());

        return adminMapper.enrollBook(bookDto);

    }


    /**
     * 도서 리스트 개수 확인
     * @return 개수
     */
    public int countBookList() {
        return adminMapper.countBookList();
    }

    /**
     * 도서 상세 내용 검색
     * @param bookNum 해당 도서 번호
     * @return 해당 도서 정보 객체
     */
    public BookDto searchBookDetailByBookNum(int bookNum) {
        return adminMapper.searchBookDetailByBookNum(bookNum);
    }


    /**
     * 도서 리스트 검색
     * @param map 검색 조건
     * @return 도서 리스트 객체
     */
    public List<BookDto> bookList(Map<String, Integer> map) {
        return adminMapper.bookList(map);
    }


    /**
     * 검색 조건에 해당되는 도서 리스트 개수 확인
     * @param sc 검색 조건
     * @return 검색된 도서 개수
     */
    public int searchBookResultCnt(SearchCondition sc) {
        return adminMapper.searchBookResultCnt(sc);
    }


    /**
     * 검색 조건에 해당되는 도서 리스트 출력
     * @param sc 검색 조건
     * @return 검색된 도서 객체 리스트
     */
    public List<BookDto> searchBookSelectPage(SearchCondition sc) {
        return adminMapper.searchBookSelectPage(sc);
    }


    /**
     * 도서 수정
     * @param bookDto 해당 도서 정보
     * @param file 해당 도서 파일정보
     * @throws Exception
     */
    public void bookUpdate(BookDto bookDto, MultipartFile file) throws Exception {

        if (file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) { // 새로운 이미지 파일 등록 요청

            new File(uploadPath + bookDto.getBookPictureUrl()).delete(); // 기존 이미지 삭제
            new File(uploadPath + bookDto.getBookThumbUrl()).delete(); // 기존 썸네일 이미지 삭제

            UploadResultDto bookPictureUrl = fileStore.uploadFile(file);

            bookDto.setBookPictureUrl(bookPictureUrl.getBookPictureUrl());
            bookDto.setBookThumbUrl(bookPictureUrl.getBookThumbUrl());

        }

        adminMapper.bookUpdate(bookDto);

    }


    /**
     * 도서 삭제
     * @param bookNum 해당 도서 번호
     */
    public int bookRemove(int bookNum) {
        return adminMapper.bookRemove(bookNum);
    }


    /**
     * 검색 조건에 해당되는 회원 리스트 개수 확인
     * @param sc 검색 조건
     * @return 검색된 회원 수
     */
    public int searchMemberResultCnt(SearchCondition sc) {
        return adminMapper.searchMemberResultCnt(sc);
    }


    /**
     * 검색 조건에 해당되는 도서 리스트 출력
     * @param sc 검색 조건
     * @return 검색된 도서 객체 리스트
     */
    public List<MemberDto> searchMemberSelectPage(SearchCondition sc) {
        return adminMapper.searchMemberSelectPage(sc);
    }





}
