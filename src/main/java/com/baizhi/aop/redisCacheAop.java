package com.baizhi.aop;

import com.alibaba.fastjson.JSONObject;
import com.baizhi.annotation.redisCache;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import redis.clients.jedis.Jedis;

import java.lang.reflect.Method;
import java.util.Set;

@Configuration
@Aspect
public class redisCacheAop {

    @Autowired
    private Jedis jedis;

    @Around("execution(* com.baizhi.service.*impl.findAll(..))")
    public Object around(ProceedingJoinPoint proceedingJoinPoint) throws Throwable {
        Object target = proceedingJoinPoint.getTarget();
        MethodSignature methodSignature = (MethodSignature) proceedingJoinPoint.getSignature();
        Object[] args = proceedingJoinPoint.getArgs();
        Method method = methodSignature.getMethod();
        boolean annotationPresent = method.isAnnotationPresent(redisCache.class);
        if (annotationPresent) {
            String className = target.getClass().getName();
            String methodName = method.getName();
            StringBuilder stringBuilder = new StringBuilder();
            stringBuilder.append(className).append(".").append(methodName).append("(");
            for (int i = 0; i < args.length; i++) {
                stringBuilder.append(args[i]);
                if (i == args.length - 1) {
                    break;
                }
                stringBuilder.append(",");
            }
            stringBuilder.append(")");
            String key = stringBuilder.toString();
            System.out.println("key:" + key);
            if (jedis.exists(key)) {
                String result = jedis.get(key);
                return JSONObject.parse(result);
            } else {
                Object result = proceedingJoinPoint.proceed();
                jedis.set(key, JSONObject.toJSONString(result));
                return result;
            }
        }else {
//            目标方法上不存在RedisCache注解
            Object result = proceedingJoinPoint.proceed();
            return result;
        }
    }

    @Around("execution(* com.baizhi.service.*impl(..)) && !execution(* com.baizhi.service.*impl.selectAll(..))")
    public void after(JoinPoint joinPoint){

        /*Object target = joinPoint.getTarget();
        String className = target.getClass().getName();
        MethodSignature methodSignature = (MethodSignature) joinPoint.getSignature();
        Object[] args = joinPoint.getArgs();
        Method method = methodSignature.getMethod();*/
        String className = joinPoint.getTarget().getClass().getName();
        Set<String> keys = jedis.keys("*");
        for (String key : keys) {
            if (key.startsWith(className)){
                jedis.del(key);
            }
        }
        jedis.close();
    }
}
