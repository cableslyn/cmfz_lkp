package com.baizhi.service;

import com.baizhi.dao.StarDao;
import com.baizhi.entity.Star;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.List;
import java.util.UUID;

@Service("starService")
@Transactional
public class StarServiceImpl implements StarService {
    @Autowired
    private StarDao starDao;
    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public List<Star> findAll(Integer page, Integer rows) {
        Star star = new Star();
        RowBounds rowBounds = new RowBounds((page-1)*rows,rows);
        List<Star> stars = starDao.selectByRowBounds(star, rowBounds);
        return stars;
    }
    @Override
    public int pageCount(Star star){
        int i = starDao.selectCount(star);
        return i;
    }

    @Override
    public void save(Star star) {
        star.setId(UUID.randomUUID().toString());
        String substring = star.getPhoto().substring(star.getPhoto().lastIndexOf("\\") + 1);
        star.setPhoto(substring);
        starDao.insert(star);
    }

    @Override
    public void update(Star star, HttpServletRequest request) {
        if (star.getPhoto()==null ||star.getPhoto().equals("")){
            Star star1 = starDao.selectByPrimaryKey(star.getId());
            star.setPhoto(star1.getPhoto());
            starDao.updateByPrimaryKey(star);
        }else{
            String substring = star.getPhoto().substring(star.getPhoto().lastIndexOf("\\") + 1);
            Star star1 = starDao.selectByPrimaryKey(star.getId());
            star.setPhoto(substring);
            starDao.updateByPrimaryKey(star);
            String realPath = request.getSession().getServletContext().getRealPath("/back/star_img");
            new File(realPath,star1.getPhoto()).delete();
        }


    }

    @Override
    public void delete(Star star, HttpServletRequest request) {
        Star star1 = starDao.selectByPrimaryKey(star);
        starDao.delete(star);
        String realPath = request.getSession().getServletContext().getRealPath("/back/star_img");
        new File(realPath,star1.getPhoto()).delete();
    }

    @Override
    public List<Star> findAll() {
        List<Star> stars = starDao.selectAll();
        return stars;
    }

    @Override
    public Star findOne(String id) {
        return starDao.selectByPrimaryKey(id);
    }
}
