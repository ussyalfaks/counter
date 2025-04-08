#[starknet::interface]
trait ICounter<T>{
    fn get_count(self: @T) -> u256;
    fn increase(ref self: T);
    fn decrease_count(ref self: T);
    fn reset_count(ref self: T);
}


#[starknet::contract]
mod Counter{
    use super::ICounter;
    use core::starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};
    // import the above ICounter trait
    #[storage]
    struct Storage{
        count: u256
    }


    #[abi(embed_v0)]
    impl ContractImpl of ICounter<ContractState>{

        fn get_count(self: @ContractState) -> u256{
            let current_count:u256 = self.count.read();
            current_count

        }
        fn increase(ref self: ContractState){
            let current_count = self.get_count();
            self.count.write(current_count + 1)

        }
        fn decrease_count(ref self: ContractState){
            let current_count = self.get_count();
            self.count.write(current_count - 1);
        }
        fn reset_count(ref self: ContractState){
            

        }

    }
}