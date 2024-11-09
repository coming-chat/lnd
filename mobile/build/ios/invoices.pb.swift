// DO NOT EDIT.
// swift-format-ignore-file
// swiftlint:disable all
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: invoicesrpc/invoices.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

enum Invoicesrpc_LookupModifier: SwiftProtobuf.Enum, Swift.CaseIterable {
  typealias RawValue = Int

  /// The default look up modifier, no look up behavior is changed.
  case `default` // = 0

  ///
  ///Indicates that when a look up is done based on a set_id, then only that set
  ///of HTLCs related to that set ID should be returned.
  case htlcSetOnly // = 1

  ///
  ///Indicates that when a look up is done using a payment_addr, then no HTLCs
  ///related to the payment_addr should be returned. This is useful when one
  ///wants to be able to obtain the set of associated setIDs with a given
  ///invoice, then look up the sub-invoices "projected" by that set ID.
  case htlcSetBlank // = 2
  case UNRECOGNIZED(Int)

  init() {
    self = .default
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .default
    case 1: self = .htlcSetOnly
    case 2: self = .htlcSetBlank
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  var rawValue: Int {
    switch self {
    case .default: return 0
    case .htlcSetOnly: return 1
    case .htlcSetBlank: return 2
    case .UNRECOGNIZED(let i): return i
    }
  }

  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static let allCases: [Invoicesrpc_LookupModifier] = [
    .default,
    .htlcSetOnly,
    .htlcSetBlank,
  ]

}

struct Invoicesrpc_CancelInvoiceMsg: @unchecked Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// Hash corresponding to the (hold) invoice to cancel. When using
  /// REST, this field must be encoded as base64.
  var paymentHash: Data = Data()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Invoicesrpc_CancelInvoiceResp: Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Invoicesrpc_AddHoldInvoiceRequest: @unchecked Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  ///
  ///An optional memo to attach along with the invoice. Used for record keeping
  ///purposes for the invoice's creator, and will also be set in the description
  ///field of the encoded payment request if the description_hash field is not
  ///being used.
  var memo: String = String()

  /// The hash of the preimage
  var hash: Data = Data()

  ///
  ///The value of this invoice in satoshis
  ///
  ///The fields value and value_msat are mutually exclusive.
  var value: Int64 = 0

  ///
  ///The value of this invoice in millisatoshis
  ///
  ///The fields value and value_msat are mutually exclusive.
  var valueMsat: Int64 = 0

  ///
  ///Hash (SHA-256) of a description of the payment. Used if the description of
  ///payment (memo) is too long to naturally fit within the description field
  ///of an encoded payment request.
  var descriptionHash: Data = Data()

  /// Payment request expiry time in seconds. Default is 86400 (24 hours).
  var expiry: Int64 = 0

  /// Fallback on-chain address.
  var fallbackAddr: String = String()

  /// Delta to use for the time-lock of the CLTV extended to the final hop.
  var cltvExpiry: UInt64 = 0

  ///
  ///Route hints that can each be individually used to assist in reaching the
  ///invoice's destination.
  var routeHints: [Lnrpc_RouteHint] = []

  /// Whether this invoice should include routing hints for private channels.
  var `private`: Bool = false

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Invoicesrpc_AddHoldInvoiceResp: @unchecked Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  ///
  ///A bare-bones invoice for a payment within the Lightning Network. With the
  ///details of the invoice, the sender has all the data necessary to send a
  ///payment to the recipient.
  var paymentRequest: String = String()

  ///
  ///The "add" index of this invoice. Each newly created invoice will increment
  ///this index making it monotonically increasing. Callers to the
  ///SubscribeInvoices call can use this to instantly get notified of all added
  ///invoices with an add_index greater than this one.
  var addIndex: UInt64 = 0

  ///
  ///The payment address of the generated invoice. This is also called
  ///the payment secret in specifications (e.g. BOLT 11). This value should
  ///be used in all payments for this invoice as we require it for end to end
  ///security.
  var paymentAddr: Data = Data()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Invoicesrpc_SettleInvoiceMsg: @unchecked Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// Externally discovered pre-image that should be used to settle the hold
  /// invoice.
  var preimage: Data = Data()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Invoicesrpc_SettleInvoiceResp: Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Invoicesrpc_SubscribeSingleInvoiceRequest: @unchecked Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// Hash corresponding to the (hold) invoice to subscribe to. When using
  /// REST, this field must be encoded as base64url.
  var rHash: Data = Data()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Invoicesrpc_LookupInvoiceMsg: @unchecked Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var invoiceRef: Invoicesrpc_LookupInvoiceMsg.OneOf_InvoiceRef? = nil

  /// When using REST, this field must be encoded as base64.
  var paymentHash: Data {
    get {
      if case .paymentHash(let v)? = invoiceRef {return v}
      return Data()
    }
    set {invoiceRef = .paymentHash(newValue)}
  }

