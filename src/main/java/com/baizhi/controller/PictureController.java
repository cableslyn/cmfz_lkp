package com.baizhi.controller;


import com.alibaba.druid.util.StringUtils;
import com.baizhi.entity.Picture;
import com.baizhi.service.PictureService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("picture")
public class PictureController {

    @Autowired
    private PictureService pictureService;

    @RequestMapping("findAll")
    @ResponseBody
    public Map<String,Object> findAll(Integer page, Integer rows){
        Picture picture = new Picture();
        List<Picture> list = pictureService.findAll(page,rows);
        int totalCounts = pictureService.findCount(picture);
        Map<String, Object> result = new HashMap<>();
        result.put("rows",list);//当前页集合
        result.put("page",page);
        int totalPage = totalCounts%rows==0?totalCounts/rows:totalCounts/rows+1;
        result.put("total",totalPage);
        result.put("records",totalCounts);
        return result;
    }

    @RequestMapping("edit")
    @ResponseBody
    public void edit(Picture picture, String oper,HttpServletRequest request){
        if(StringUtils.equals(oper,"del")){//删除操作
            pictureService.delete(picture,request);
        }
        if(StringUtils.equals(oper,"edit")){//修改操作
            pictureService.update(picture,request);
        }
        if(StringUtils.equals(oper,"add")){//保存操作
            pictureService.save(picture);
        }
    }
    @RequestMapping("upload")
    @ResponseBody
    public void upload(MultipartFile cover,HttpServletRequest request) throws IOException {
        String realPath = request.getSession().getServletContext().getRealPath("/back/picture");
        cover.transferTo(new File(realPath,cover.getOriginalFilename()));
    }
}
