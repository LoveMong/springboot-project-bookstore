package com.bookstore.admin.service;

import com.bookstore.admin.domain.BookDto;
import com.bookstore.admin.domain.UploadResultDto;
import com.bookstore.admin.mapper.AdminMapper;
import com.bookstore.common.utils.FileStoreHandler;
import com.bookstore.common.utils.SearchCondition;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class AdminService {


    @Value("${file.upload.location}/")
    private String uploadPath;

    private final AdminMapper adminMapper;

    private final FileStoreHandler fileStore;



    public void enrollBook(BookDto bookDto, MultipartFile uploadFile) throws Exception {


        UploadResultDto bookPictureUrl = fileStore.uploadFile(uploadFile);


        bookDto.setBookPictureUrl(bookPictureUrl.getBookPictureUrl());
        bookDto.setBookThumbUrl(bookPictureUrl.getBookThumbUrl());

        adminMapper.enrollBook(bookDto);

    }


    public int countBookList() {
        return adminMapper.countBookList();
    }

    public BookDto searchBookDetailByBookNum(int bookNum) {
        return adminMapper.searchBookDetailByBookNum(bookNum);
    }


    public List<BookDto> bookList(Map<String, Integer> map) {
        return adminMapper.bookList(map);
    }

    public int searchResultCnt(SearchCondition sc) {
        return adminMapper.searchResultCnt(sc);
    }

    public List<BookDto> searchSelectPage(SearchCondition sc) {
        return adminMapper.searchSelectPage(sc);
    }


    public void bookUpdate(BookDto bookDto, MultipartFile file) throws Exception {

        if (file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {

            UploadResultDto bookPictureUrl = fileStore.uploadFile(file);

            bookDto.setBookPictureUrl(bookPictureUrl.getBookPictureUrl());
            bookDto.setBookThumbUrl(bookPictureUrl.getBookThumbUrl());
        }

        adminMapper.bookUpdate(bookDto);

    }






}
