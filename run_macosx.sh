#!/usr/bin/env bash

which -s brew
if [[ $? != 0 ]] ;
then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi

brew tap paritytech/paritytech

if brew ls --versions parity > /dev/null;
then
  brew uninstall parity
fi

brew install parity --stable

if !(brew ls --versions wget > /dev/null;)
then
  brew install wget
fi

wget  -q https://raw.githubusercontent.com/moscow-technologies/ag-blockchain/master/parity/config/chain.json -O chain.json
parity ui --chain chain.json --bootnodes enode://9076c143a487aa163437a86f7d009f257f405c50bb2316800b9c9cc40e5a38fef5b414a47636ec38fdabc8a1872b563effa8574a7f8f85dc6bde465c368f1bf5@213.79.88.177:30303