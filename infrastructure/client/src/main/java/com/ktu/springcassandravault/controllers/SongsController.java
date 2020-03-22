package com.ktu.springcassandravault.controllers;

import com.ktu.springcassandravault.model.SongEntity;
import com.ktu.springcassandravault.services.SongsService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Flux;

@RestController
@RequestMapping("/api/songs")
public class SongsController {

	private SongsService songsService;

	public SongsController(SongsService songsService) {
		this.songsService = songsService;
	}

	@GetMapping
	public Flux<SongEntity> getSongs() {
		return songsService.getSongs();
	}

}
