#!/bin/sh

NS_PREFIX=test-ns
NS_PER_SERVERS_COUNT=50
APP_PREFIX=app
ARGOCD_SERVERS_COUNT=5
ARGOCD_SERVERS_PREFIX=argocd-server
TOTAL_NS=$(( $NS_PER_SERVERS_COUNT * $ARGOCD_SERVERS_COUNT))
