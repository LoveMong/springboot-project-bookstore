package com.bookstore.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;


/**
 * 스프링 시큐어티 설정
 * @Date 2022-09-05
 * @author L
 */

@Configuration // 설정 파일을 만들기 위한 어노테이션.
@EnableWebSecurity // 보안 설정을 커스터마이징 할 수 있는 어노테이션. SpringSecurityFilterChane 이 자동으로 포함됨
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    // http 요청에 대한 보안을 설정
    // 페이지 권한 설정, 로그인 페이지 설정, 로그아웃 메소드 등에 대한 설정 등
    @Override
    protected void configure(HttpSecurity http) throws Exception {

    }


}
