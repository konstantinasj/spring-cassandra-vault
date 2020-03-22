package com.ktu.springcassandravault.services;

import com.ktu.springcassandravault.model.SongEntity;
import com.ktu.springcassandravault.repositories.SongsRepository;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;

@Service
public class SongsService {

	private SongsRepository songsRepository;

	public SongsService(SongsRepository songsRepository) {
		this.songsRepository = songsRepository;
	}

	public Flux<SongEntity> getSongs() {
		return songsRepository.findAll();
	}
}
