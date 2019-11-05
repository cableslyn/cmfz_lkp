package com.baizhi.entity;


import cn.afterturn.easypoi.excel.annotation.Excel;
import cn.afterturn.easypoi.excel.annotation.ExcelTarget;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import javax.persistence.Id;
import java.util.Date;

@Data
@NoArgsConstructor
@Accessors(chain = true)
@ExcelTarget(value = "star")
public class Star {
    @Id
    @Excel(name = "编号")
    private String id;
    @Excel(name = "姓名")
    private String name;
    @Excel(name = "艺名")
    private String nickname;
    @Excel(name = "照片",type = 2)
    private String photo;
    @Excel(name = "性别")
    private String sex;
    @JsonFormat(pattern = "yyyy/MM/dd",timezone = "GMT+8")
    @Excel(name = "生日",format = "yyyy-MM-dd")
    private Date bir;

}
