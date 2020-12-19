#!/bin/bash

# Updated script from https://github.com/mmonkey/docker-sponge

export FORGE_URL="http://files.minecraftforge.net/maven/net/minecraftforge/forge/${FORGE_VERSION}/forge-${FORGE_VERSION}-universal.jar"
export SPONGE_URL="http://files.minecraftforge.net/maven/org/spongepowered/spongeforge/${SPONGE_VERSION}/spongeforge-${SPONGE_VERSION}.jar"
export EXECUTABLE_JAR="forge-${FORGE_VERSION}-universal.jar"

if [ ! -f "/forge/${EXECUTABLE_JAR}" ]; then
	cd /forge
	wget -O ${EXECUTABLE_JAR} "${FORGE_URL}"
fi

if [ ! -f "/forge/server.properties" ]; then
	echo "server-port=${MINECRAFT_PORT}" > /forge/server.properties
fi

if [ -n "${MINECRAFT_EULA}" ]; then
	echo "eula=${MINECRAFT_EULA}" > /forge/eula.txt
fi

if [ ! -d "/forge/mods/" ]; then
	mkdir -p /forge/mods
fi

if [ ! -f "/forge/mods/spongeforge-${SPONGE_VERSION}.jar" ]; then
	wget -O /forge/mods/spongeforge-${SPONGE_VERSION}.jar "${SPONGE_URL}"
fi

STARTCOMMAND="java"
if [ -n "${MINECRAFT_MAXHEAP}" ]; then
  STARTCOMMAND="${STARTCOMMAND} -Xmx${MINECRAFT_MAXHEAP}"
fi

STARTCOMMAND="${STARTCOMMAND} -jar ${EXECUTABLE_JAR} nogui"
cd /forge && exec ${STARTCOMMAND}
