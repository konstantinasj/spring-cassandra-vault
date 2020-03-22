package com.ktu.springcassandravault.model;

import lombok.Data;
import org.springframework.data.cassandra.core.mapping.Column;
import org.springframework.data.cassandra.core.mapping.PrimaryKey;
import org.springframework.data.cassandra.core.mapping.Table;

@Table("songs")
@Data
public class SongEntity {

	@PrimaryKey("id")
	private int id;

	@Column("title")
	private String title;

}
