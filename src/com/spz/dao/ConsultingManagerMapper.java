package com.spz.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spz.entity.Student;

public interface ConsultingManagerMapper {
	/**
	 * 多条件分页查询所有
	 * @param student
	 * @return
	 */
	List<Student> selectStuAll(Student student);
	/**
	 * 查询总条数
	 * @param student
	 * @return
	 */
	Integer selectStuCount(Student student);
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
