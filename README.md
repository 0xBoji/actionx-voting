## README

#### Create minter:
```

aptos init --profile minter

```

#### Create account:
```

aptos init --profile admin-account

```


#### Create nft-receiver:
```

aptos init --profile nft-receiver

```

### Update source code:

address will be like this source_addr = "0x19ce4969ac99e5d01f0be1413a8af3abc3143945372366765ef5e7eb25d1004e"

address will be like this admin_addr = "0xe17365770306373bb547e2204b556edd55debd01141b4935b9e4f092e3195cb0"

### Change the NFT collection settings in sources/minting.move

- Line 77. Replace hardcoded_pk with your admin-account public key (from config.yaml). 0x not required in front of the address.

- Line 82. Set the name of your NFT collection collection_name

- Line 83. Set the description of your NFT collection description

- Line 84. Set the meta description of your NFT collection collection_uri (based on (EIP-721)[https://eips.ethereum.org/EIPS/eip-721])

- Line 85. Set the name of your NFT token token_name

- Line 82 to 94. Set the name of your NFT collection token_uri (create admin-account)

- Line 83. Set the description of your NFT collection token_uri_filetype (create nft-receiver account)

- Line 84. Set the Unix timestamp of minting deadline expiration_timestamp (create nft-receiver account)

- Line 85. Set the public price of minting 1 NFT public_price (create nft-receiver account)

- Line 82 to 94. Set the presale price of minting 1 NFT presale_price (create admin-account)

- Line 83. Set the description of your NFT collection whitelist_addr (create nft-receiver account)

- Line 84. Set the description of your NFT collection royalty_points_denominator (create nft-receiver account)

- Line 85. Set the description of your NFT collection royalty_points_numerator (create nft-receiver account)


## Deploy nft collection smartcontract:

```
aptos move create-resource-account-and-publish-package --seed 12343 --address-name mint_nft --profile default 
```
