package rust

import (
	"github.com/mlkmhd/dagger.io/dagger"
	"github.com/mlkmhd/universe.dagger.io/docker"
)

#Container: {
	// Source code
	source: dagger.#FS

	// Rust image
	_image: #Image

	_sourcePath: "/src"

	docker.#Run & {
		input:   *_image.output | docker.#Image
		workdir: _sourcePath
		command: name: "cargo"
		mounts: "source": {
			dest:     _sourcePath
			contents: source
		}
	}
}
