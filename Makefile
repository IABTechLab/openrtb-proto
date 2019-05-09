# Build the docs for the proto3 definition.

bindings:
	mkdir -p java go
	protoc --proto_path proto proto/com/iabtechlab/openrtb/v3/openrtb.proto --java_out=java --go_out=go

check:
	prototool lint

clean:
	rm -fr java/com && \
	rm -fr go/proto

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
