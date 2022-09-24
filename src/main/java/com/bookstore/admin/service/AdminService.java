package com.bookstore.admin.service;

import com.bookstore.admin.domain.BookDto;
import com.bookstore.admin.domain.UploadResultDto;
import com.bookstore.admin.mapper.AdminMapper;
import com.bookstore.common.utils.FileStore;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Objects;

@Service
@RequiredArgsConstructor
public class AdminService {


    @Value("${file.upload.location}/")
    private String uploadPath;

    private final AdminMapper adminMapper;

    private final FileStore fileStore;

    public void enrollBook(BookDto bookDto, MultipartFile uploadFile) throws Exception {


        UploadResultDto bookPictureUrl = fileStore.uploadFile(uploadFile);


        bookDto.setBookPictureUrl(bookPictureUrl.getBookPictureUrl());
        bookDto.setBookThumbUrl(bookPictureUrl.getBookThumbUrl());

        adminMapper.enrollBook(bookDto);

    }






}
