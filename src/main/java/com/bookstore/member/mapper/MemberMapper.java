package com.bookstore.member.mapper;

import com.bookstore.member.domain.MemberDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {

    void createMember(MemberDto member);

    MemberDto selectMemberByEmail(String email);

    void updatePassword(String email, String password);

}
