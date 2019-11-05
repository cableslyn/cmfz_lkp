package com.baizhi.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;
import cn.afterturn.easypoi.excel.annotation.ExcelEntity;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import javax.persistence.Id;
import java.util.Date;

@Data
@NoArgsConstructor
@Accessors(chain = true)
public class User {
    @Id
    @Excel(name = "用户id")
    private String id;
    @Excel(name = "用户名")
    private String username;
    private String password;
    @Excel(name = "昵称")
    private String nickname;
    @Excel(name = "手机号")
    private String phone;
    private String salt;
    @Excel(name = "省")
    private String province;
    @Excel(name = "市")
    private String city;
    @Excel(name = "签名")
    private String sign;
    @Excel(name = "头像",type = 2)
    private String photo;
    @Excel(name = "性别")
    private String sex;
    @JsonFormat(pattern = "yyyy/MM/dd",timezone = "GMT+8")
    @Excel(name = "创建日期",format = "yyyy-MM-dd")
    private Date createDate;
    private String starId;
    @ExcelEntity(name = "明星")
    private Star star;
}
