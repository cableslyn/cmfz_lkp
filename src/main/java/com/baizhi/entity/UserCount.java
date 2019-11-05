package com.baizhi.entity;


import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class UserCount {

    private Integer month;
    private Integer count;
}
