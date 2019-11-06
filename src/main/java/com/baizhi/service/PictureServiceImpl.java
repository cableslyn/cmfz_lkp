package com.baizhi.service;

import com.baizhi.dao.PictureDao;
import com.baizhi.entity.Picture;
import com.baizhi.annotation.redisCache;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class PictureServiceImpl implements PictureService {
    @Autowired
    private PictureDao pictureDao;

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    @redisCache
    public List<Picture> findAll(Integer page, Integer rows) {
        Picture picture = new Picture();
        RowBounds rb = new RowBounds((page-1)*rows,rows);
        List<Picture> pictures = pictureDao.selectByRowBounds(picture, rb);
        return pictures;
    }

    @Override
    public void save(Picture picture){
        picture.setId(UUID.randomUUID().toString());
        picture.setCreatedate(new Date());
        String substring = picture.getCover().substring(picture.getCover().lastIndexOf("\\") + 1);
        picture.setCover(substring);
        pictureDao.insert(picture);
    }
    @Override
    public void update(Picture picture,HttpServletRequest request){
        System.out.println(picture);
        if (picture.getCover() == null||picture.getCover().equals("")){
            Picture picture1 =pictureDao.selectByPrimaryKey(picture.getId());
            System.out.println("要修改的数据"+picture1);
            picture.setCover(picture1.getCover());
            picture.setCreatedate(new Date());
            pictureDao.updateByPrimaryKey(picture);
        }else{
            String substring = picture.getCover().substring(picture.getCover().lastIndexOf("\\") + 1);
            Picture picture1 =pictureDao.selectByPrimaryKey(picture.getId());
            picture.setCover(substring);
            picture.setCreatedate(new Date());
            pictureDao.updateByPrimaryKey(picture);
            String realPath = request.getSession().getServletContext().getRealPath("/back/picture");
            new File(realPath,picture1.getCover()).delete();
        }
    }

    @Override
    public void delete(Picture picture,HttpServletRequest request) {
        Picture picture1 = pictureDao.selectByPrimaryKey(picture.getId());
        System.out.println("要删除的数据"+picture1);
        pictureDao.delete(picture);
        String realPath = request.getSession().getServletContext().getRealPath("/back/picture");
        new File(realPath,picture1.getCover()).delete();
    }
    @Override
    public int findCount(Picture picture) {
        return pictureDao.selectCount(picture);
    }
}