  var paymentAddr: Data {
    get {
      if case .paymentAddr(let v)? = invoiceRef {return v}
      return Data()
    }
    set {invoiceRef = .paymentAddr(newValue)}
  }

  var setID: Data {
    get {
      if case .setID(let v)? = invoiceRef {return v}
      return Data()
    }
    set {invoiceRef = .setID(newValue)}
  }

  var lookupModifier: Invoicesrpc_LookupModifier = .default

  var unknownFields = SwiftProtobuf.UnknownStorage()

  enum OneOf_InvoiceRef: Equatable, @unchecked Sendable {
    /// When using REST, this field must be encoded as base64.
    case paymentHash(Data)
    case paymentAddr(Data)
    case setID(Data)

  }

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "invoicesrpc"

extension Invoicesrpc_LookupModifier: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "DEFAULT"),
    1: .same(proto: "HTLC_SET_ONLY"),
    2: .same(proto: "HTLC_SET_BLANK"),
  ]
}

extension Invoicesrpc_CancelInvoiceMsg: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".CancelInvoiceMsg"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "payment_hash"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularBytesField(value: &self.paymentHash) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.paymentHash.isEmpty {
      try visitor.visitSingularBytesField(value: self.paymentHash, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Invoicesrpc_CancelInvoiceMsg, rhs: Invoicesrpc_CancelInvoiceMsg) -> Bool {
    if lhs.paymentHash != rhs.paymentHash {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Invoicesrpc_CancelInvoiceResp: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".CancelInvoiceResp"
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    // Load everything into unknown fields
    while try decoder.nextFieldNumber() != nil {}
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Invoicesrpc_CancelInvoiceResp, rhs: Invoicesrpc_CancelInvoiceResp) -> Bool {
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Invoicesrpc_AddHoldInvoiceRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".AddHoldInvoiceRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "memo"),
    2: .same(proto: "hash"),
    3: .same(proto: "value"),
    10: .standard(proto: "value_msat"),
    4: .standard(proto: "description_hash"),
    5: .same(proto: "expiry"),
    6: .standard(proto: "fallback_addr"),
    7: .standard(proto: "cltv_expiry"),
    8: .standard(proto: "route_hints"),
    9: .same(proto: "private"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.memo) }()
      case 2: try { try decoder.decodeSingularBytesField(value: &self.hash) }()
      case 3: try { try decoder.decodeSingularInt64Field(value: &self.value) }()
      case 4: try { try decoder.decodeSingularBytesField(value: &self.descriptionHash) }()
      case 5: try { try decoder.decodeSingularInt64Field(value: &self.expiry) }()
      case 6: try { try decoder.decodeSingularStringField(value: &self.fallbackAddr) }()
      case 7: try { try decoder.decodeSingularUInt64Field(value: &self.cltvExpiry) }()
      case 8: try { try decoder.decodeRepeatedMessageField(value: &self.routeHints) }()
      case 9: try { try decoder.decodeSingularBoolField(value: &self.`private`) }()
      case 10: try { try decoder.decodeSingularInt64Field(value: &self.valueMsat) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.memo.isEmpty {
      try visitor.visitSingularStringField(value: self.memo, fieldNumber: 1)
    }
    if !self.hash.isEmpty {
      try visitor.visitSingularBytesField(value: self.hash, fieldNumber: 2)
    }
    if self.value != 0 {
      try visitor.visitSingularInt64Field(value: self.value, fieldNumber: 3)
    }
    if !self.descriptionHash.isEmpty {
      try visitor.visitSingularBytesField(value: self.descriptionHash, fieldNumber: 4)
    }
    if self.expiry != 0 {
      try visitor.visitSingularInt64Field(value: self.expiry, fieldNumber: 5)
    }
    if !self.fallbackAddr.isEmpty {
      try visitor.visitSingularStringField(value: self.fallbackAddr, fieldNumber: 6)
    }
    if self.cltvExpiry != 0 {
      try visitor.visitSingularUInt64Field(value: self.cltvExpiry, fieldNumber: 7)
    }
    if !self.routeHints.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.routeHints, fieldNumber: 8)
    }
    if self.`private` != false {
      try visitor.visitSingularBoolField(value: self.`private`, fieldNumber: 9)
    }
    if self.valueMsat != 0 {
      try visitor.visitSingularInt64Field(value: self.valueMsat, fieldNumber: 10)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Invoicesrpc_AddHoldInvoiceRequest, rhs: Invoicesrpc_AddHoldInvoiceRequest) -> Bool {
    if lhs.memo != rhs.memo {return false}
    if lhs.hash != rhs.hash {return false}
    if lhs.value != rhs.value {return false}
    if lhs.valueMsat != rhs.valueMsat {return false}
    if lhs.descriptionHash != rhs.descriptionHash {return false}
    if lhs.expiry != rhs.expiry {return false}
    if lhs.fallbackAddr != rhs.fallbackAddr {return false}
    if lhs.cltvExpiry != rhs.cltvExpiry {return false}
    if lhs.routeHints != rhs.routeHints {return false}
    if lhs.`private` != rhs.`private` {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Invoicesrpc_AddHoldInvoiceResp: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".AddHoldInvoiceResp"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "payment_request"),
    2: .standard(proto: "add_index"),
    3: .standard(proto: "payment_addr"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.paymentRequest) }()
      case 2: try { try decoder.decodeSingularUInt64Field(value: &self.addIndex) }()
      case 3: try { try decoder.decodeSingularBytesField(value: &self.paymentAddr) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.paymentRequest.isEmpty {
      try visitor.visitSingularStringField(value: self.paymentRequest, fieldNumber: 1)
    }
    if self.addIndex != 0 {
      try visitor.visitSingularUInt64Field(value: self.addIndex, fieldNumber: 2)
    }
    if !self.paymentAddr.isEmpty {
      try visitor.visitSingularBytesField(value: self.paymentAddr, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Invoicesrpc_AddHoldInvoiceResp, rhs: Invoicesrpc_AddHoldInvoiceResp) -> Bool {
    if lhs.paymentRequest != rhs.paymentRequest {return false}
    if lhs.addIndex != rhs.addIndex {return false}
    if lhs.paymentAddr != rhs.paymentAddr {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Invoicesrpc_SettleInvoiceMsg: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".SettleInvoiceMsg"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "preimage"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularBytesField(value: &self.preimage) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.preimage.isEmpty {
      try visitor.visitSingularBytesField(value: self.preimage, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Invoicesrpc_SettleInvoiceMsg, rhs: Invoicesrpc_SettleInvoiceMsg) -> Bool {
    if lhs.preimage != rhs.preimage {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Invoicesrpc_SettleInvoiceResp: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".SettleInvoiceResp"
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    // Load everything into unknown fields
    while try decoder.nextFieldNumber() != nil {}
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Invoicesrpc_SettleInvoiceResp, rhs: Invoicesrpc_SettleInvoiceResp) -> Bool {
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Invoicesrpc_SubscribeSingleInvoiceRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".SubscribeSingleInvoiceRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    2: .standard(proto: "r_hash"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 2: try { try decoder.decodeSingularBytesField(value: &self.rHash) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.rHash.isEmpty {
      try visitor.visitSingularBytesField(value: self.rHash, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Invoicesrpc_SubscribeSingleInvoiceRequest, rhs: Invoicesrpc_SubscribeSingleInvoiceRequest) -> Bool {
    if lhs.rHash != rhs.rHash {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Invoicesrpc_LookupInvoiceMsg: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".LookupInvoiceMsg"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "payment_hash"),
    2: .standard(proto: "payment_addr"),
    3: .standard(proto: "set_id"),
    4: .standard(proto: "lookup_modifier"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try {
        var v: Data?
        try decoder.decodeSingularBytesField(value: &v)
        if let v = v {
          if self.invoiceRef != nil {try decoder.handleConflictingOneOf()}
          self.invoiceRef = .paymentHash(v)
        }
      }()
      case 2: try {
        var v: Data?
        try decoder.decodeSingularBytesField(value: &v)
        if let v = v {
          if self.invoiceRef != nil {try decoder.handleConflictingOneOf()}
          self.invoiceRef = .paymentAddr(v)
        }
      }()
      case 3: try {
        var v: Data?
        try decoder.decodeSingularBytesField(value: &v)
        if let v = v {
          if self.invoiceRef != nil {try decoder.handleConflictingOneOf()}
          self.invoiceRef = .setID(v)
        }
      }()
      case 4: try { try decoder.decodeSingularEnumField(value: &self.lookupModifier) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    switch self.invoiceRef {
    case .paymentHash?: try {
      guard case .paymentHash(let v)? = self.invoiceRef else { preconditionFailure() }
      try visitor.visitSingularBytesField(value: v, fieldNumber: 1)
    }()
    case .paymentAddr?: try {
      guard case .paymentAddr(let v)? = self.invoiceRef else { preconditionFailure() }
      try visitor.visitSingularBytesField(value: v, fieldNumber: 2)
    }()
    case .setID?: try {
      guard case .setID(let v)? = self.invoiceRef else { preconditionFailure() }
      try visitor.visitSingularBytesField(value: v, fieldNumber: 3)
    }()
    case nil: break
    }
    if self.lookupModifier != .default {
      try visitor.visitSingularEnumField(value: self.lookupModifier, fieldNumber: 4)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Invoicesrpc_LookupInvoiceMsg, rhs: Invoicesrpc_LookupInvoiceMsg) -> Bool {
    if lhs.invoiceRef != rhs.invoiceRef {return false}
    if lhs.lookupModifier != rhs.lookupModifier {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
