#!/usr/bin/env bats

@test "check for known hosts" {
  grep node1 /tmp/known_hosts
  grep node2 /tmp/known_hosts
  grep node3 /tmp/known_hosts
}
