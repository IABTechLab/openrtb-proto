# Build the docs for the proto3 definition.

bindings:
	protoc --proto_path proto proto/com/iabtechlab/openrtb/openrtb.proto --java_out=java --go_out=go

check:
	prototool lint

clean:
	rm -fr java/com && \
	rm -fr go/proto

docs:
	docker run --rm \
  -v ${PWD}/doc:/out \
  -v ${PWD}/:/protos \
  pseudomuto/protoc-gen-doc --doc_opt=markdown,README.md \
	proto/com/iabtechlab/openrtb/*.proto

watch:
	fswatch  -r ./proto/ | xargs -n1 make docs
