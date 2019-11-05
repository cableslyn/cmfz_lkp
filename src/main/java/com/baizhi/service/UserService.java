package com.baizhi.service;

import com.baizhi.entity.User;

import java.util.List;
import java.util.Map;

public interface UserService {
    Map<String,Object> findAll(Integer page, Integer rows,String starId);
    List<User> findAll();
    public Integer[] selectUserCount(String sex);
}
