#!/bin/bash -xe

echo "${certificate}" >> /etc/pki/ca-trust/source/anchors/ca.crt

sudo update-ca-trust force-enable
sudo update-ca-trust extract

# echo '13.209.253.89 724227285840.dkr.ecr.ap-northeast-2.amazonaws.com' | sudo tee -a /etc/hosts

# Bootstrap and join the cluster
/etc/eks/bootstrap.sh \
	--b64-cluster-ca '${cluster_auth_base64}' \
	--apiserver-endpoint '${endpoint}' \
	'${cluster_name}'