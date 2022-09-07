package com.spring.minip.common.error;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;


/**
 * 모든 @Controller 즉, 전역에서 발생할 수 있는 예외를 처리해주는 클래스 작성
 *
 * @Project : spring-minp
 * @Date : 2022-06-09
 * @author : L
 *
 */
@ControllerAdvice
public class GlobalCatcher {

    @ExceptionHandler(Exception.class) // @Controller, @RestController가 적용 된 Bean에서 발생하는 예외를 잡아서 하나의 메서드에서 처리
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR) // 응답의 상태코들 지정해줄 수 있다.(예:200 -> 500)
    public String catcher(Exception exception) {
        return "/error/error";
    }
}
