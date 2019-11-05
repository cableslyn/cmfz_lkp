package com.baizhi.service;

import com.baizhi.entity.Picture;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface PictureService {
    public List<Picture> findAll(Integer page,Integer rows);
    public void save(Picture picture);
    public void update(Picture picture,HttpServletRequest request);
    public void delete(Picture picture,HttpServletRequest request);
    public int findCount(Picture picture);
}
