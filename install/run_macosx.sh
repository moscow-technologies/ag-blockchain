#!/usr/bin/env bash

which -s brew
if [[ $? != 0 ]] ;
then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi

if !(brew ls --versions wget > /dev/null;)
then
  brew install wget
fi

wget https://releases.parity.io/v1.11.8/x86_64-apple-darwin/parity_1.11.8_macos_macos.pkg -O parity_1.11.8.pkg
sudo installer -pkg parity_1.11.8.pkg -target /
rm parity_1.11.8.pkg
export PATH=/Applications/Parity\ Ethereum.app/Contents/MacOS:$PATH

wget https://github.com/parity-js/shell/releases/download/v0.1.4/parity-ui-0.1.4.pkg -O parity-ui-0.1.4.pkg
sudo installer -pkg parity-ui-0.1.4.pkg -target /
rm parity-ui-0.1.4.pkg

wget -q https://raw.githubusercontent.com/moscow-technologies/ag-blockchain/master/install/chain.json -O chain.json

parity signer new-token

parity --chain chain.json --bootnodes enode://1412ee9b9e23700e4a67a8fe3d8d02e10376b6e1cb748eaaf8aa60d4652b27872a8e1ad65bb31046438a5d3c1b71b00ec3ce0b4b42ac71464b28026a3d0b53af@212.11.151.122:30303,enode://9076c143a487aa163437a86f7d009f257f405c50bb2316800b9c9cc40e5a38fef5b414a47636ec38fdabc8a1872b563effa8574a7f8f85dc6bde465c368f1bf5@212.11.151.123:30303

open Parity\ UI
