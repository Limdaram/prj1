package com.study.mapper.member;

import com.study.domain.member.MemberDto;

import java.util.List;

public interface MemberMapper {
    int delete(String id);

    int insert(MemberDto member);

    List<MemberDto> selectAll();

    MemberDto selectById(String id);

    int update(MemberDto member);

    MemberDto selectByEmail(String email);

    MemberDto selectByNickName(String nickName);
}
