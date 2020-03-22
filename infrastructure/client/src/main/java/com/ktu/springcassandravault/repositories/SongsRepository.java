package com.ktu.springcassandravault.repositories;

import com.ktu.springcassandravault.model.SongEntity;
import org.springframework.data.cassandra.repository.ReactiveCassandraRepository;

public interface SongsRepository extends ReactiveCassandraRepository<SongEntity, Integer> {
}
