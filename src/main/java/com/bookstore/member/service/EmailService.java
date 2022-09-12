package com.bookstore.member.service;

import lombok.RequiredArgsConstructor;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import java.util.concurrent.ThreadLocalRandom;


/**
 * 회원가입 이메일 인증
 * @author L
 */
@Service
@RequiredArgsConstructor
public class EmailService {

    private final JavaMailSender javaMailSender;


    /**
     * 인증메일 전송
     * @param email 수신 메일주소
     * @return 6자리 난수
     */
    public int mailCheck(String email) {


        int key = generateAuthNum(); // 인증번호 생성

        SimpleMailMessage mailMessage = new SimpleMailMessage();

        mailMessage.setTo(email); // 수신 메일주소
        mailMessage.setSubject("회원가입 인증 이메일입니다."); // 메일 제목
        mailMessage.setText( // 메일 내용
                        "홈페이지를 방문해주셔서 감사합니다." +
                        "<br><br>" +
                        "인증 번호는 " + key + "입니다." +
                        "<br>" +
                        "해당 인증번호를 인증번호 확인란에 기입하여 주세요.");

        javaMailSender.send(mailMessage);

        return key;

    }


    /**
     * 6자리 난수 생성
     * @return 6자리 난수
     */
    private static int generateAuthNum() {
//      ThreadLocalRandom 은 똑같은 Random API 구현체
//      ThreadLocalRandom은 위의 동시성 문제를 해결하기 위해 각 쓰레드마다 생성된 인스턴스에서 각각 난수를 반환한다.
//      따라서 Random과 같은 경합 문제가 발생하지 않아 안전하며, 성능상 이점이 있다.
        return ThreadLocalRandom.current().nextInt(100000, 1000000);
    }


 }


