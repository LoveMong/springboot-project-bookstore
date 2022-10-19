package com.bookstore.home.service;


import com.bookstore.admin.domain.BookDto;
import com.bookstore.home.mapper.HomeMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class HomeService {


    private final HomeMapper homeMapper;


    public List<BookDto> searchBookListGrade() {
        return homeMapper.searchBookListGrade();
    }

    public List<BookDto> searchBookListBest() {
        return homeMapper.searchBookListBest();
    }

    public List<BookDto> searchBookListNew() {
        return homeMapper.searchBookListNew();
    }

    public BookDto bookSearchDetail(int bookNum) {
        return homeMapper.bookSearchDetail(bookNum);
    }



}
