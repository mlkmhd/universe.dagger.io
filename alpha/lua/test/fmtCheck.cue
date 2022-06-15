package lua

import (
	"github.com/mlkmhd/dagger.io/dagger"
	"github.com/mlkmhd/universe.dagger.io/x/teddylear@protonmail.com/lua"
)

dagger.#Plan & {
	client: filesystem: "./data/hello": read: contents: dagger.#FS

	actions: test: simple: fmtCheck: lua.#StyluaCheck & {
		source: client.filesystem."./data/hello".read.contents
	}
}
