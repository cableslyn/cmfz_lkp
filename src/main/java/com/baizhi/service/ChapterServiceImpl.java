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

import java.util.*;

@Service
@Transactional
public class ChapterServiceImpl implements ChapterService {
    @Autowired
    private ChapterDao chapterDao;
    @Autowired
    private AlbumDao albumDao;
    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public Map<String, Object> findAll(Integer page, Integer rows,String albumId) {
        Chapter chapter = new Chapter();
        chapter.setAlbumId(albumId);
        RowBounds rowBounds = new RowBounds((page - 1) * rows, rows);
        List<Chapter> chapters = chapterDao.selectByRowBounds(chapter, rowBounds);
        int count = chapterDao.selectCount(chapter);
        Map<String, Object> map = new HashMap<>();
        map.put("rows",chapters);
        map.put("total",count%rows==0?count/rows:count/rows+1);
        map.put("records",count);
        map.put("page",page);
        return map;
    }

    @Override
    public String save(Chapter chapter,String albumId) {
        chapter.setId(UUID.randomUUID().toString());
        chapter.setCreateDate(new Date());
        chapter.setAlbumId(albumId);
        String substring = chapter.getName().substring(chapter.getName().lastIndexOf("\\") + 1);
        chapter.setName(substring);
        chapterDao.insert(chapter);
        Album album = albumDao.selectByPrimaryKey(albumId);
        album.setCount(album.getCount()+1);
        albumDao.updateByPrimaryKeySelective(album);
        return chapter.getId();
    }

    @Override
    public void update(Chapter chapter) {
        chapterDao.updateByPrimaryKeySelective(chapter);
    }

}
