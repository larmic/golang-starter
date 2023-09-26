package client

import (
	"io"
	"net/http"
)

type DelegateClient struct {
	url string
}

func NewDelegateClient(url string) *DelegateClient {
	return &DelegateClient{
		url: url,
	}
}

func (c *DelegateClient) GetExternalStuff() string {
	resp, _ := http.Get(c.url)

	defer resp.Body.Close()

	bytes, _ := io.ReadAll(resp.Body)

	return string(bytes)
}
