package com.bookstore.member.service;

import lombok.RequiredArgsConstructor;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
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
    public int mailCheck(String email) throws Exception {


        int key = generateAuthNum(); // 인증번호 생성
        MimeMessage mailMessage = javaMailSender.createMimeMessage();
        String mailContent = "<h1>[이메일 인증]</h1><br><p>아래 인증번호를 인증번호 확인란에 기입하여 주세요.</p><br>"
                + "인증번호는 "
                + key
                + " 입니다.";


        mailMessage.setSubject("회원가입 이메일 인증 ", "utf-8");
        mailMessage.setText(mailContent, "utf-8", "html");
        mailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(email));

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


