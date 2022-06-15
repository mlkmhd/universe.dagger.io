package kustomize

import (
	"github.com/mlkmhd/universe.dagger.io/docker"
	"github.com/mlkmhd/universe.dagger.io/alpine"
	"github.com/mlkmhd/universe.dagger.io/bash"
)

#Image: {
	// Kustomize binary version
	version: *"3.8.7" | string

	docker.#Build & {
		steps: [
			alpine.#Build & {
				packages: {
					bash: {}
					curl: {}
				}
			},
			bash.#Run & {
				env: VERSION: version
				script: contents: #"""
					# download Kustomize binary
					curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash -s $VERSION && mv kustomize /usr/local/bin
					"""#
			},
		]
	}
}
