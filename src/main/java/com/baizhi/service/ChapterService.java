package com.baizhi.service;

import com.baizhi.entity.Chapter;

import java.util.Map;

public interface ChapterService {
    Map<String ,Object> findAll(Integer page, Integer rows,String albumId);
    public String save(Chapter chapter,String albumId);
    public void update(Chapter chapter);
}
