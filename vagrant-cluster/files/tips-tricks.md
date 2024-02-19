

## Useful for Network Policy
The namespaceSelector from NPs works with Namespace labels, so first we check existing labels for Namespaces:

`k get ns --show-labels`

## Fast dry-run output
`export do="--dry-run=client -o yaml"`

Usage: `k run pod1 --image=nginx $do`

## Fast pod deletion
`export now="--force --grace-period 0"`

Usage: `k delete pod1 $now`

## Alias for Namespace
In addition you could define an alias like:

`alias kn='kubectl config set-context --current --namespace '`

Which allows you to define the default namespace of the current context, like this : 

`kn default`        # set default to default

`kn my-namespace`   # set default to my-namespace



