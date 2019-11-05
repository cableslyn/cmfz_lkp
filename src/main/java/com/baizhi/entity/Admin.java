package com.baizhi.entity;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@NoArgsConstructor
@Accessors(chain = true)
public class Admin {
    private String id;
    private String username;
    private String password;
    private String nickname;
}
