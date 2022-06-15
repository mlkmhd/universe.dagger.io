package dotnet

import (
	"github.com/mlkmhd/dagger.io/dagger"
	"github.com/mlkmhd/universe.dagger.io/x/olli.janatuinen@gmail.com/dotnet"
	"github.com/mlkmhd/universe.dagger.io/docker"
)

dagger.#Plan & {
	actions: test: {
		_source: dagger.#Scratch & {}

		simple: {
			_image: dotnet.#Image & {}

			verify: docker.#Run & {
				input: _image.output
				command: {
					name: "/bin/sh"
					args: ["-c", "dotnet --list-sdks | grep '6.0'"]
				}
			}
		}

		custom: {
			_image: dotnet.#Image & {
				version: "5.0"
			}

			verify: docker.#Run & {
				input: _image.output
				command: {
					name: "/bin/sh"
					args: ["-c", "dotnet --list-sdks | grep '5.0'"]
				}
			}
		}
	}
}
