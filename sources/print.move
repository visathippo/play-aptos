script {
    use Std::Debug;

    const ONE: u64 = 1;

    fun main(x: u64) {
        let sum = x + ONE;
        Debug::print(&sum)
    }


}
