package com.kh.cinetalk.common;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.Signature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LoggerAspect1 {
	private Logger logger = LoggerFactory.getLogger(LoggerAspect1.class);
	
	public void loggerAdvice(JoinPoint joinPoint) {
		Signature signature = joinPoint.getSignature();
		// Signature : 현재 AOP가 적용되는 메소드 정보
		
		String type = signature.getDeclaringTypeName();	// 실행되는 메서드가 있는 클래스의 풀네임
		String methodName = signature.getName();	// 타겟 객체의 메서드
		
		String componentName = "";
		if(type.indexOf("Controller")>-1) {
			componentName = "Controller \t: ";
		} else if(type.indexOf("Service")>-1) {
			componentName = "ServiceImpl \t: ";
		} else if(type.indexOf("DAO")>-1) {
			componentName = "DAO \t\t: ";
		}
		
		logger.debug("[Before] "+componentName+type+"."+methodName+"()");
	}
}
