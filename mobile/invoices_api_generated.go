// Code generated by falafel 0.9.2. DO NOT EDIT.
// source: ./invoices_api_generated.go

//go:build invoicesrpc
// +build invoicesrpc

package lndmobile

import (
	"context"
	"net"

	"github.com/golang/protobuf/proto"
	"google.golang.org/grpc"

	"github.com/lightningnetwork/lnd/lnrpc/invoicesrpc"
)

// setInvoicesDialOption sets the given method as the way
// to retrieve gprc options for the service.
func setInvoicesDialOption(f func() ([]grpc.DialOption, error)) {
	serviceDialOptionsMtx.Lock()
	defer serviceDialOptionsMtx.Unlock()

	serviceDialOptions["Invoices"] = f
}

// applyInvoicesDialOptions returns extra grpc options to
// use when calling the service.
func applyInvoicesDialOptions() ([]grpc.DialOption, error) {
	serviceDialOptionsMtx.Lock()
	defer serviceDialOptionsMtx.Unlock()

	// First check the service options map, if there are any options
	// specific to this service.
	f, ok := serviceDialOptions["Invoices"]
	if ok {
		return f()
	}

	// Otherwise return the default options.
	return defaultDialOptions()
}

// getInvoicesConn dials Invoices with the current dial options,
// and returns the grpc client connection.
func getInvoicesConn() (*grpc.ClientConn, func(), error) {
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
	extraOpts, err := applyInvoicesDialOptions()
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

// getInvoicesClient returns a client connection to the server listening
// on lis.
func getInvoicesClient() (invoicesrpc.InvoicesClient, func(), error) {
	clientConn, closeConn, err := getInvoicesConn()
	if err != nil {
		return nil, nil, err
	}
	client := invoicesrpc.NewInvoicesClient(clientConn)
	return client, closeConn, nil
}

// SubscribeSingleInvoice returns a uni-directional stream (server -> client)
// to notify the client of state transitions of the specified invoice.
// Initially the current invoice state is always sent out.
//
// NOTE: This method produces a stream of responses, and the receive stream can
// be called zero or more times. After EOF error is returned, no more responses
// will be produced.
func InvoicesSubscribeSingleInvoice(msg []byte, rStream RecvStream) {
	s := &readStreamHandler{
		newProto: func() proto.Message {
			return &invoicesrpc.SubscribeSingleInvoiceRequest{}
		},
		recvStream: func(ctx context.Context,
			req proto.Message) (*receiver, func(), error) {

			// Get the gRPC client.
			client, closeClient, err := getInvoicesClient()
			if err != nil {
				return nil, nil, err
			}

			r := req.(*invoicesrpc.SubscribeSingleInvoiceRequest)
			stream, err := client.SubscribeSingleInvoice(ctx, r)
			if err != nil {
				closeClient()
				return nil, nil, err
			}
			return &receiver{
				recv: func() (proto.Message, error) {
					return stream.Recv()
				},
			}, closeClient, nil
		},
	}
	s.start(msg, rStream)
}

// CancelInvoice cancels a currently open invoice. If the invoice is already
// canceled, this call will succeed. If the invoice is already settled, it will
// fail.
//
// NOTE: This method produces a single result or error, and the callback will
// be called only once.
func InvoicesCancelInvoice(msg []byte, callback Callback) {
	s := &syncHandler{
		newProto: func() proto.Message {
			return &invoicesrpc.CancelInvoiceMsg{}
		},
		getSync: func(ctx context.Context,
			req proto.Message) (proto.Message, error) {

			// Get the gRPC client.
			client, closeClient, err := getInvoicesClient()
			if err != nil {
				return nil, err
			}
			defer closeClient()

			r := req.(*invoicesrpc.CancelInvoiceMsg)
			return client.CancelInvoice(ctx, r)
		},
	}
	s.start(msg, callback)
}

// AddHoldInvoice creates a hold invoice. It ties the invoice to the hash
// supplied in the request.
//
// NOTE: This method produces a single result or error, and the callback will
// be called only once.
func InvoicesAddHoldInvoice(msg []byte, callback Callback) {
	s := &syncHandler{
		newProto: func() proto.Message {
			return &invoicesrpc.AddHoldInvoiceRequest{}
		},
		getSync: func(ctx context.Context,
			req proto.Message) (proto.Message, error) {

			// Get the gRPC client.
			client, closeClient, err := getInvoicesClient()
			if err != nil {
				return nil, err
			}
			defer closeClient()

			r := req.(*invoicesrpc.AddHoldInvoiceRequest)
			return client.AddHoldInvoice(ctx, r)
		},
	}
	s.start(msg, callback)
}

// SettleInvoice settles an accepted invoice. If the invoice is already
// settled, this call will succeed.
//
// NOTE: This method produces a single result or error, and the callback will
// be called only once.
func InvoicesSettleInvoice(msg []byte, callback Callback) {
	s := &syncHandler{
		newProto: func() proto.Message {
			return &invoicesrpc.SettleInvoiceMsg{}
		},
		getSync: func(ctx context.Context,
			req proto.Message) (proto.Message, error) {

			// Get the gRPC client.
			client, closeClient, err := getInvoicesClient()
			if err != nil {
				return nil, err
			}
			defer closeClient()

			r := req.(*invoicesrpc.SettleInvoiceMsg)
			return client.SettleInvoice(ctx, r)
		},
	}
	s.start(msg, callback)
}

// LookupInvoiceV2 attempts to look up at invoice. An invoice can be refrenced
// using either its payment hash, payment address, or set ID.
//
// NOTE: This method produces a single result or error, and the callback will
// be called only once.
func InvoicesLookupInvoiceV2(msg []byte, callback Callback) {
	s := &syncHandler{
		newProto: func() proto.Message {
			return &invoicesrpc.LookupInvoiceMsg{}
		},
		getSync: func(ctx context.Context,
			req proto.Message) (proto.Message, error) {

			// Get the gRPC client.
			client, closeClient, err := getInvoicesClient()
			if err != nil {
				return nil, err
			}
			defer closeClient()

			r := req.(*invoicesrpc.LookupInvoiceMsg)
			return client.LookupInvoiceV2(ctx, r)
		},
	}
	s.start(msg, callback)
}
