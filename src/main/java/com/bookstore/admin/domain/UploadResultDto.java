package com.bookstore.admin.domain;


import lombok.*;

@Data
@AllArgsConstructor
public class UploadResultDto {

    private String bookPictureUrl; // 사진 URL
    private String bookThumbUrl; // 사진 썸네일 URL

}
