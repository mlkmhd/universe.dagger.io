package rawkode_kubernetes_example

import (
	"github.com/mlkmhd/dagger.io/dagger"
	"github.com/mlkmhd/dagger.io/dagger/core"
	"github.com/mlkmhd/universe.dagger.io/x/david@rawkode.dev/kubernetes:kubectl"
)

dagger.#Plan & {
	client: {
		filesystem: "./": read: contents: dagger.#FS
		commands: kubeconfig: {
			name: "kubectl"
			args: ["config", "view", "--raw"]
			stdout: dagger.#Secret
		}
	}

	actions: rawkode: kubectl.#Apply & {
		_contents: core.#Subdir & {
			input: client.filesystem."./".read.contents
			path:  "/kubernetes"
		}
		manifests:        _contents.output
		kubeconfigSecret: client.commands.kubeconfig.stdout
	}
}
