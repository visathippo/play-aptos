address 0x42 {
module Counter {
    use Std::Signer;

    struct Counter has key { i: u64 }

    public fun publish(account: &signer, i: u64) {
        move_to(account, Counter{ i })
    }

    public fun get_count(addr: address): u64 acquires Counter {
        borrow_global<Counter>(addr).i
    }

    public fun increment(addr: address) acquires Counter {
        let c_ref = &mut borrow_global_mut<Counter>(addr).i;
        *c_ref = *c_ref + 1
    }

    public fun reset(account: &signer) acquires Counter {
        let c_ref = &mut borrow_global_mut<Counter>(Signer::address_of(account)).i;
        *c_ref = 0
    }

    public fun delete(account: &signer): u64 acquires Counter {
        let c = move_from<Counter>(Signer::address_of(account));
        let Counter { i } = c;
        i
    }

    public fun exist(addr: address): bool {
        exists<Counter>(addr)
    }

    #[test(a = @0x1)]
    fun publish_ok(a: signer) acquires Counter {
        use Std::Debug;
        publish(&a, 20);
        let k = get_count(@0x1);
        Debug::print(&k);
        assert!( k == 20, 0);
        increment(@0x1);
        let k = get_count(@0x1);
        Debug::print(&k);
        assert!( k == 21, 1);

        reset(&a);
        assert!( get_count(@0x1) == 0, 2);

        let i = delete(&a);
        assert!( i == 0, 3);
        assert!( !exist(Signer::address_of(&a)), 3);

    }

    #[test]
    fun exists_ok() {
        use Std::Debug;
        let k = exist(@0x1);
        Debug::print(&k);
        assert!( k == false, 0);
    }

    #[test(a = @0x2)]
    fun test_if_exist_ok(a: signer) acquires Counter{
        use Std::Debug;
        let addr = @0x2;
        if (exist(addr)) {
            increment(addr)
        } else {
            publish(&a, 20);
            increment(addr)
        };
        let k = get_count(addr);
        Debug::print(&k);
        assert!( k == 21, 0);
    }

}
}
