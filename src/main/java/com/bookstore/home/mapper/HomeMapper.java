package com.bookstore.home.mapper;

import com.bookstore.admin.domain.BookDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface HomeMapper {

    List<BookDto> searchBookListGrade();

    List<BookDto> searchBookListBest();

    List<BookDto> searchBookListNew();

    BookDto bookSearchDetail(int bookNum);

}
