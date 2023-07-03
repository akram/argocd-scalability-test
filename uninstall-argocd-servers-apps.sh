#!/bin/sh

source ./env.sh

for i in $(seq -w $ARGOCD_SERVERS_COUNT); do
 oc delete ns $ARGOCD_SERVERS_PREFIX-$i &
done


ARGOCD_SERVER_INDEX=1
for i in $(seq -w $TOTAL_NS); do
  oc delete ns $NS_PREFIX-$i &  
done

