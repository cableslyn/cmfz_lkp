package com.baizhi.service;

import com.baizhi.entity.Star;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface StarService {
    List<Star> findAll(Integer page,Integer rows);
    int pageCount(Star star);
    public void save(Star star);
    public void update(Star star, HttpServletRequest request);
    public void delete(Star star,HttpServletRequest request);
    List<Star> findAll();
    Star findOne(String id);
}
