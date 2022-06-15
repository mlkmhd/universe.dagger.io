package dotnet

import (
	"github.com/mlkmhd/dagger.io/dagger"
	"github.com/mlkmhd/universe.dagger.io/x/olli.janatuinen@gmail.com/dotnet"
)

dagger.#Plan & {
	client: filesystem: "./data": read: contents: dagger.#FS

	actions: test: dotnet.#Test & {
		source:  client.filesystem."./data".read.contents
		package: "./Greeting.Tests"
	}
}
