package com.baizhi.dao;

import com.baizhi.entity.User;
import com.baizhi.entity.UserCount;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface UserDao extends Mapper<User> {
   public List<UserCount> selectUserCount(String sex);
}
