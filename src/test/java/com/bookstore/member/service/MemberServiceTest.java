package com.bookstore.member.service;

import com.bookstore.member.domain.MemberDto;
import com.bookstore.member.mapper.MemberMapper;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;
import org.springframework.transaction.annotation.Transactional;

import static org.junit.jupiter.api.Assertions.*;



@SpringBootTest
@TestPropertySource(locations = "classpath:application.properties")
class MemberServiceTest {

    @Autowired
    MemberMapper memberMapper;


    @Test
    @DisplayName("DB연결 테스트")
    public void createMember() throws Exception {
        //given
        MemberDto memberDto = MemberDto.builder()
                .memberEmail("mong22@naver.com")
                .memberName("LeeMong")
                .memberPassword("1234")
                .build();

        //when
        memberMapper.createMember(memberDto);


        //then


    }


}