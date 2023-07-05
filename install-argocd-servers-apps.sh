#!/bin/sh

source ./env.sh

for i in $(seq -w $ARGOCD_SERVERS_COUNT); do
 oc create ns $ARGOCD_SERVERS_PREFIX-$i
 oc create -f argocd-server.yaml -n $ARGOCD_SERVERS_PREFIX-$i &
done


ARGOCD_SERVER_INDEX=1
for i in $(seq -w $TOTAL_NS); do
  oc create ns $NS_PREFIX-$i
  ARGOCD_NS_INDEX=$(( (10#$i - 1) / $NS_PER_SERVERS_COUNT + 1 ))
  ARGOCD_NS=$ARGOCD_SERVERS_PREFIX-$ARGOCD_NS_INDEX
  oc label ns $NS_PREFIX-$i argocd.argoproj.io/managed-by=$ARGOCD_NS &
  APP_NS=$NS_PREFIX-$i
  for j in $(seq -w $APP_PER_NS); do
    APP_NS=$NS_PREFIX-$i APP=$APP_PREFIX-$j-$APP_NS envsubst < argocd-application.yaml | oc apply -n $ARGOCD_NS -f -
  done
done

