package com.bookstore.admin.service;

import com.bookstore.admin.domain.BookDto;
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

        if (Objects.requireNonNull(uploadFile.getContentType()).startsWith("image")) {

            return;

        }

        String imgUploadPath = uploadPath + File.separator + "imgUpload";
        String ymdPath = fileStore.calcPath(imgUploadPath);
        String fileName = null;

        if(uploadFile.getOriginalFilename() != null && uploadFile.getOriginalFilename() != "") {
            fileName = fileStore.fileUpload(imgUploadPath, uploadFile.getOriginalFilename(), uploadFile.getBytes(), ymdPath);
        } else {
            fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
        }

        bookDto.setBookPictureUrl(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
        bookDto.setBookThumbUrl(File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);

        adminMapper.enrollBook(bookDto);

    }






}
