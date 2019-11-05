package com.baizhi.service;

import com.baizhi.dao.UserDao;
import com.baizhi.entity.User;
import com.baizhi.entity.UserCount;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("userService")
@Transactional
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;
    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public Map<String ,Object> findAll(Integer page, Integer rows,String starId) {
        User user = new User();
        if (starId == null||starId.equals("")){
            RowBounds rowBounds = new RowBounds((page - 1) * rows, rows);
            List<User> users = userDao.selectByRowBounds(user, rowBounds);
            Map<String, Object> map = new HashMap<>();
            int count = userDao.selectCount(user);
            map.put("page",page);
            map.put("rows",users);
            map.put("total",count%rows==0?count/rows:count/rows+1);
            map.put("records",count);
            return map;
        }else{
            user.setStarId(starId);
            RowBounds rowBounds = new RowBounds((page - 1) * rows, rows);
            List<User> users = userDao.selectByRowBounds(user, rowBounds);
            Map<String, Object> map = new HashMap<>();
            int count = userDao.selectCount(user);
            map.put("page",page);
            map.put("rows",users);
            map.put("total",count%rows==0?count/rows:count/rows+1);
            map.put("records",count);
            return map;
        }

    }
    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public List<User> findAll() {
        return userDao.selectAll();
    }

    @Override
    public Integer[] selectUserCount(String sex) {
        Integer[]a=new Integer[12];
        List<UserCount> userCounts = userDao.selectUserCount(sex);
        for (UserCount userCount : userCounts) {
            Integer month = userCount.getMonth();
            for (int i = 0; i < 12; i++) {
                if (month==i+1){
                    a[i]=userCount.getCount();
                }
            }
        }
        return a;
    }
}
