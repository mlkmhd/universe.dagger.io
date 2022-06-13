package go

import (
	"github.com/mlkmhd/dagger.io/dagger"
	"github.com/mlkmhd/universe.dagger.io/go"
	"github.com/mlkmhd/universe.dagger.io/alpine"
)

dagger.#Plan & {
	actions: test: {
		_source: dagger.#Scratch & {}

		simple: go.#Container & {
			source: _source
			command: {
				name: "go"
				args: ["version"]
			}
		}

		override: {
			base: alpine.#Build & {
				packages: go: _
			}

			command: go.#Container & {
				input:  base.output
				source: _source
				command: {
					name: "go"
					args: ["version"]
				}
			}
		}
	}
}
