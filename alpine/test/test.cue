package alpine

import (
	"github.com/mlkmhd/dagger.io/dagger"
	"github.com/mlkmhd/dagger.io/dagger/core"

	"github.com/mlkmhd/universe.dagger.io/alpine"
	"github.com/mlkmhd/universe.dagger.io/docker"
)

dagger.#Plan & {
	actions: test: {
		// Test: customize alpine version
		alpineVersion: {
			build: alpine.#Build & {
				// install an old version on purpose
				version: "3.10.9"
			}

			verify: core.#ReadFile & {
				input:    build.output.rootfs
				path:     "/etc/alpine-release"
				contents: "3.10.9\n"
			}
		}

		// Test: install packages
		packageInstall: {
			build: alpine.#Build & {
				packages: {
					jq: {}
					curl: {}
				}
			}

			check: docker.#Run & {
				input: build.output
				command: {
					name: "sh"
					flags: "-c": """
						jq --version > /jq-version.txt
						curl --version > /curl-version.txt
						"""
				}

				export: files: {
					"/jq-version.txt":   =~"^jq"
					"/curl-version.txt": =~"^curl"
				}
			}
		}
	}
}
