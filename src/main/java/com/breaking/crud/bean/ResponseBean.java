package com.breaking.crud.bean;

import java.util.HashMap;

public class ResponseBean {
	
	public static final int CODE_SUCCESS = 100;
	
	public static final int CODE_FAIL = 300;

	private int code;
	
	private String msg;
	
	HashMap<String, Object> data = new HashMap<>();
	
	public static ResponseBean success() {
		ResponseBean responseBean = new ResponseBean();
		responseBean.setCode(CODE_SUCCESS);
		return responseBean;
	}
	
	public static ResponseBean fail() {
		ResponseBean responseBean = new ResponseBean();
		responseBean.setCode(CODE_FAIL);
		return responseBean;
	}

	public ResponseBean setData(String key,Object value) {
		getData().put(key, value);
		return this;
	}
	
	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public HashMap<String, Object> getData() {
		return data;
	}

	public void setData(HashMap<String, Object> data) {
		this.data = data;
	}
	
	
}
