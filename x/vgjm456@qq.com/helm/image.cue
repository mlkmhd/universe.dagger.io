package helm

import (
	"github.com/mlkmhd/universe.dagger.io/docker"
)

#Image: {
	version: string | *"latest"

	docker.#Pull & {
		source: "index.docker.io/alpine/helm:\(version)"
	}
}
