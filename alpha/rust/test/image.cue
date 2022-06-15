package rust

import (
	"github.com/mlkmhd/dagger.io/dagger"
	"github.com/mlkmhd/universe.dagger.io/x/contact@kjuulh.io/rust"
	"github.com/mlkmhd/universe.dagger.io/docker"
)

dagger.#Plan & {
	actions: test: {
		_source: dagger.#Scratch

		simple: {
			// Default rust.#Image
			_image: rust.#Image

			verify: docker.#Run & {
				input: _image.output
				command: {
					name: "/bin/sh"
					args: ["-c", "cargo version | grep '1.6'"]
				}
			}
		}

		custom: {
			_image: rust.#Image & {
				version: "1.56"
			}

			verify: docker.#Run & {
				input: _image.output
				command: {
					name: "/bin/sh"
					args: ["-c", "cargo version | grep '1.56'"]
				}
			}
		}
	}
}
