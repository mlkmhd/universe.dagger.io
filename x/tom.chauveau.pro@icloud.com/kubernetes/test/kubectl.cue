package kubernetes

import (
	"github.com/mlkmhd/dagger.io/dagger"

	"github.com/mlkmhd/universe.dagger.io/docker"
	"github.com/mlkmhd/universe.dagger.io/x/tom.chauveau.pro@icloud.com/kubernetes"
)

dagger.#Plan & {
	actions: test: kubectl: {
		simple: {
			_image: kubernetes.#Kubectl

			verify: docker.#Run & {
				input: _image.output
				user:  "root"
				command: {
					name: "-c"
					args: ["""
							kubectl version >> /version.txt || true
						"""]
				}
				entrypoint: ["/bin/sh"]
				export: files: "/version.txt": _ & =~"v1.23.5"
			}
		}

		custom: {
			_image: kubernetes.#Kubectl & {
				version: "1.21.12"
			}

			verify: docker.#Run & {
				input: _image.output
				user:  "root"
				command: {
					name: "-c"
					args: ["""
							kubectl version >> /version.txt || true
						"""]
				}
				entrypoint: ["/bin/sh"]
				export: files: "/version.txt": _ & =~"v1.21.12"
			}
		}
	}
}
