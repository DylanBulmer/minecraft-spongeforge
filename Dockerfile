FROM java:8

ENV MINECRAFT_PORT 25565
ENV MINECRAFT_EULA true
ENV MINECRAFT_MAXHEAP 2048M

ENV FORGE_VERSION 1.12.2-14.23.5.2838
ENV FORGE_URL https://files.minecraftforge.net/maven/net/minecraftforge/forge/${FORGE_VERSION}/forge-${FORGE_VERSION}-installer.jar

ENV SPONGE_VERSION 1.12.2-2838-7.3.0
ENV SPONGE_URL https://repo.spongepowered.org/maven/org/spongepowered/spongeforge/${SPONGE_VERSION}/spongeforge-${SPONGE_VERSION}.jar

ENV EXECUTABLE_JAR forge-${FORGE_VERSION}-universal.jar

RUN DEBIAN_FRONTEND=noninteractive
WORKDIR "/forge"

ADD ./scripts/start.sh /start_forge
RUN chmod +x /start_forge

EXPOSE ${MINECRAFT_PORT}
CMD ["/start_forge"]
