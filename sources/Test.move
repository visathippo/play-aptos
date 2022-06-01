module 0x42::Test {
    struct Example has copy, drop { i: u64 }

    use Std::Debug;
    //    friend 0x42::AnotherTest;

    const ONE: u64 = 1;

    public fun print(x: u64) {
        let sum = x + ONE;
        let _ = Example { i: sum };
        Debug::print(&sum)
    }

    public fun add_param(x: u64) {
        x = x + 2;
        x = x + 4;
        print(x);
    }

    #[test]
    fun test_print() {
        print(4);
    }

    #[test]
    fun test_add() {
        add_param(4);
    }

}
