apiVersion: v1
kind: Config
clusters:
- name: "local"
  cluster:
    server: "https://rancher.konstantiniyye.studio/k8s/clusters/local"
users:
- name: "local"
  user:
    token: "kubeconfig-user-clv7s5hbvd:b8nmf5j2h9c8hk2sx9zrdnjfsbmn8v4rdfkmwsrp7btl2rf7jcnn7v"
contexts:
- name: "local"
  context:
    user: "local"
    cluster: "local"
current-context: "local"