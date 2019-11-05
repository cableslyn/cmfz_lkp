package com.baizhi.service;

import com.baizhi.dao.ArticleDao;
import com.baizhi.entity.Article;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
@Transactional
public class ArticleServiceImpl implements ArticleService {

    @Autowired
    private ArticleDao articleDao;
    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public Map<String, Object> findAll(Integer page, Integer rows) {
        Article article = new Article();
        RowBounds rowBounds = new RowBounds((page - 1) * rows, rows);
        List<Article> articles = articleDao.selectByRowBounds(article, rowBounds);
        int count = articleDao.selectCount(article);
        Map<String, Object> map = new HashMap<>();
        map.put("rows",articles);
        map.put("page",page);
        map.put("total",count%rows==0?count/rows:count/rows+1);
        map.put("records",count);
        return map;
    }

    @Override
    public void save(Article article) {
        article.setId(UUID.randomUUID().toString());
        article.setCreateDate(new Date());
        if (article.getAuthor()==null||article.getBrief()==null||article.getContent()==null||article.getAuthor().equals("")||article.getBrief().equals("")|article.getContent().equals("")){
            throw new RuntimeException("添加内容不能为空");
        }
        articleDao.insert(article);
    }

    @Override
    public void update(Article article) {
        System.out.println("更新"+article);
        if (article.getAuthor()==null||article.getBrief()==null||article.getContent()==null||article.getAuthor().equals("")||article.getBrief().equals("")|article.getContent().equals("")){
            throw new RuntimeException("内容不能为空");
        }
        articleDao.updateByPrimaryKeySelective(article);
    }

    @Override
    public void delete(Article article) {
        articleDao.delete(article);
    }
}
