# Protocol Documentation
<a name="top"/>

## Table of Contents

- [com/iabtechlab/openrtb/request.proto](#com/iabtechlab/openrtb/request.proto)
    - [Deal](#com.iabtechlab.openrtb.Deal)
    - [Item](#com.iabtechlab.openrtb.Item)
    - [Metric](#com.iabtechlab.openrtb.Metric)
    - [Request](#com.iabtechlab.openrtb.Request)
    - [Source](#com.iabtechlab.openrtb.Source)
  
  
  
  

- [com/iabtechlab/openrtb/response.proto](#com/iabtechlab/openrtb/response.proto)
    - [Bid](#com.iabtechlab.openrtb.Bid)
    - [Macro](#com.iabtechlab.openrtb.Macro)
    - [Response](#com.iabtechlab.openrtb.Response)
    - [SeatBid](#com.iabtechlab.openrtb.SeatBid)
  
  
  
  

- [com/iabtechlab/openrtb/openrtb.proto](#com/iabtechlab/openrtb/openrtb.proto)
    - [Openrtb](#com.iabtechlab.openrtb.Openrtb)
  
  
  
  

- [Scalar Value Types](#scalar-value-types)



<a name="com/iabtechlab/openrtb/request.proto"/>
<p align="right"><a href="#top">Top</a></p>

## com/iabtechlab/openrtb/request.proto
The request object contains minimal high level attributes (e.g., its ID, test
mode, auction type, maximum auction time, buyer restrictions, etc.) and
subordinate objects that cover the source of the request and the actual offer
of sale. The latter includes the item(s) being offered and any applicable
deals.

There are two points in this model that interface to Layer-4 domain objects:
the Request object and the Item object. Domain objects included under Request
would include those that provide context for the overall offer. These would
include objects that describe the site or app, the device, the user, and
others. Domain objects included in an Item object would specify details about
the item being offered (e.g., the impression opportunity) and specifications
and restrictions on the media that can be associated with acceptable bids.


<a name="com.iabtechlab.openrtb.Deal"/>

### Deal
This object constitutes a specific deal that was struck a priori between
a seller and a buyer. Its presence indicates that this item is available
under the terms of that deal.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [string](#string) |  | A unique identifier for the deal. |
| flr | [float](#float) |  | Minimum deal price for this item expressed in CPM. |
| flrcur | [string](#string) |  | Currency of the flr attribute specified using ISO-4217 alpha codes. |
| at | [uint32](#uint32) |  | Optional override of the overall auction type of the request, where 1 = First Price, 2 = Second Price Plus, 3 = the value passed in flr is the agreed upon deal price. Additional auction types can be defined by the exchange using 500&#43; values. |
| wseat | [string](#string) | repeated | Whitelist of buyer seats allowed to bid on this deal. IDs of seats and the buyer’s customers to which they refer must be coordinated between bidders and the exchange a priori. Omission implies no restrictions. |
| wadomain | [string](#string) | repeated | Array of advertiser domains (e.g., advertiser.com) allowed to bid on this deal. Omission implies no restrictions. |
| ext | [google.protobuf.Any](#google.protobuf.Any) |  | Optional exchange-specific extensions. |






<a name="com.iabtechlab.openrtb.Item"/>

### Item
This object represents a unit of goods being offered for sale either on the
open market or in relation to a private marketplace deal. The id attribute is
required since there may be multiple items being offered in the same bid
request and bids must reference the specific item of interest. This object
interfaces to Layer-4 domain objects for deeper specification of the item
being offered (e.g., an impression).


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [string](#string) |  | A unique identifier for this item within the context of the offer (typically starts with “1” and increments). |
| qty | [uint32](#uint32) |  | The number of instances (i.e., “quantity”) of this item being offered (e.g., multiple identical impressions in a digital out-of-home scenario). |
| seq | [uint32](#uint32) |  | If multiple items are offered in the same bid request, the sequence number allows for the coordinated delivery. |
| flr | [float](#float) |  | Minimum bid price for this item expressed in CPM. |
| flrcur | [string](#string) |  | Currency of the flr attribute specified using ISO-4217 alpha codes. |
| exp | [uint64](#uint64) |  | Advisory as to the number of seconds that may elapse between auction and fulfilment. |
| dt | [uint64](#uint64) |  | Timestamp when the item is expected to be fulfilled (e.g. when a DOOH impression will be displayed) in Unix format (i.e., milliseconds since the epoch). |
| dlvy | [uint32](#uint32) |  | Item (e.g., an Ad object) delivery method required, where 0 = either method, 1 = the item must be sent as part of the transaction (e.g., by value in the bid itself, fetched by URL included in the bid), and 2 = an item previously uploaded to the exchange must be referenced by its ID. Note that if an exchange does not supported prior upload, then the default of 0 is effectively the same as 1 since there can be no items to reference. |
| metric | [Metric](#com.iabtechlab.openrtb.Metric) | repeated | An array of Metric objects. Refer to Object: Metric. |
| deal | [Deal](#com.iabtechlab.openrtb.Deal) | repeated | Array of Deal objects that convey special terms applicable to this item. Refer to Object: Deal. |
| private | [bool](#bool) |  | Indicator of auction eligibility to seats named in Deal objects, where 0 = all bids are accepted, 1 = bids are restricted to the deals specified and the terms thereof. |
| spec | [google.protobuf.Any](#google.protobuf.Any) |  | Layer-4 domain object structure that provides specifies the item being offered conforming to the specification and version referenced in openrtb.domainspec and openrtb.domainver. For AdCOM v1.x, the objects allowed here are Placement and any objects subordinate to these as specified by AdCOM. |
| ext | [google.protobuf.Any](#google.protobuf.Any) |  | Optional exchange-specific extensions. |






<a name="com.iabtechlab.openrtb.Metric"/>

### Metric
This object is associated with an item as an array of metrics. These metrics
can offer insight to assist with decisioning such as average recent
viewability, click-through rate, etc. Each metric is identified by its type,
reports the value of the metric, and optionally identifies the source or
vendor measuring the value.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| type | [string](#string) |  | Type of metric being presented using exchange curated string names which should be published to bidders a priori. |
| value | [float](#float) |  | Number representing the value of the metric. Probabilities must be in the range 0.0 – 1.0. |
| vendor | [string](#string) |  | Source of the value using exchange curated string names which should be published to bidders a priori. If the exchange itself is the source versus a third party, “EXCHANGE” is recommended. |
| ext | [google.protobuf.Any](#google.protobuf.Any) |  | Optional exchange-specific extensions. |






<a name="com.iabtechlab.openrtb.Request"/>

### Request
The Request object contains a globally unique bid request ID. This id
attribute is required as is an Item array with at least one object (i.e., at
least one item for sale). Other attributes establish rules and restrictions
that apply to all items being offered. This object also interfaces to Layer-4
domain objects for context such as the user, device, site or app, etc.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [string](#string) |  | Unique ID of the bid request; provided by the exchange. |
| test | [bool](#bool) |  | Indicator of test mode in which auctions are not billable, where 0 = live mode, 1 = test mode. |
| tmax | [uint32](#uint32) |  | Maximum time in milliseconds the exchange allows for bids to be received including Internet latency to avoid timeout. This value supersedes any a priori guidance from the exchange. If an exchange acts as an intermediary, it should decrease the outbound tmax value from what it received to account for its latency and the additional internet hop. |
| at | [uint32](#uint32) |  | Auction type, where 1 = First Price, 2 = Second Price Plus. Values greater than 500 can be used for exchange-specific auction types. |
| cur | [string](#string) | repeated | Array of accepted currencies for bids on this bid request using ISO-4217 alpha codes. Recommended if the exchange accepts multiple currencies. If omitted, the single currency of “USD” is assumed. |
| seat | [string](#string) | repeated | Restriction list of buyer seats for bidding on this item. Knowledge of buyer’s customers and their seat IDs must be coordinated between parties a priori. Omission implies no restrictions. |
| wseat | [int32](#int32) |  | Flag that determines the restriction interpretation of the seat array, where 0 = block list, 1 = whitelist. |
| cdata | [string](#string) |  | Allows bidder to retrieve data set on its behalf in the exchange’s cookie (refer to cdata in Object: Response) if supported by the exchange. The string must be in base85 cookie-safe characters. |
| source | [Source](#com.iabtechlab.openrtb.Source) |  | A Source object that provides data about the inventory source and which entity makes the final decision. Refer to Object: Source. |
| item | [Item](#com.iabtechlab.openrtb.Item) | repeated | Array of Item objects (at least one) that constitute the set of goods being offered for sale. Refer to Object: Item. |
| package | [bool](#bool) |  | Flag to indicate if the Exchange can verify that the items offered represent all of the items available in context (e.g., all impressions on a web page, all video spots such as pre/mid/post roll) to support road-blocking, where 0 = no, 1 = yes. |
| context | [google.protobuf.Any](#google.protobuf.Any) |  | Layer-4 domain object structure that provides context for the items being offered conforming to the specification and version referenced in openrtb.domainspec and openrtb.domainver. For AdCOM v1.x, the objects allowed here all of which are optional are one of the DistributionChannel subtypes (i.e., Site, App, or Dooh), User, Device, Regs, Restrictions, and any objects subordinate to these as specified by AdCOM. |
| ext | [google.protobuf.Any](#google.protobuf.Any) |  | Optional exchange-specific extensions. |






<a name="com.iabtechlab.openrtb.Source"/>

### Source
This object carries data about the source of the transaction including the
unique ID of the transaction itself, source authentication information, and
the chain of custody.

NOTE: Attributes ds, dsmap, cert, and digest support digitally signed bid
requests as defined by the Ads.cert: Signed Bid Requests specification. As
the Ads.cert specification is still in its BETA state, these attributes
should be considered to be in a similar state.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tid | [string](#string) |  | Transaction ID that must be common across all participants throughout the entire supply chain of this transaction. This also applies across all participating exchanges in a header bidding or similar publisher-centric broadcast scenario. |
| ts | [uint64](#uint64) |  | Timestamp when the request originated at the beginning of the supply chain in Unix format (i.e., milliseconds since the epoch). This value must be held as immutable throughout subsequent intermediaries. |
| ds | [string](#string) |  | Digital signature used to authenticate the origin of this request computed by the publisher or its trusted agent from a digest string composed of a set of immutable attributes found in the bid request. Refer to Section “Inventory Authentication” for more details. |
| dsmap | [string](#string) |  | An ordered list of identifiers that indicates the attributes used to create the digest. This map provides the essential instructions for recreating the digest from the bid request, which is a necessary step in validating the digital signature in the ds attribute. Refer to Section “Inventory Authentication” for more details. |
| cert | [string](#string) |  | File name of the certificate (i.e., the public key) used to generate the digital signature in the ds attribute. Refer to Section “Inventory Authentication” for more details. |
| digest | [string](#string) |  | The full digest string that was signed to produce the digital signature. Refer to Section “Inventory Authentication” for more details. NOTE: This is only intended for debugging purposes as needed. It is not intended for normal Production traffic due to the bandwidth impact. |
| pchain | [string](#string) |  | Payment ID chain string containing embedded syntax described in the TAG Payment ID Protocol. NOTE: Authentication features in this Source object combined with the “ads.txt” specification may lead to the deprecation of this attribute. |
| ext | [google.protobuf.Any](#google.protobuf.Any) |  | Optional exchange-specific extensions. |





 

 

 

 



<a name="com/iabtechlab/openrtb/response.proto"/>
<p align="right"><a href="#top">Top</a></p>

## com/iabtechlab/openrtb/response.proto
The response object contains minimal high level attributes (e.g., reference
to the request ID, bid currency, etc.) and an array of seat bids, each of
which is a set of bids on behalf of a buyer seat.

The individual bid references the item in the request to which it pertains
and buying information such as the price, a deal ID if applicable, and
notification URLs. The media related to a bid is conveyed via Layer-4 domain
objects (i.e., ad creative, markup) included in each bid.


<a name="com.iabtechlab.openrtb.Bid"/>

### Bid
A Seatbid object contains one or more Bid objects, each of which relates to a
specific item in the bid request offer via the “item” attribute and
constitutes an offer to buy that item for a given price.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [string](#string) |  | Bidder generated bid ID to assist with logging/tracking. |
| item | [string](#string) |  | ID of the item object in the related bid request; specifically item.id. |
| price | [float](#float) |  | Bid price expressed as CPM although the actual transaction is for a unit item only. Note that while the type indicates float, integer math is highly recommended when handling currencies (e.g., BigDecimal in Java). |
| deal | [string](#string) |  | Reference to a deal from the bid request if this bid pertains to a private marketplace deal; specifically deal.id. |
| cid | [string](#string) |  | Campaign ID or other similar grouping of brand-related ads. Typically used to increase the efficiency of audit processes. |
| tactic | [string](#string) |  | Tactic ID to enable buyers to label bids for reporting to the exchange the tactic through which their bid was submitted. The specific usage and meaning of the tactic ID should be communicated between buyer and exchanges a priori. |
| purl | [string](#string) |  | Pending notice URL called by the exchange when a bid has been declared the winner within the scope of an OpenRTB compliant supply chain (i.e., there may still be non-compliant decisioning such as header bidding). Substitution macros may be included. |
| burl | [string](#string) |  | Billing notice URL called by the exchange when a winning bid becomes billable based on exchange-specific business policy (e.g., markup rendered). Substitution macros may be included. |
| lurl | [string](#string) |  | Loss notice URL called by the exchange when a bid is known to have been lost. Substitution macros may be included. Exchange-specific policy may preclude support for loss notices or the disclosure of winning clearing prices resulting in ${OPENRTB_PRICE} macros being removed (i.e., replaced with a zero-length string). |
| exp | [uint64](#uint64) |  | Advisory as to the number of seconds the buyer is willing to wait between auction and fulfilment. |
| mid | [string](#string) |  | ID to enable media to be specified by reference if previously uploaded to the exchange rather than including it by value in the domain objects. |
| macro | [Macro](#com.iabtechlab.openrtb.Macro) | repeated | Array of Macro objects that enable bid specific values to be substituted into markup; especially useful for previously uploaded media referenced via the mid attribute. Refer to Object: Macro. |
| media | [google.protobuf.Any](#google.protobuf.Any) |  | Layer-4 domain object structure that specifies the media to be presented if the bid is won conforming to the specification and version referenced in openrtb.domainspec and openrtb.domainver. For AdCOM v1.x, the objects allowed here are “Ad” and any objects subordinate thereto as specified by AdCOM. |
| ext | [google.protobuf.Any](#google.protobuf.Any) |  | Optional demand source specific extensions. |






<a name="com.iabtechlab.openrtb.Macro"/>

### Macro
This object constitutes a buyer defined key/value pair used to inject dynamic
values into media markup. While they apply to any media markup irrespective
of how it is conveyed, the principle use case is for media that was uploaded
to the exchange prior to the transaction (e.g., pre-registered for creative
quality review) and referenced in bid. The full form of the macro to be
substituted at runtime is ${CUSTOM_KEY}, where “KEY” is the name supplied in
the key attribute. This ensures no conflict with standard OpenRTB macros.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| key | [string](#string) |  | Name of a buyer specific macro. |
| value | [string](#string) |  | Value to substitute for each instance of the macro found in markup. |
| ext | [google.protobuf.Any](#google.protobuf.Any) |  | Optional demand source specific extensions. |






<a name="com.iabtechlab.openrtb.Response"/>

### Response
This object is the bid response object under the Openrtb root. Its id
attribute is a reflection of the bid request ID. The bidid attribute is an
optional response tracking ID for bidders. If specified, it will be available
for use in substitution macros placed in markup and notification URLs. At
least one Seatbid object is required, which contains at least one Bid for an
item. Other attributes are optional.

To express a “no-bid”, the most compact option is simply to return an empty
response with HTTP 204. However, if the bidder wishes to convey a reason for
not bidding, a Response object can be returned with just a reason code in the
nbr attribute.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [string](#string) |  | ID of the bid request to which this is a response; must match the request.id attribute. |
| bidid | [string](#string) |  | Bidder generated response ID to assist with logging/tracking. |
| nbr | [uint32](#uint32) |  | Reason for not bidding if applicable (see List: No-Bid Reason Codes). Note that while many exchanges prefer a simple HTTP 204 response to indicate a no-bid, responses indicating a reason code can be useful in debugging scenarios. |
| cur | [string](#string) |  | Bid currency using ISO-4217 alpha codes. |
| cdata | [string](#string) |  | Allows bidder to set data in the exchange’s cookie, which can be retrieved on bid requests (refer to cdata in Object: Request) if supported by the exchange. The string must be in base85 cookie-safe characters. |
| seatbid | [SeatBid](#com.iabtechlab.openrtb.SeatBid) | repeated | Array of Seatbid objects; 1&#43; required if a bid is to be made. Refer to Object: Seatbid. |
| ext | [google.protobuf.Any](#google.protobuf.Any) |  | Optional demand source specific extensions. |






<a name="com.iabtechlab.openrtb.SeatBid"/>

### SeatBid
A bid response can contain multiple Seatbid objects, each on behalf of a
different buyer seat and each containing one or more individual bids. If
multiple items are presented in the request offer, the package attribute can
be used to specify if a seat is willing to accept any impressions that it can
win (default) or if it is interested in winning any only if it can win them
all as a group.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| seat | [string](#string) |  | ID of the buyer seat on whose behalf this bid is made. |
| package | [bool](#bool) |  | For offers with multiple items, this flag Indicates if the bidder is willing to accept wins on a subset of bids or requires the full group as a package, where 0 = individual wins accepted; 1 = package win or loss only. |
| bid | [Bid](#com.iabtechlab.openrtb.Bid) | repeated | Array of 1&#43; Bid objects each related to an item. Multiple bids can relate to the same item. Refer to Object: Bid. |
| ext | [google.protobuf.Any](#google.protobuf.Any) |  | Optional demand source specific extensions. |





 

 

 

 



<a name="com/iabtechlab/openrtb/openrtb.proto"/>
<p align="right"><a href="#top">Top</a></p>

## com/iabtechlab/openrtb/openrtb.proto
The UML class diagram in the documentation illustrates the overall payload
structure including both request and response objects. Payloads are rooted in
named objects; Openrtb as a common root and Request and Response as
subordinate roots to identify the payload type.

Throughout the object model subsections, attributes may be indicated as
“Required” or “Recommended”. Attributes are deemed required only if their
omission would break the protocol and is not necessarily an indicator of
business value otherwise. Attributes are recommended when their omission
would not break the protocol but would dramatically diminish business value.

From a specification compliance perspective, any attribute not denoted
required is optional, whether recommended or not. An optional attribute may
have a default value to be assumed if omitted. If no default is indicated,
then by convention its absence should be interpreted as unknown, unless
otherwise specified. Empty strings or null values should be interpreted the
same as omitted (i.e., the default if one is specified or unknown otherwise).

BEST PRACTICE: Exchanges and demand sources are encouraged to publish to
their partners the set of optional objects and attributes they support along
with any extensions to the specification.


<a name="com.iabtechlab.openrtb.Openrtb"/>

### Openrtb
This top-level object is the root for both request and response payloads. It
includes versioning information and references to the Layer-4 domain model on
which transactions are based. By default, the domain model used by OpenRTB is
the Advertising Common Object Model (AdCOM).

Note: As a convention in this document, objects being defined are denoted with
uppercase first letter in deference to the common convention for class names
in programming languages such as Java, whereas actual instances of objects and
references thereto in payloads are lowercase.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| ver | [string](#string) |  | Version of the Layer-3 OpenRTB specification (e.g., &#34;3.0&#34;). |
| domainspec | [string](#string) |  | Identifier of the Layer-4 domain model used to define items for sale, media associated with bids, etc. |
| domainver | [string](#string) |  | Specification version of the Layer-4 domain model referenced in the domainspec attribute. |
| request | [Request](#com.iabtechlab.openrtb.Request) |  | Bid request container. Required only for request payloads. |
| response | [Response](#com.iabtechlab.openrtb.Response) |  | Bid response container. Required only for response payloads. |





 

 

 

 



## Scalar Value Types

| .proto Type | Notes | C++ Type | Java Type | Python Type |
| ----------- | ----- | -------- | --------- | ----------- |
| <a name="double" /> double |  | double | double | float |
| <a name="float" /> float |  | float | float | float |
| <a name="int32" /> int32 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint32 instead. | int32 | int | int |
| <a name="int64" /> int64 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint64 instead. | int64 | long | int/long |
| <a name="uint32" /> uint32 | Uses variable-length encoding. | uint32 | int | int/long |
| <a name="uint64" /> uint64 | Uses variable-length encoding. | uint64 | long | int/long |
| <a name="sint32" /> sint32 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int32s. | int32 | int | int |
| <a name="sint64" /> sint64 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int64s. | int64 | long | int/long |
| <a name="fixed32" /> fixed32 | Always four bytes. More efficient than uint32 if values are often greater than 2^28. | uint32 | int | int |
| <a name="fixed64" /> fixed64 | Always eight bytes. More efficient than uint64 if values are often greater than 2^56. | uint64 | long | int/long |
| <a name="sfixed32" /> sfixed32 | Always four bytes. | int32 | int | int |
| <a name="sfixed64" /> sfixed64 | Always eight bytes. | int64 | long | int/long |
| <a name="bool" /> bool |  | bool | boolean | boolean |
| <a name="string" /> string | A string must always contain UTF-8 encoded or 7-bit ASCII text. | string | String | str/unicode |
| <a name="bytes" /> bytes | May contain any arbitrary sequence of bytes. | string | ByteString | str |

