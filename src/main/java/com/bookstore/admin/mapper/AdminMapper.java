package com.bookstore.admin.mapper;

import com.bookstore.admin.domain.BookDto;
import com.bookstore.member.domain.MemberDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminMapper {

    void enrollBook(BookDto bookDto);

}
