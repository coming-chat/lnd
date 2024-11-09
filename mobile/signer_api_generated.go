// Code generated by falafel 0.9.2. DO NOT EDIT.
// source: ./signer_api_generated.go

//go:build signrpc
// +build signrpc

package lndmobile

import (
	"context"
	"net"

	"github.com/golang/protobuf/proto"
	"google.golang.org/grpc"

	"github.com/lightningnetwork/lnd/lnrpc/signrpc"
)

// setSignerDialOption sets the given method as the way
// to retrieve gprc options for the service.
func setSignerDialOption(f func() ([]grpc.DialOption, error)) {
	serviceDialOptionsMtx.Lock()
	defer serviceDialOptionsMtx.Unlock()

	serviceDialOptions["Signer"] = f
}

// applySignerDialOptions returns extra grpc options to
// use when calling the service.
func applySignerDialOptions() ([]grpc.DialOption, error) {
	serviceDialOptionsMtx.Lock()
	defer serviceDialOptionsMtx.Unlock()

	// First check the service options map, if there are any options
	// specific to this service.
	f, ok := serviceDialOptions["Signer"]
	if ok {
		return f()
	}

	// Otherwise return the default options.
	return defaultDialOptions()
}

// getSignerConn dials Signer with the current dial options,
// and returns the grpc client connection.
func getSignerConn() (*grpc.ClientConn, func(), error) {
	conn, err := lightningLis.Dial()
	if err != nil {
		return nil, nil, err
	}

	// Set up a custom dialer using the listener conn.
	dialer := func(context.Context, string) (net.Conn, error) {
		return conn, nil
	}

	// Create a dial options array.
	opts := []grpc.DialOption{
		grpc.WithContextDialer(dialer),
	}

	// Apply any extra server options.
	extraOpts, err := applySignerDialOptions()
	if err != nil {
		return nil, nil, err
	}

	opts = append(opts, extraOpts...)

	// As address we use "localhost" to mimic a local connection.
	address := "localhost"
	clientConn, err := grpc.Dial(address, opts...)
	if err != nil {
		conn.Close()
		return nil, nil, err
	}

	closeConn := func() {
		conn.Close()
	}

	return clientConn, closeConn, nil
}

// getSignerClient returns a client connection to the server listening
// on lis.
func getSignerClient() (signrpc.SignerClient, func(), error) {
	clientConn, closeConn, err := getSignerConn()
	if err != nil {
		return nil, nil, err
	}
	client := signrpc.NewSignerClient(clientConn)
	return client, closeConn, nil
}

// SignOutputRaw is a method that can be used to generated a signature for a
// set of inputs/outputs to a transaction. Each request specifies details
// concerning how the outputs should be signed, which keys they should be
// signed with, and also any optional tweaks. The return value is a fixed
// 64-byte signature (the same format as we use on the wire in Lightning).
//
// If we are  unable to sign using the specified keys, then an error will be
// returned.
//
// NOTE: This method produces a single result or error, and the callback will
// be called only once.
func SignerSignOutputRaw(msg []byte, callback Callback) {
	s := &syncHandler{
		newProto: func() proto.Message {
			return &signrpc.SignReq{}
		},
		getSync: func(ctx context.Context,
			req proto.Message) (proto.Message, error) {

			// Get the gRPC client.
			client, closeClient, err := getSignerClient()
			if err != nil {
				return nil, err
			}
			defer closeClient()

			r := req.(*signrpc.SignReq)
			return client.SignOutputRaw(ctx, r)
		},
	}
	s.start(msg, callback)
}

// ComputeInputScript generates a complete InputIndex for the passed
// transaction with the signature as defined within the passed SignDescriptor.
// This method should be capable of generating the proper input script for both
// regular p2wkh/p2tr outputs and p2wkh outputs nested within a regular p2sh
// output.
//
// Note that when using this method to sign inputs belonging to the wallet,
// the only items of the SignDescriptor that need to be populated are pkScript
// in the TxOut field, the value in that same field, and finally the input
// index.
//
// NOTE: This method produces a single result or error, and the callback will
// be called only once.
func SignerComputeInputScript(msg []byte, callback Callback) {
	s := &syncHandler{
		newProto: func() proto.Message {
			return &signrpc.SignReq{}
		},
		getSync: func(ctx context.Context,
			req proto.Message) (proto.Message, error) {

			// Get the gRPC client.
			client, closeClient, err := getSignerClient()
			if err != nil {
				return nil, err
			}
			defer closeClient()

			r := req.(*signrpc.SignReq)
			return client.ComputeInputScript(ctx, r)
		},
	}
	s.start(msg, callback)
}

