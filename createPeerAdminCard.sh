#!/bin/bash

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

Usage() {
	echo ""
	echo "Usage: ./createPeerAdminCard.sh [-h host] [-n]"
	echo ""
	echo "Options:"
	echo -e "\t-h or --host:\t\t(Optional) name of the host to specify in the connection profile"
	echo -e "\t-n or --noimport:\t(Optional) don't import into card store"
	echo ""
	echo "Example: ./createPeerAdminCard.sh"
	echo ""
	exit 1
}

Parse_Arguments() {
	while [ $# -gt 0 ]; do
		case $1 in
			--help)
				HELPINFO=true
				;;
			--host | -h)
                shift
				HOST="$1"
				;;
            --noimport | -n)
				NOIMPORT=true
				;;
		esac
		shift
	done
}

HOST=localhost
Parse_Arguments $@

if [ "${HELPINFO}" == "true" ]; then
    Usage
fi

# Grab the current directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -z "${HL_COMPOSER_CLI}" ]; then
  HL_COMPOSER_CLI=$(which composer)
fi

echo
# check that the composer command exists at a version >v0.16
COMPOSER_VERSION=$("${HL_COMPOSER_CLI}" --version 2>/dev/null)
COMPOSER_RC=$?

if [ $COMPOSER_RC -eq 0 ]; then
    AWKRET=$(echo $COMPOSER_VERSION | awk -F. '{if ($2<20) print "1"; else print "0";}')
    if [ $AWKRET -eq 1 ]; then
        echo Cannot use $COMPOSER_VERSION version of composer with fabric 1.2, v0.20 or higher is required
        exit 1
    else
        echo Using composer-cli at $COMPOSER_VERSION
    fi
else
    echo 'No version of composer-cli has been detected, you need to install composer-cli at v0.20 or higher'
    exit 1
fi

cat << EOF > DevServer_connection.json
{
    "name": "qupixnetwork",
    "x-type": "hlfv1",
    "x-commitTimeout": 300,
    "version": "1.0.0",
    "client": {
        "organization": "QupixMSP",
        "connection": {
            "timeout": {
                "peer": {
                    "endorser": "300",
                    "eventHub": "300",
                    "eventReg": "300"
                },
                "orderer": "300"
            }
        }
    },
    "channels": {
        "mychannel": {
            "orderers": [
                "18.207.200.78.qupixorderer.amazonaws.com"
            ],
            "peers": {
				"3.81.200.130.qupix.amazonaws.com": {}
            }
        }
    },
    "organizations": {
        "QupixMSP": {
            "mspid": "QupixMSP",
            "peers": [
                "3.81.200.130.qupix.amazonaws.com"
            ],
            "certificateAuthorities": [
                "ca.notary.com"
            ]
        }
    },
    "orderers": {
        "18.207.200.78.qupixorderer.amazonaws.com": {
            "url": "grpc://18.207.200.78:7050"
        }
    },
    "peers": {
        "3.81.200.130.qupix.amazonaws.com": {
            "url": "grpc://3.81.200.130:7051"
        }
    },
    ,
    "certificateAuthorities": {
        "ca.notary.com": {
            "url": "http://${HOST}:7054",
            "caName": "ca.notary.com"
        }
    }
}
EOF

PRIVATE_KEY=../GoWorkSpace/src/github.com/Multiledgers/MultiledgerAdminModule/Channel/crypto-config/peerOrganizations/qupix.amazonaws.com/users/Admin@qupix.amazonaws.com/msp/keystore/f25400012dcccce63e54b6651389f776facbed19043a4492d1c2eea0ad531967_sk
CERT=../GoWorkSpace/src/github.com/Multiledgers/MultiledgerAdminModule/Channel/crypto-config/peerOrganizations/qupix.amazonaws.com/users/Admin@qupix.amazonaws.com/msp/signcerts/Admin@qupix.amazonaws.com-cert.pem
if [ "${NOIMPORT}" != "true" ]; then
    CARDOUTPUT=/tmp/PeerAdmin@qupix.card
else
    CARDOUTPUT=PeerAdmin@qupix.card
fi

"${HL_COMPOSER_CLI}"  card create -p DevServer_connection.json -u PeerAdmin -c "${CERT}" -k "${PRIVATE_KEY}" -r PeerAdmin -r ChannelAdmin --file $CARDOUTPUT

if [ "${NOIMPORT}" != "true" ]; then
    if "${HL_COMPOSER_CLI}"  card list -c PeerAdmin@qupix > /dev/null; then
        "${HL_COMPOSER_CLI}"  card delete -c PeerAdmin@qupix
    fi

    "${HL_COMPOSER_CLI}"  card import --file /tmp/PeerAdmin@qupix.card
    "${HL_COMPOSER_CLI}"  card list
    echo "Hyperledger Composer PeerAdmin card has been imported, host of fabric specified as '${HOST}'"
    rm /tmp/PeerAdmin@qupix.card
else
    echo "Hyperledger Composer PeerAdmin card has been created, host of fabric specified as '${HOST}'"
fi
