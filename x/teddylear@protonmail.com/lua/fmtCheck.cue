package lua

import (
	"github.com/mlkmhd/dagger.io/dagger"
	"github.com/mlkmhd/universe.dagger.io/docker"
)

// Checks lua format via Stylua
#StyluaCheck: {
	// Files to Copy
	source: dagger.#FS

	// Any extra formatting args
	extraArgs: [...string]

	_run: docker.#Build & {
		steps: [
			docker.#Pull & {
				source: "rust:latest"
			},

			docker.#Run & {
				command: {
					name: "cargo"
					args: ["install", "stylua"]
				}
			},

			docker.#Copy & {
				dest:     "/tmp"
				contents: source
			},

			docker.#Run & {
				command: {
					name: "stylua"
					args: ["--check", "."] + extraArgs
				}
				workdir: "/tmp"
			},
		]
	}
}
