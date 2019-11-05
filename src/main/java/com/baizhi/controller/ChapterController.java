package com.baizhi.controller;


import com.alibaba.druid.util.StringUtils;
import com.baizhi.entity.Chapter;
import com.baizhi.service.ChapterService;
import it.sauronsoftware.jave.Encoder;
import it.sauronsoftware.jave.EncoderException;
import it.sauronsoftware.jave.MultimediaInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

@Controller
@RequestMapping("chapter")
public class ChapterController {
    @Autowired
    private ChapterService chapterService;

    @RequestMapping("findAllByAlbums")
    @ResponseBody
    public Map<String ,Object> findAll(Integer page, Integer rows,String albumId){
        return chapterService.findAll(page,rows,albumId);
    }
    @RequestMapping("edit")
    @ResponseBody
    public Map<String,Object> edit(Chapter chapter, String oper, HttpServletRequest request,String albumId){
        Map<String, Object> map = new HashMap<>();
        if (StringUtils.equals(oper,"add")){
            String id = chapterService.save(chapter, albumId);
            map.put("message",id);
        }
        return map;
    }

    @RequestMapping("upload")
    @ResponseBody
    public void upload(MultipartFile name, HttpServletRequest request,String id) throws IOException, EncoderException {
        System.out.println(name);
        String realPath = request.getServletContext().getRealPath("/back/mp3");
        name.transferTo(new File(realPath,name.getOriginalFilename()));
        System.out.println("要修改的id"+id);
        Chapter chapter = new Chapter();
        chapter.setId(id);
        BigDecimal size = new BigDecimal(name.getSize());
        BigDecimal mod = new BigDecimal(1024);
        BigDecimal realSize = size.divide(mod).divide(mod).setScale(2, BigDecimal.ROUND_HALF_UP);
        chapter.setSize(realSize+"MB");
        System.out.println("--------------------");
        File source = new File(realPath+"\\"+name.getOriginalFilename());
        System.out.println("+++"+source);
        MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)request;
        Iterator<String> iter = multiRequest.getFileNames();
        MultipartFile file = multiRequest.getFile(iter.next());String fileOldName = file.getOriginalFilename();
        Encoder encoder = new Encoder();
        MultimediaInfo m = encoder.getInfo(source);
        long ls = m.getDuration();
        System.out.println("时长："+ls);
        String min=(ls/(1000*60))+"";
        String second= (ls%(1000*60)/1000)+"";
        if(min.length()<2){
           min=0+min;
        }
        if(second.length()<2){
           second=0+second;
        }
        chapter.setDuration(min+":"+second);
        chapterService.update(chapter);
    }
}
