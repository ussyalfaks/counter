#[starknet::interface]
trait ICounter<T> {
    fn get_count(self: @T) -> u256;
    fn increase(ref self: T);
    fn decrease_count(ref self: T);
    fn reset_count(ref self: T);
}
