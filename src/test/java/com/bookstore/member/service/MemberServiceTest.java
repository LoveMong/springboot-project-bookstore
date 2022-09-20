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
import static org.junit.jupiter.api.Assertions.assertEquals;


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

    @Test
    @DisplayName("회원 찾기")
    public void selectMember() throws Exception {
        //given
        MemberDto memberDto = MemberDto.builder()
                .memberEmail("mong9012@naver.com")
                .memberName("리몽")
                .memberPassword("1234")
                .build();

        memberMapper.createMember(memberDto);

        //when
        MemberDto member = memberMapper.selectMemberByEmail(memberDto.getMemberEmail());


        //then

        assertEquals(member.getMemberName(), memberDto.getMemberName());


    }

    @Test
    @DisplayName("비밀번호 변경")
    public void resetPassword() throws Exception {
        //given
        MemberDto memberDto = MemberDto.builder()
                .memberEmail("test")
                .memberName("test1")
                .memberPassword("1234")
                .build();

        memberMapper.createMember(memberDto);


        //when
        memberMapper.updatePassword(memberDto.getMemberEmail(), "1111");
        MemberDto memberDto1 = memberMapper.selectMemberByEmail(memberDto.getMemberEmail());


        //then
        assertNotEquals(memberDto.getMemberPassword(), memberDto1.getMemberPassword());



    }




}