package com.bookstore.admin.service;

import com.bookstore.admin.domain.BookDto;
import com.bookstore.admin.mapper.AdminMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@TestPropertySource(locations = "classpath:application.properties")
class AdminServiceTest {


    @Autowired
    private AdminMapper adminMapper;


    @Test
    public void addBookList () throws Exception {

        //given

        for(int i = 0; i < 180; i++){
            BookDto bookDto = BookDto.builder()
                    .bookTitle("테스트" + i)
                    .bookPrice(20000)
                    .bookPublisher("한빛")
                    .bookAuthor("한빛")
                    .bookCategory(1)
                    .bookContent("테스트입니다.")
                    .bookPictureUrl("/Users/juyoung/Development/Project/Spring Boot/bookstore/images//2022/09/28/1f63e248-211f-4ada-bdc4-19e2869d9ac0_다운로드.jpeg")
                    .bookThumbUrl("/Users/juyoung/Development/Project/Spring Boot/bookstore/images//2022/09/28/s_1f63e248-211f-4ada-bdc4-19e2869d9ac0_다운로드.jpeg")
                    .bookStock(20)
                    .bookPublishingDate("2014-04-01")
                    .build();

            adminMapper.enrollBook(bookDto);

        }


        //when


        //then


    }





}