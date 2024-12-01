
Day1(.example).solve()

public struct Day1 {
    let inputType: InputType

    var inputFile: String {
        #file.getInputFile(for: inputType)
    }

    public init(_ inputType: InputType = .puzzle) {
        self.inputType = inputType
    }

    public func solve() -> Int {
        print(inputFile)
        return 0
    }
}
