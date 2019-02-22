# Build the docs for the proto3 definition.

docs:
	docker run --rm \
  -v ${PWD}/doc:/out \
  -v ${PWD}/proto/com/iab/openrtb:/protos \
  pseudomuto/protoc-gen-doc --doc_opt=markdown,docs.md

watch:
	fswatch ./proto/*.proto | xargs -n1 make docs
