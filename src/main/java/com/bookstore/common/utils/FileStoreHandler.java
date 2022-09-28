package com.bookstore.common.utils;


import com.bookstore.admin.domain.UploadResultDto;
import net.coobird.thumbnailator.Thumbnailator;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.UUID;


/**
 * 파일(이미지) 업로드 핸들러
 * @author L
 */
@Component
public class FileStoreHandler {

    /**
     * 파일 업로드 경로
     */
    @Value("${file.upload.location}/")
    private String uploadPath;


    /**
     * 파일 저장 경로 및 폴더 생성 후 파일 업로드
     * @param uploadFile 업로드할 파일 정보
     * @return UploadResultDto 객체(중복 방지를 위한 새로운 이미지 파일 이름, 썸네일 이름)
     * @throws Exception
     */
    public UploadResultDto uploadFile(MultipartFile uploadFile) throws Exception {

        // 이미지 파일 이름
        String fileName = uploadFile.getOriginalFilename();
        // 날짜 폴더 생성
        String folderPath = makeFolder();
        //UUID
        String uuid = UUID.randomUUID().toString();
        //저장할 파일 이름 중간에 "_"를 이용해 구분(중복 방지)
        String saveName = uploadPath + File.separator + folderPath + File.separator + uuid + "_" + fileName;
        // 저장 경로
        Path savePath = Paths.get(saveName);
        // 저장 경로를 받아 데이터를 저장(전송)
        uploadFile.transferTo(savePath);

        //섬네일 이름 생성 -> 섬네일 파일 이름은 중간에 s_로 시작(중복 방지)
        String thumbnailSaveName = uploadPath + File.separator + folderPath + File.separator +"s_" + uuid +"_"+ fileName;
        File thumbnailFile = new File(thumbnailSaveName);
        // 섬네일 생성
        Thumbnailator.createThumbnail(savePath.toFile(),thumbnailFile,100,100);


        return new UploadResultDto(saveName, thumbnailSaveName);

    }


    /**
     * 파일(이미지) 업로드뢸 폴더 생성
     * @return
     */
    private String makeFolder() {

        String str = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));

        String folderPath = str.replace("/", File.separator);

        // make folder ----
        File uploadPathFolder = new File(uploadPath, folderPath);

        if (!uploadPathFolder.exists()) {
            uploadPathFolder.mkdirs();
        }

        return folderPath;

    }
}




