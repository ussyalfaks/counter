#[starknet::interface]
trait ICounter<T> {
    fn get_count(self: @T) -> u256;
    fn increase(ref self: T);
    fn decrease_count(ref self: T);
    fn reset_count(ref self: T);
}

// check that isnt Address 0 

#[starknet::contract]
mod Counter {
    use core::starknet::ContractAddress;
    use core::starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};
    use super::ICounter;
    // import the above ICounter trait
    #[storage]
    struct Storage {
        count: u256,
        owner: ContractAddress,
    }


    #[abi(embed_v0)]
    impl ContractImpl of ICounter<ContractState> {
        fn get_count(self: @ContractState) -> u256 {
            let current_count: u256 = self.count.read();
            current_count
        }
        fn increase(ref self: ContractState) {
            let current_count = self.get_count();
            self.count.write(current_count + 1)
        }
        fn decrease_count(ref self: ContractState) {
            let current_count = self.get_count();
            self.count.write(current_count - 1);
        }
        fn reset_count(ref self: ContractState) {
            self.count.write(0)
        }
    }
}
