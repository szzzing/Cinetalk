package com.kh.cinetalk.hangout.model.exception;

public class HangoutException extends RuntimeException {
	public HangoutException() {}
	public HangoutException(String msg) {
		super(msg);
	}
}