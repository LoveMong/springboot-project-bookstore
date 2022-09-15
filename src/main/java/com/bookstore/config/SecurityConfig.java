package com.bookstore.config;

import com.bookstore.member.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;


/**
 * 스프링 시큐어티 설정
 * @Date 2022-09-05
 * @author L
 */

@Configuration // 설정 파일을 만들기 위한 어노테이션.
@EnableWebSecurity // 보안 설정을 커스터마이징 할 수 있는 어노테이션. SpringSecurityFilterChane 이 자동으로 포함됨
@RequiredArgsConstructor
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    private final MemberService memberService;

    // http 요청에 대한 보안을 설정
    // 페이지 권한 설정, 로그인 페이지 설정, 로그아웃 메소드 등에 대한 설정 등
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.formLogin()
                .loginPage("/account/sign-in") // 로그인 페이지 URL을 설정
                .loginProcessingUrl("/login") // form 태그의 action 속성 (default: POST /login)
                .usernameParameter("memberEmail") // input 태그의 아이디 혹은 이메일 name 속성 값 (default: username)
                .passwordParameter("memberPassword") // input 태그의 비밀번호 name 속성 값 (default: password)
                .defaultSuccessUrl("/") // 로그인 성공 시 이동할 URL을 설정
                .failureUrl("/account/sign-in/error") // 로그인 실패 시 이동할 URL을 설정
                .and()
                .logout()
                .logoutRequestMatcher(new AntPathRequestMatcher("/members/logout")) // 로그아웃 URL 설정
                .logoutSuccessUrl("/") // 로그아웃 성공 시 이동할 URL을 설정
        ;

        http.authorizeRequests() // 시큐리티 처리에 HttpServletRequest를 이용
                .mvcMatchers("/", "/login", "/account/sign-in", "/account/sign-up", "/account/sign-in/error").permitAll() // 메인, 회원 관련, 상품 관련, 상품 이미지 관련 페이지는 모든 사용자가 로그인(인증)없이 접근 가능
                .mvcMatchers("/admin/**").hasRole("ADMIN") // admin으로 시작하는 경로는 계정이 ADMIN일 경우에만 접근 가능
                .anyRequest().authenticated() // 위 mvcMatchers로 설정해준 결로 외 나머지 경로들은 모두 인증 요구
        ;
    }

    @Override
    public void configure(WebSecurity web) throws Exception { // static 디렉터리의 하위 파일은 인증 무시하도록 설정
        web.ignoring().antMatchers("/css/**", "/js/**", "/img/**", "/mapper/**");
    }



    // 비밀번호 데이터베이스에 그대로 저장했을 경우, 데이터베이스가 해킹당하면 고객의 회원정보가 그대로 노출
    // BCryptPasswordEncoder의 해시 함수를 이용하여 비밀번호를 암호화하여 저장
    // BCryptPasswordEncoder를 Bean으로 등록
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    /**
     * 로그인 인증 처리 메소드
     * @param auth
     * @throws Exception
     */
    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(memberService).passwordEncoder(new BCryptPasswordEncoder());
    }


}
