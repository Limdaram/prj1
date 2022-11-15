package com.study.domain.member;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class MemberDto {
    private String id;
    private String password;
    private String email;
    private String nickName;

    private LocalDateTime inserted;
}
