package com.baizhi.controller;


import com.alibaba.druid.util.StringUtils;
import com.baizhi.entity.Album;
import com.baizhi.service.AlbumService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.Map;

@Controller
@RequestMapping("album")
public class AlbumController {
    @Autowired
    private AlbumService albumService;
    @RequestMapping("findAllAlbums")
    @ResponseBody
    public Map<String ,Object> findAll(Integer page,Integer rows){
        return albumService.findAll(page,rows);
    }

    @RequestMapping("edit")
    @ResponseBody
    public void edit(Album album,String oper,HttpServletRequest request){
        if (StringUtils.equals(oper,"del")){
            albumService.delete(album,request);
        }
        if (StringUtils.equals(oper,"edit")){
            albumService.update(album,request);
        }
        if (StringUtils.equals(oper,"add")){
            albumService.save(album);
        }
    }
    @RequestMapping("upload")
    @ResponseBody
    public void upload(MultipartFile cover, HttpServletRequest request) throws IOException {
        String realPath = request.getSession().getServletContext().getRealPath("/back/album_img");
        cover.transferTo(new File(realPath,cover.getOriginalFilename()));
    }
}
