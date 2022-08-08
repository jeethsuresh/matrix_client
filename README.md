# matrix_client

Matrix client for my synapse server.

## Goals

- Send/receive messages
- Display convos in a list

## Current bugs/fixlist

- Does not differentiate between people with the same display name
- A lot of non-spec compliant/hardcoded work
- Does not use streams or asynchronous processing
- Does not store messages (or state of any kind) other than the token between sessions
