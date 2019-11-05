package com.baizhi.service;

import com.baizhi.entity.Album;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

public interface AlbumService {
    Map<String,Object> findAll(Integer page,Integer rows);
    public void save(Album album);
    public void update(Album album, HttpServletRequest request);
    public void delete(Album album,HttpServletRequest request);
}
