package com.bookstore.common.error;

import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.multipart.MaxUploadSizeExceededException;


/**
 * 모든 @Controller 즉, 전역에서 발생할 수 있는 예외를 처리해주는 클래스 작성
 *
 * @author : L
 */
@ControllerAdvice
public class GlobalCatcher {

    @ExceptionHandler(Exception.class) // @Controller, @RestController가 적용 된 Bean에서 발생하는 예외를 잡아서 하나의 메서드에서 처리
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR) // 응답의 상태코들 지정해줄 수 있다.(예:200 -> 500)
    public String catcher(Exception exception) {
        return "/error/error1";
    }


    /**
     * 파일 업로드 허용 용량 초과시 오류화면 출력
     * @param model 발생 에러, 에러 설명
     * @return
     */
    @ExceptionHandler(MaxUploadSizeExceededException.class)
    @ResponseStatus(HttpStatus.PAYLOAD_TOO_LARGE)
    public String fileSizeLimitExceeded(Model model) {
        model.addAttribute("errorTitle", "Uploaded Resource Size Exceeds Limit.");
        model.addAttribute("errorDescription", "Uploaded resource's size exceeds limit. Please decrease request size.");
        return "error/request-failed";
    }

}
