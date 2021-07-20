pragma solidity >=0.4.26 < 0.7.2;
pragma experimental ABIEncoderV2;

import './StandardToken.sol';
import './ECRecovery.sol';
import './ChannelManagerContract.sol';

//State Channel Library
//moved to separate library to save gas
library ChannelLibrary {
    
    struct Data {
        uint close_timeout;
        uint settle_timeout;
        uint audit_timeout;
        uint opened;
        uint close_requested;
        uint closed;
        uint settled;
        uint audited;
        ChannelManagerContract manager;
    
        address sender;
        address receiver;
        address client;
        uint balance;
        address auditor;

        //state update for close
        uint nonce;
        uint completed_transfers;
    }

    struct StateUpdate {
        uint nonce;
        uint completed_transfers;
    }
    
    struct Allocation {
        address[] sender;
        // Outer dimension are assets, inner dimension are the participants.
        uint256[][] balances;
        SubAlloc[] locked;
    }

    struct SubAlloc {
        // ID is the channelID of the subchannel
        bytes32 ID; // solhint-disable-line var-name-mixedcase
        // balances holds the total balance of the subchannel of every asset.
        uint256[] balances;
    }
    

    modifier notSettledButClosed(Data storage self) {
        require(self.settled <= 0 && self.closed > 0);
        _;
    }

    modifier notAuditedButClosed(Data storage self) {
        require(self.audited <= 0 && self.closed > 0);
        _;
    }

    modifier stillTimeout(Data storage self) {
        require(self.closed + self.settle_timeout >= block.number);
        _;
    }

    modifier timeoutOver(Data storage self) {
        require(self.closed + self.settle_timeout <= block.number);
        _;
    }

    modifier channelSettled(Data storage self) {
        require(self.settled != 0);
        _;
    }

    modifier senderOnly(Data storage self) {
        require(self.sender == msg.sender);
        _;
    }

    modifier receiverOnly(Data storage self) {
        require(self.receiver == msg.sender);
        _;
    }

    /// @notice Sender deposits amount to channel.
    /// must deposit before the channel is opened.
    /// @param amount The amount to be deposited to the address
    /// @return Success if the transfer was successful
    /// @return The new balance of the invoker
    function deposit(Data storage self, uint256 amount) 
    senderOnly(self)
    returns (bool success, uint256 balance)
    {
        require(self.opened > 0);
        require(self.closed == 0);

        StandardToken token = self.manager.token();

        require (token.balanceOf(msg.sender) >= amount);

        success = token.transferFrom(msg.sender, this, amount);
    
        if (success == true) {
            self.balance += amount;

            return (true, self.balance);
        }

        return (false, 0);
    }

    function request_close(
        Data storage self
    ) {
        require(msg.sender == self.sender || msg.sender == self.receiver);
        require(self.close_requested == 0);
        self.close_requested = block.number;
    }

    function close(
        Data storage self,
        address channel_address,
        uint nonce,
        uint completed_transfers,
        bytes signature
    )
    {
        if (self.close_timeout > 0) {
            require(self.close_requested > 0);
            require(block.number - self.close_requested >= self.close_timeout);
        }
        require(nonce > self.nonce);
        require(completed_transfers >= self.completed_transfers);
        require(completed_transfers <= self.balance);
    
        if (msg.sender != self.sender) {
            //checking signature
            bytes32 signed_hash = hashState(
                channel_address,
                nonce,
                completed_transfers
            );

            address sign_address = ECRecovery.recover(signed_hash, signature);
            require(sign_address == self.sender);
        }

        if (self.closed == 0) {
            self.closed = block.number;
        }
    
        self.nonce = nonce;
        self.completed_transfers = completed_transfers;
    }

    function hashState (
        address channel_address,
        uint nonce,
        uint completed_transfers
    ) returns (bytes32) {
        return keccak256 (
            channel_address,
            nonce,
            completed_transfers
        );
    }

    /// @notice Settles the balance between the two parties
    /// @dev Settles the balances of the two parties fo the channel
    /// @return The participants with netted balances
    function settle(Data storage self)
        notSettledButClosed(self)
        timeoutOver(self)
    {
        StandardToken token = self.manager.token();
        
        if (self.completed_transfers > 0) {
            require(token.transfer(self.receiver, self.completed_transfers));
        }

        if (self.completed_transfers < self.balance) {
            require(token.transfer(self.sender, self.balance - self.completed_transfers));
        }

        self.settled = block.number;
    }

    function audit(Data storage self, address auditor)
        notAuditedButClosed(self) {
        require(self.auditor == auditor);
        require(block.number <= self.closed + self.audit_timeout);
        self.audited = block.number;
    }

    function validateTransfer(
        Data storage self,
        address transfer_id,
        address channel_address,
        uint sum,
        bytes lock_data,
        bytes signature
    ) returns (uint256) {

        bytes32 signed_hash = hashTransfer(
            transfer_id,
            channel_address,
            lock_data,
            sum
        );

        address sign_address = ECRecovery.recover(signed_hash, signature);
        require(sign_address == self.client);
    }

    function hashTransfer(
        address transfer_id,
        address channel_address,
        bytes lock_data,
        uint sum
    ) returns (bytes32) {
        if (lock_data.length > 0) {
            return keccak256 (
                transfer_id,
                channel_address,
                sum,
                lock_data
            );
        } else {
            return keccak256 (
                transfer_id,
                channel_address,
                sum
            );
        }
    }
}