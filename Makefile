# Build the docs for the proto3 definition.

LANGUAGES=cpp java go csharp objc python php ruby js

bindings:
	for x in ${LANGUAGES}; do \
		mkdir -p $${x}; \
		protoc --proto_path proto proto/com/iabtechlab/openrtb/v3/openrtb.proto --$${x}_out=$${x}; \
	done

check:
	prototool lint

clean:
	for x in ${LANGUAGES}; do \
		rm -fr $${x}/*; \
	done

docs:
	docker run --rm \
		-v ${PWD}/doc:/out \
		-v ${PWD}/proto:/protos \
		pseudomuto/protoc-gen-doc --doc_opt=markdown,README.md --proto_path=/protos \
		com/iabtechlab/openrtb/v3/request.proto \
		com/iabtechlab/openrtb/v3/response.proto \
		com/iabtechlab/openrtb/v3/openrtb.proto

watch:
	fswatch  -r ./proto/ | xargs -n1 make docs
