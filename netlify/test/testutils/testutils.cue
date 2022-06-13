package testutils

import (
	"github.com/mlkmhd/universe.dagger.io/bash"
	"github.com/mlkmhd/universe.dagger.io/alpine"
)

// Assert the text contents available at a URL
#AssertURL: {
	url:      string
	contents: string

	run: bash.#Run & {
		input: image.output
		script: "contents": """
			test "$(curl \(url))" = "\(contents)"
			"""
	}

	image: alpine.#Build & {
		packages: {
			bash: {}
			curl: {}
		}
	}
}
