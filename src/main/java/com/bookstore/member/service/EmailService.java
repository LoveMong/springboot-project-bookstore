package com.bookstore.member.service;

import lombok.RequiredArgsConstructor;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import java.util.concurrent.ThreadLocalRandom;

@Service
@RequiredArgsConstructor
public class EmailService {

    private final JavaMailSender javaMailSender;


    public int mailCheck(String email) {


        int key = generateAuthNum();

        SimpleMailMessage mailMessage = new SimpleMailMessage();
        mailMessage.setTo(email);
        mailMessage.setSubject("인증번호 입력을 위한 메일 전송");
        mailMessage.setText("인증번호 : " + key);

        javaMailSender.send(mailMessage);
        return key;
    }

    private static int generateAuthNum() {
        return ThreadLocalRandom.current().nextInt(100000, 1000000);
    }

 }


