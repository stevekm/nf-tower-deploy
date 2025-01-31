SHELL:=/bin/bash
UNAME:=$(shell uname)

ifeq ($(UNAME), Darwin)
JDK_DIR:=openjdk-8.0.152-h393ad39_1
JDK_GZ:=$(JDK_DIR).tar.bz2
JDK_URL:=https://anaconda.org/anaconda/openjdk/8.0.152/download/osx-64/$(JDK_GZ)
export JAVA_HOME:=$(CURDIR)/$(JDK_DIR)
export PATH:=$(JAVA_HOME)/bin:$(PATH)
endif

# have not tested this yet
ifeq ($(UNAME), Linux)
FOO:=$(shell echo this does not work yet; exit 1)
# JDK_GZ:=openjdk-12.0.2_linux-x64_bin.tar.gz
# JAVA_HOME:=jdk-12.0.2
# # JDK_URL:=https://download.java.net/java/GA/jdk12.0.2/e482c34c86bd4bf8b56c0b35558996b9/10/GPL/$(JDK_GZ)
# export PATH:=$(JAVA_HOME):$(PATH)
endif

$(JAVA_HOME):
	mkdir -p "$(JAVA_HOME)" && \
	cd "$(JAVA_HOME)" && \
	wget $(JDK_URL) && \
	tar -xzf $(JDK_GZ)

# 0a8b455d9c85ac835664dd95344b5f5c07a72d59
nf-tower:
	git clone https://github.com/seqeralabs/nf-tower.git

install: $(JAVA_HOME) nf-tower

init: install
	git submodule update --recursive --remote --init

# this works once you get the Java set up
build: nf-tower
	cd nf-tower && \
	make build

export TOWER_SMTP_USER=username
export TOWER_SMTP_PASSWORD=password
run: nf-tower
	cd nf-tower && make run

# TODO: need to get dump STMP servers running in order to catch the dump token email and then click the link to get the dumb token; try looking in this! https://stackoverflow.com/questions/11174682/how-to-setup-an-smtp-server-on-mac-os-x/58406183#58406183

test:
	which java
	java -version

bash:
	bash

# nf-tower$ ./gradlew tower-backend:run --continuous



# export DOCKERTAG:=java
# build:
# 	docker build -t "$(DOCKERTAG)" .




# all these versions of Java did not work to build & run Nextflow tower on Mac
# JDK_GZ:=openjdk-12.0.2_osx-x64_bin.tar.gz
# JAVA_HOME:=jdk-12.0.2.jdk/Contents/Home/
# JDK_URL:=https://download.java.net/java/GA/jdk12.0.2/e482c34c86bd4bf8b56c0b35558996b9/10/GPL/$(JDK_GZ)

# JDK_GZ:=openjdk-11.0.2_osx-x64_bin.tar.gz
# JAVA_HOME:=jdk-11.0.2.jdk/Contents/Home
# JDK_URL:=https://download.java.net/java/GA/jdk11/9/GPL/$(JDK_GZ)

# JDK_GZ:=openjdk-9.0.4_osx-x64_bin.tar.gz
# JAVA_HOME:=jdk-9.0.4.jdk/Contents/Home
# JDK_URL:=https://download.java.net/java/GA/jdk9/9.0.4/binaries/$(JDK_GZ)
# https://github-production-release-asset-2e65be.s3.amazonaws.com/140418865/0308d600-3c37-11ea-84b4-862b19edd0bf?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20200228%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20200228T214303Z&X-Amz-Expires=300&X-Amz-Signature=82d95848bf63d3b0be5e69884f247b31533e5502c15bb608c645988056763532&X-Amz-SignedHeaders=host&actor_id=10505524&response-content-disposition=attachment%3B%20filename%3DOpenJDK8U-jdk_x64_mac_hotspot_8u242b08.tar.gz&response-content-type=application%2Foctet-stream
