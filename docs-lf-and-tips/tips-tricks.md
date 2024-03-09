

## Useful for Network Policy
The namespaceSelector from NPs works with Namespace labels, so first we check existing labels for Namespaces:

`k get ns --show-labels`

## Fast dry-run output
`export do="--dry-run=client -o yaml"`

Usage: `k run pod1 --image=nginx $do`

## Fast pod deletion
`export now="--force --grace-period 0"`

Usage: `k delete pod pod-to-del $now`

## Alias for Namespace
In addition you could define an alias like:

`alias kn='kubectl config set-context --current --namespace '`

Which allows you to define the default namespace of the current context, like this : 

`kn default`        # set default to default

`kn my-namespace`   # set default to my-namespace

## VIM settings for yaml k8s files

First create or open file `.vimrc` :
`vim ~/.vimrc`

Add this 3 lines and save the file : 

`set expandtab`     # expandtab: use spaces for tab

`set tabstop=2`     # tabstop: amount of spaces used for tab

`set shiftwidth=2`  # shiftwidth: amount of spaces used during indentation

or in one-line command : 

`echo -e "set expandtab \nset tabstop=2 \nset shiftwidth=2" > .vimrc`


Let's look into the events with some example:

`kubectl get events --sort-by='.metadata.creationTimestamp' -A`

`kubectl --context mycluster get event --field-selector involvedObject.name=pod-to-check`

`kubectl get events --field-selector involvedObject.kind=PersistentVolumeClaim`


[Tips for CKA-CKAD-CKS preparation](https://github.com/fireflycons/tips-for-CKA-CKAD-CKS)

[ProTips kubectl for CKA-CKAD-CKS preparation](https://github.com/fireflycons/tips-for-CKA-CKAD-CKS?tab=readme-ov-file#pro-tips)