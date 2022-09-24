package com.bookstore.common.utils;


import com.bookstore.admin.domain.UploadResultDto;
import net.coobird.thumbnailator.Thumbnailator;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import javax.swing.tree.ExpandVetoException;
import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

@Component
public class FileStore {

    @Value("${file.upload.location}/")
    private String uploadPath;


    public UploadResultDto uploadFile(MultipartFile uploadFile) throws Exception {





        // 실제 파일 이름 IE나 Edge는 전체 경로가 들어오므로
        String originalName = uploadFile.getOriginalFilename();
        String fileName = originalName.substring(originalName.lastIndexOf("\\") + 1);
        // 날짜 폴더 생성
        String folderPath = makeFolder();
        //UUID
        String uuid = UUID.randomUUID().toString();
        //저장할 파일 이름 중간에 "_"를 이용해 구분
        String saveName = uploadPath + File.separator + folderPath + File.separator + uuid + "_" + fileName;
        Path savePath = Paths.get(saveName);
        uploadFile.transferTo(savePath);

        //섬네일 생성 -> 섬네일 파일 이름은 중간에 s_로 시작
        String thubmnailSaveName = uploadPath + File.separator + folderPath + File.separator +"s_" + uuid +"_"+ fileName;
        File thumbnailFile = new File(thubmnailSaveName);
        // 섬네일 생성
        Thumbnailator.createThumbnail(savePath.toFile(),thumbnailFile,100,100);


        return new UploadResultDto(saveName, thubmnailSaveName);

    }

    private String makeFolder() {

        String str = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));

        String folderPath = str.replace("/", File.separator);

        // make folder ----
        File uploadPatheFolder = new File(uploadPath, folderPath);

        if (!uploadPatheFolder.exists()) {
            uploadPatheFolder.mkdirs();
        }

        return folderPath;

    }
}