// SignMessage signs a message with the key specified in the key locator. The
// returned signature is fixed-size LN wire format encoded.
//
// The main difference to SignMessage in the main RPC is that a specific key is
// used to sign the message instead of the node identity private key.
//
// NOTE: This method produces a single result or error, and the callback will
// be called only once.
func SignerSignMessage(msg []byte, callback Callback) {
	s := &syncHandler{
		newProto: func() proto.Message {
			return &signrpc.SignMessageReq{}
		},
		getSync: func(ctx context.Context,
			req proto.Message) (proto.Message, error) {

			// Get the gRPC client.
			client, closeClient, err := getSignerClient()
			if err != nil {
				return nil, err
			}
			defer closeClient()

			r := req.(*signrpc.SignMessageReq)
			return client.SignMessage(ctx, r)
		},
	}
	s.start(msg, callback)
}

// VerifyMessage verifies a signature over a message using the public key
// provided. The signature must be fixed-size LN wire format encoded.
//
// The main difference to VerifyMessage in the main RPC is that the public key
// used to sign the message does not have to be a node known to the network.
//
// NOTE: This method produces a single result or error, and the callback will
// be called only once.
func SignerVerifyMessage(msg []byte, callback Callback) {
	s := &syncHandler{
		newProto: func() proto.Message {
			return &signrpc.VerifyMessageReq{}
		},
		getSync: func(ctx context.Context,
			req proto.Message) (proto.Message, error) {

			// Get the gRPC client.
			client, closeClient, err := getSignerClient()
			if err != nil {
				return nil, err
			}
			defer closeClient()

			r := req.(*signrpc.VerifyMessageReq)
			return client.VerifyMessage(ctx, r)
		},
	}
	s.start(msg, callback)
}

// DeriveSharedKey returns a shared secret key by performing Diffie-Hellman key
// derivation between the ephemeral public key in the request and the node's
// key specified in the key_desc parameter. Either a key locator or a raw
// public key is expected in the key_desc, if neither is supplied, defaults to
// the node's identity private key:
// P_shared = privKeyNode * ephemeralPubkey
// The resulting shared public key is serialized in the compressed format and
// hashed with sha256, resulting in the final key length of 256bit.
//
// NOTE: This method produces a single result or error, and the callback will
// be called only once.
func SignerDeriveSharedKey(msg []byte, callback Callback) {
	s := &syncHandler{
		newProto: func() proto.Message {
			return &signrpc.SharedKeyRequest{}
		},
		getSync: func(ctx context.Context,
			req proto.Message) (proto.Message, error) {

			// Get the gRPC client.
			client, closeClient, err := getSignerClient()
			if err != nil {
				return nil, err
			}
			defer closeClient()

			r := req.(*signrpc.SharedKeyRequest)
			return client.DeriveSharedKey(ctx, r)
		},
	}
	s.start(msg, callback)
}

// MuSig2CombineKeys (experimental!) is a stateless helper RPC that can be used
// to calculate the combined MuSig2 public key from a list of all participating
// signers' public keys. This RPC is completely stateless and deterministic and
// does not create any signing session. It can be used to determine the Taproot
// public key that should be put in an on-chain output once all public keys are
// known. A signing session is only needed later when that output should be
// _spent_ again.
//
// NOTE: The MuSig2 BIP is not final yet and therefore this API must be
// considered to be HIGHLY EXPERIMENTAL and subject to change in upcoming
// releases. Backward compatibility is not guaranteed!
//
// NOTE: This method produces a single result or error, and the callback will
// be called only once.
func SignerMuSig2CombineKeys(msg []byte, callback Callback) {
	s := &syncHandler{
		newProto: func() proto.Message {
			return &signrpc.MuSig2CombineKeysRequest{}
		},
		getSync: func(ctx context.Context,
			req proto.Message) (proto.Message, error) {

			// Get the gRPC client.
			client, closeClient, err := getSignerClient()
			if err != nil {
				return nil, err
			}
			defer closeClient()

			r := req.(*signrpc.MuSig2CombineKeysRequest)
			return client.MuSig2CombineKeys(ctx, r)
		},
	}
	s.start(msg, callback)
}

// MuSig2CreateSession (experimental!) creates a new MuSig2 signing session
// using the local key identified by the key locator. The complete list of all
// public keys of all signing parties must be provided, including the public
// key of the local signing key. If nonces of other parties are already known,
// they can be submitted as well to reduce the number of RPC calls necessary
// later on.
//
// NOTE: The MuSig2 BIP is not final yet and therefore this API must be
// considered to be HIGHLY EXPERIMENTAL and subject to change in upcoming
// releases. Backward compatibility is not guaranteed!
//
// NOTE: This method produces a single result or error, and the callback will
// be called only once.
func SignerMuSig2CreateSession(msg []byte, callback Callback) {
	s := &syncHandler{
		newProto: func() proto.Message {
			return &signrpc.MuSig2SessionRequest{}
		},
		getSync: func(ctx context.Context,
			req proto.Message) (proto.Message, error) {

			// Get the gRPC client.
			client, closeClient, err := getSignerClient()
			if err != nil {
				return nil, err
			}
			defer closeClient()

			r := req.(*signrpc.MuSig2SessionRequest)
			return client.MuSig2CreateSession(ctx, r)
		},
	}
	s.start(msg, callback)
}

