package com.bookstore.admin.mapper;

import com.bookstore.admin.domain.BookDto;
import com.bookstore.common.utils.SearchCondition;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface AdminMapper {

    void enrollBook(BookDto bookDto);

    int countBookList();

    BookDto searchBookDetailByBookNum(int num);

    List<BookDto> bookList(Map<String, Integer> map);

    int searchResultCnt(SearchCondition sc);

    List<BookDto> searchSelectPage(SearchCondition sc);


    void bookUpdate(BookDto bookDto);

}
