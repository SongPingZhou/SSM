package com.spz.service;

import com.spz.entity.Student;

public interface ConsultingManagerService {
	String selectStuAll(Student student);
	
	/**
	 * 根据客户id删除
	 * @param s_id
	 * @return
	 */
	Integer deleteStu(Integer s_id);
	/**
	 * 修改客户
	 * @param student
	 * @return
	 */
	Integer updateStu(Student student);
	/**
	 * 添加客户
	 * @param student
	 * @return
	 */
	Integer insertStu(Student student);
	/**
	 * 根据客户id查询
	 * @param s_id
	 * @return
	 */
	Student selectStuByid(Integer s_id);
}
