package com.bookstore.member.mapper;

import com.bookstore.member.domain.MemberDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {

    int createMember(MemberDto member);

}
