REGISTRY_IMAGE ?= ghcr.io/markentier/utilities

export DOCKER_BUILDKIT = 1

# either of: linux/amd64, linux/arm64
DOCKER_BUILD_PLATFORM ?= linux/amd64

BUILDX_FLAGS ?=

# all-in-one must come last, as it depends on the other images
PROJECTS = \
	magicpak \
	upx \
	sccache \
	busybox \
	all-in-one

default:
	@echo "Usage: make image <utility name> - build a single utility image"
	@echo "Usage: make all - build all utility images and the all-in-one image"

### remote registry - multi-platform image builds

image.ghcr:
	docker buildx build \
		--progress=plain \
		--build-arg REGISTRY_IMAGE=$(REGISTRY_IMAGE) \
		--build-arg UTILITY_IMAGE=$(UTILITY_IMAGE) \
		--build-arg UTILITY_VERSION=$(UTILITY_VERSION) \
		--tag $(REGISTRY_IMAGE):$(UTILITY_IMAGE) \
		--platform linux/amd64,linux/arm64 \
		$(BUILDX_FLAGS) \
		--output=type=registry .

all.ghcr:
	rootdir=$$(pwd); \
	for project in $(PROJECTS); do \
		cd $$rootdir/utilities/$$project; \
		$(MAKE) image.ghcr; \
	done

login:
	@echo $(GHCR_PAT) | docker login ghcr.io -u asaaki --password-stdin

### local - only single platform, as docker does not support multi-platform images locally

image:
	docker build \
	--progress plain \
	--platform $(DOCKER_BUILD_PLATFORM) \
	--build-arg REGISTRY_IMAGE=$(REGISTRY_IMAGE) \
	--build-arg UTILITY_IMAGE=$(UTILITY_IMAGE) \
	--build-arg UTILITY_VERSION=$(UTILITY_VERSION) \
	-t $(REGISTRY_IMAGE):$(UTILITY_IMAGE) .

all: $(PROJECTS)

$(PROJECTS): %:
	cd utilities/$@ && \
		$(MAKE) image DOCKER_BUILD_PLATFORM=$(DOCKER_BUILD_PLATFORM)