// MuSig2RegisterNonces (experimental!) registers one or more public nonces of
// other signing participants for a session identified by its ID. This RPC can
// be called multiple times until all nonces are registered.
//
// NOTE: The MuSig2 BIP is not final yet and therefore this API must be
// considered to be HIGHLY EXPERIMENTAL and subject to change in upcoming
// releases. Backward compatibility is not guaranteed!
//
// NOTE: This method produces a single result or error, and the callback will
// be called only once.
func SignerMuSig2RegisterNonces(msg []byte, callback Callback) {
	s := &syncHandler{
		newProto: func() proto.Message {
			return &signrpc.MuSig2RegisterNoncesRequest{}
		},
		getSync: func(ctx context.Context,
			req proto.Message) (proto.Message, error) {

			// Get the gRPC client.
			client, closeClient, err := getSignerClient()
			if err != nil {
				return nil, err
			}
			defer closeClient()

			r := req.(*signrpc.MuSig2RegisterNoncesRequest)
			return client.MuSig2RegisterNonces(ctx, r)
		},
	}
	s.start(msg, callback)
}

// MuSig2Sign (experimental!) creates a partial signature using the local
// signing key that was specified when the session was created. This can only
// be called when all public nonces of all participants are known and have been
// registered with the session. If this node isn't responsible for combining
// all the partial signatures, then the cleanup flag should be set, indicating
// that the session can be removed from memory once the signature was produced.
//
// NOTE: The MuSig2 BIP is not final yet and therefore this API must be
// considered to be HIGHLY EXPERIMENTAL and subject to change in upcoming
// releases. Backward compatibility is not guaranteed!
//
// NOTE: This method produces a single result or error, and the callback will
// be called only once.
func SignerMuSig2Sign(msg []byte, callback Callback) {
	s := &syncHandler{
		newProto: func() proto.Message {
			return &signrpc.MuSig2SignRequest{}
		},
		getSync: func(ctx context.Context,
			req proto.Message) (proto.Message, error) {

			// Get the gRPC client.
			client, closeClient, err := getSignerClient()
			if err != nil {
				return nil, err
			}
			defer closeClient()

			r := req.(*signrpc.MuSig2SignRequest)
			return client.MuSig2Sign(ctx, r)
		},
	}
	s.start(msg, callback)
}

// MuSig2CombineSig (experimental!) combines the given partial signature(s)
// with the local one, if it already exists. Once a partial signature of all
// participants is registered, the final signature will be combined and
// returned.
//
// NOTE: The MuSig2 BIP is not final yet and therefore this API must be
// considered to be HIGHLY EXPERIMENTAL and subject to change in upcoming
// releases. Backward compatibility is not guaranteed!
//
// NOTE: This method produces a single result or error, and the callback will
// be called only once.
func SignerMuSig2CombineSig(msg []byte, callback Callback) {
	s := &syncHandler{
		newProto: func() proto.Message {
			return &signrpc.MuSig2CombineSigRequest{}
		},
		getSync: func(ctx context.Context,
			req proto.Message) (proto.Message, error) {

			// Get the gRPC client.
			client, closeClient, err := getSignerClient()
			if err != nil {
				return nil, err
			}
			defer closeClient()

			r := req.(*signrpc.MuSig2CombineSigRequest)
			return client.MuSig2CombineSig(ctx, r)
		},
	}
	s.start(msg, callback)
}

// MuSig2Cleanup (experimental!) allows a caller to clean up a session early in
// cases where it's obvious that the signing session won't succeed and the
// resources can be released.
//
// NOTE: The MuSig2 BIP is not final yet and therefore this API must be
// considered to be HIGHLY EXPERIMENTAL and subject to change in upcoming
// releases. Backward compatibility is not guaranteed!
//
// NOTE: This method produces a single result or error, and the callback will
// be called only once.
func SignerMuSig2Cleanup(msg []byte, callback Callback) {
	s := &syncHandler{
		newProto: func() proto.Message {
			return &signrpc.MuSig2CleanupRequest{}
		},
		getSync: func(ctx context.Context,
			req proto.Message) (proto.Message, error) {

			// Get the gRPC client.
			client, closeClient, err := getSignerClient()
			if err != nil {
				return nil, err
			}
			defer closeClient()

			r := req.(*signrpc.MuSig2CleanupRequest)
			return client.MuSig2Cleanup(ctx, r)
		},
	}
	s.start(msg, callback)
}
