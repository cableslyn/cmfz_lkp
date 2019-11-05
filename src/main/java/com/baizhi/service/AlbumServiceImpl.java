package com.baizhi.service;

import com.baizhi.dao.AlbumDao;
import com.baizhi.dao.ChapterDao;
import com.baizhi.entity.Album;
import com.baizhi.entity.Chapter;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.*;

@Service
@Transactional
public class AlbumServiceImpl implements AlbumService {
    @Autowired
    private AlbumDao albumDao;
    @Autowired
    private ChapterDao chapterDao;
    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public Map<String, Object> findAll(Integer page, Integer rows) {
        Album album = new Album();
        Map<String, Object> map = new HashMap<>();
        RowBounds rowBounds = new RowBounds((page - 1) * rows, rows);
        List<Album> albums = albumDao.selectByRowBounds(album,rowBounds);
        for (Album album1 : albums) {
            Chapter chapter = new Chapter();
            chapter.setAlbumId(album1.getId());
            List<Chapter> list = chapterDao.select(chapter);
            album1.setCount(list.size());
        }
        int count = albumDao.selectCount(album);
        map.put("page",page);
        map.put("rows",albums);
        map.put("total",count%rows==0?count/rows:count/rows+1);
        map.put("records",count);
        return map;
    }

    @Override
    public void save(Album album) {
        album.setId(UUID.randomUUID().toString());
        //album.setCreateDate(new Date());
        String substring = album.getCover().substring(album.getCover().lastIndexOf("\\") + 1);
        album.setCover(substring);
        Chapter chapter = new Chapter();
        chapter.setAlbumId(album.getId());
        int count = chapterDao.selectCount(chapter);
        album.setCount(count);
        albumDao.insert(album);
    }

    @Override
    public void update(Album album, HttpServletRequest request) {
        if (album.getCover()==null||album.getCover().equals("")){
            Album album1 = albumDao.selectByPrimaryKey(album);
            album.setCover(album1.getCover());
            albumDao.updateByPrimaryKey(album);
        }else{
            String substring = album.getCover().substring(album.getCover().lastIndexOf("\\") + 1);
            album.setCover(substring);
            albumDao.updateByPrimaryKey(album);
            Album album1 = albumDao.selectByPrimaryKey(album);
            String realPath = request.getSession().getServletContext().getRealPath("/back/album_img");
            new File(realPath,album1.getCover()).delete();
        }
    }

    @Override
    public void delete(Album album, HttpServletRequest request) {
        Album album1 = albumDao.selectByPrimaryKey(album);
        albumDao.delete(album);
        String realPath = request.getSession().getServletContext().getRealPath("/back/album_img");
        new File(realPath,album1.getCover()).delete();
    }
}
