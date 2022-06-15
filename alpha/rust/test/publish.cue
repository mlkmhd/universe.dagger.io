package rust

import (
	"github.com/mlkmhd/dagger.io/dagger"
	"github.com/mlkmhd/universe.dagger.io/x/contact@kjuulh.io/rust"
)

dagger.#Plan & {
	client: filesystem: "./data/hello": read: contents: dagger.#FS

	actions: test: publish: rust.#Publish & {
		source: client.filesystem."./data/hello".read.contents
	}
}
