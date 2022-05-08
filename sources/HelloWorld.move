module Tee::HelloWorld {
    public fun hello_world(): bool {
        true
    }

    #[test]
    fun test_works() {
        use Std::Debug;
        let sum = b"Hello";
        Debug::print(&sum);
        assert!(hello_world(), 0);
    }
}
