package test

import (
	"github.com/mlkmhd/dagger.io/dagger"
	"github.com/mlkmhd/universe.dagger.io/aws"
	"github.com/mlkmhd/universe.dagger.io/docker"
)

dagger.#Plan & {
	actions: {
		build: aws.#Build

		getVersion: docker.#Run & {
			always: true
			input:  build.output
			command: {
				name: "sh"
				flags: "-c": "aws --version > /output.txt"
			}
			export: files: "/output.txt": =~"^aws-cli/\(aws.#DefaultCliVersion)"
		}
	}
}
