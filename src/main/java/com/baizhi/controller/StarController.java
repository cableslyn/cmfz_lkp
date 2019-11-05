package com.baizhi.controller;


import com.alibaba.druid.util.StringUtils;
import com.baizhi.entity.Star;
import com.baizhi.service.StarService;
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
@RequestMapping("star")
public class StarController {
    @Autowired
    private StarService starService;
    @RequestMapping("findAllStar")
    @ResponseBody
    public Map<String,Object> findAllStar(Integer page,Integer rows){
        Star star = new Star();
        List<Star> all = starService.findAll(page, rows);
        int totalCounts = starService.pageCount(star);
        Map<String, Object> result = new HashMap<>();
        result.put("rows",all);//当前页集合
        result.put("page",page);
        int totalPage = totalCounts%rows==0?totalCounts/rows:totalCounts/rows+1;
        result.put("total",totalPage);
        result.put("records",totalCounts);
        return result;
    }

    @RequestMapping("edit")
    @ResponseBody
    public void edit(Star star, String oper, HttpServletRequest request) throws IOException {
        if(StringUtils.equals(oper,"del")){//删除操作
           starService.delete(star,request);
        }
        if(StringUtils.equals(oper,"edit")){//修改操作
            starService.update(star,request);
        }
        if(StringUtils.equals(oper,"add")){//保存操作
            starService.save(star);
        }
    }
    @RequestMapping("findAll")
    @ResponseBody
    public Map<String,Object> findAll(){
        Map<String, Object> map = new HashMap<>();
        List<Star> all = starService.findAll();
        map.put("rows",all);
        return map;
    }

    @RequestMapping("upload")
    @ResponseBody
    public void upload(MultipartFile photo, HttpServletRequest request) throws IOException {
        String realPath = request.getSession().getServletContext().getRealPath("/back/star_img");
        photo.transferTo(new File(realPath,photo.getOriginalFilename()));
    }
}
