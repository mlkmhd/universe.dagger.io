package dotnet

import (
	"github.com/mlkmhd/dagger.io/dagger"
	"github.com/mlkmhd/dagger.io/dagger/core"
	"github.com/mlkmhd/universe.dagger.io/x/olli.janatuinen@gmail.com/dotnet"
	"github.com/mlkmhd/universe.dagger.io/docker"
	"github.com/mlkmhd/universe.dagger.io/alpine"
)

dagger.#Plan & {
	client: filesystem: "./data": read: contents: dagger.#FS

	actions: test: {
		_baseImage: {
			build: alpine.#Build & {
				packages: {
					"ca-certificates": {}
					"krb5-libs": {}
					libgcc: {}
					libintl: {}
					"libssl1.1": {}
					"libstdc++": {}
					zlib: {}
				}
			}
			output: build.output
		}

		simple: {
			publish: dotnet.#Publish & {
				source:  client.filesystem."./data".read.contents
				package: "hello"
			}

			exec: docker.#Run & {
				input: _baseImage.output
				command: {
					name: "/bin/sh"
					args: ["-c", "/app/hello >> /output.txt"]
				}
				env: NAME: "dagger"
				mounts: binary: {
					dest:     "/app"
					contents: publish.output
					source:   "/"
				}
			}

			verify: core.#ReadFile & {
				input: exec.output.rootfs
				path:  "/output.txt"
			} & {
				contents: "Hi dagger!"
			}
		}
	}
}
