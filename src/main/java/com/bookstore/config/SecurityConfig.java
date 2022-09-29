package com.bookstore.config;

import com.bookstore.member.service.Oauth2MemberService;
import com.bookstore.member.service.PrincipalDetailService;
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
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import org.springframework.security.web.firewall.DefaultHttpFirewall;
import org.springframework.security.web.firewall.HttpFirewall;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import javax.sql.DataSource;


/**
 * 스프링 시큐어티 설정
 * @Date 2022-09-05
 * @author L
 */

@Configuration // 설정 파일을 만들기 위한 어노테이션.
@EnableWebSecurity // 보안 설정을 커스터마이징 할 수 있는 어노테이션. SpringSecurityFilterChane 이 자동으로 포함됨
@RequiredArgsConstructor
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    private final PrincipalDetailService principalDetailService;
    private final DataSource dataSource;
    private final Oauth2MemberService oauth2MemberService;

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
                .logout() // 로그아웃 처리
                .logoutRequestMatcher(new AntPathRequestMatcher("/account/logout")) // 로그아웃 URL 설정
                .deleteCookies("JSESSIONID", "remember-me") // 로그아웃 후 해당 쿠키 삭제
                .logoutSuccessUrl("/") // 로그아웃 성공 시 이동할 URL을 설정
        ;


        http.oauth2Login()
                .defaultSuccessUrl("/") // 로그인 성공 시 이동할 URL을 설정
                .userInfoEndpoint()// 로그인 성공 후 사용자 정보를 가져옴
                .userService(oauth2MemberService) // 사용자 정보를 처리할 때 사용
        ;


        http.rememberMe()
                .tokenValiditySeconds(3600*24*365)
                .userDetailsService(principalDetailService)
                .tokenRepository(tokenRepository()) // DB에서 토큰 값 가져오기 (Username, 토큰, 시리즈)
        ;


        http.authorizeRequests() // 시큐리티 처리에 HttpServletRequest를 이용
                .mvcMatchers("/", "/login", "/logout", "/account/**").permitAll() // 메인, 회원 관련, 상품 관련, 상품 이미지 관련 페이지는 모든 사용자가 로그인(인증)없이 접근 가능
                .mvcMatchers("/admin/**").hasRole("ADMIN") // admin으로 시작하는 경로는 계정이 ADMIN일 경우에만 접근 가능
                .anyRequest().authenticated() // 위 mvcMatchers로 설정해준 결로 외 나머지 경로들은 모두 인증 요구
        ;


    }


    /**
     * 웹 시큐리티 설정
     * @param web
     * @throws Exception
     */
    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers("/css/**", "/img/**", "/js/**", "/mapper/**", "/error");
        web.httpFirewall(defaultHttpFirewall());
    }

    /**
     * 스프링 시큐리티 URL 더블슬래시 허용
     * @return
     */
    @Bean
    public HttpFirewall defaultHttpFirewall() {
        return new DefaultHttpFirewall();
    }


    /**
     * BCryptPasswordEncoder의 해시 함수를 이용하여 비밀번호를 암호화하여 저장, BCryptPasswordEncoder를 Bean으로 등록
     * @return
     */
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
//      시큐리티가 대신 로그인할 때 password를 가로채기 하는데 해당 pqssword가 무엇으로 해쉬되어 회원가입 되었는지 알아야 같은 해쉬로 암호화해서 DB에 있는 해쉬랑 비교 가능
        auth.userDetailsService(principalDetailService).passwordEncoder(new BCryptPasswordEncoder());
    }


    @Bean
    public PersistentTokenRepository tokenRepository() {
        // JDBC 기반의 tokenRepository 구현체
        JdbcTokenRepositoryImpl jdbcTokenRepository = new JdbcTokenRepositoryImpl();
        jdbcTokenRepository.setDataSource(dataSource); // dataSource 주입
        return jdbcTokenRepository;
    }




}
