pragma solidity >=0.4.26 < 0.7.2;

import './StandardToken.sol';
import "./ChannelContract.sol";
import './ChannelApi.sol';

contract ChannelManagerContract {

    event ChannelNew(
        address channel_address,
        address indexed sender,
        address client,
        address indexed receiver,
        uint close_timeout,
        uint settle_timeout,
        uint audit_timeout
    );

    event ChannelDeleted(
        address channel_address,
        address indexed sender,
        address indexed receiver
    );

    StandardToken public token;
    ChannelApi public channel_api;

    function ChannelManagerContract(address token_address, address channel_api_address) {
        require(token_address != 0);
        require(channel_api_address != 0);
        token = StandardToken(token_address);
        channel_api = ChannelApi(channel_api_address);
    }

    /// @notice Create a new channel from msg.sender to receiver
    /// @param receiver The address of the receiver
    /// @param settle_timeout The settle timeout in blocks
    /// @return The address of the newly created ChannelContract.
    function newChannel(
        address client, 
        address receiver, 
        uint close_timeout,
        uint settle_timeout,
        uint audit_timeout,
        address auditor
    )
        returns (address)
    {
        address new_channel_address = new ChannelContract(
            this,
            msg.sender,
            client,
            receiver,
            close_timeout,
            settle_timeout,
            audit_timeout,
            auditor
        );

        ChannelNew(
            new_channel_address, 
            msg.sender, 
            client, 
            receiver,
            close_timeout,
            settle_timeout,
            audit_timeout
        );

        return new_channel_address;
    }

    function auditReport(address contract_address, uint total, uint fraud) {
        ChannelContract ch = ChannelContract(contract_address);
        require(ch.manager() == address(this));
        address auditor = msg.sender;
        ch.audit(auditor);
        channel_api.applyRuntimeUpdate(ch.sender(), ch.receiver(), total, fraud);
    }
    
    function destroyChannel(address channel_address) {
        ChannelContract ch = ChannelContract(channel_address);
        require(ch.manager() == address(this));
        ChannelDeleted(channel_address,ch.sender(),ch.receiver());
        ch.destroy();
    }
}
